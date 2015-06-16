#!/bin/bash

# set time zone of virtual machine to Europe/Berlin
mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# add all necessary oracle groups
groupadd oinstall
groupadd dba
groupadd oper
groupadd asmadmin

# add user for oracle
useradd -p oracle -g oinstall -G dba,asmadmin,oper -s /bin/bash -m oracle

# set environment variables for the oracle user
#   - this is needed to be able to start the database with the user "oracle"
cp /vagrant/install/oracle/conf/bashrc_for_user_oracle /home/oracle/.bashrc

# create oracle install directories
mkdir -p /DBA/oracle/product/11.2.0.4/dbhome_1
mkdir -p /DBA/oracle/oraInventory

# change the permissions of the oracle install directories
chown -R oracle:oinstall /DBA
chmod -R 775 /DBA

# change location of the oracle inventory and set correct permissions
echo inventory_loc=/DBA/oracle/oraInventory > /etc/oraInst.loc
echo inst_group=oinstall >> /etc/oraInst.loc
chown oracle:oinstall /etc/oraInst.loc
chmod 777 /etc/oraInst.loc


# disable property requiretty to avoid an error during oracle installation
sed -i.bak s/Defaults\ \ \ \ requiretty/\#Defaults\ \ \ \ requiretty/g /etc/sudoers

sudo -u oracle bash << INSTALLSW
    . /home/oracle/.bashrc
    echo y | /vagrant/install/oracle/database/runInstaller -silent -responseFile /vagrant/install/oracle/customized_responsefiles/db_install.rsp 3>&1 | cat
INSTALLSW

log "--> --> run installation of oracle listener"
sudo -u oracle bash << INSTALLLISTENER
    . /home/oracle/.bashrc
    echo y | /DBA/oracle/product/11.2.0.4/dbhome_1/bin/netca -silent -responsefile /vagrant/install/oracle/customized_responsefiles/netca.rsp 3>&1 | cat
INSTALLLISTENER

log "--> --> run installation of oracle database"
sudo -u oracle bash << INSTALLDB
    . /home/oracle/.bashrc
    echo y | /DBA/oracle/product/11.2.0.4/dbhome_1/bin/dbca -silent -responsefile /vagrant/install/oracle/customized_responsefiles/dbca.rsp 3>&1 | cat
INSTALLDB

# enable property requiretty (default value)
cp /etc/sudoers.bak /etc/sudoers

# Auto Start and Stop for Oracle
echo ORADB:/DBA/oracle/product/11.2.0.4/dbhome_1:Y > /etc/oratab
cp /vagrant/install/oracle/scripts/oracle_starter.sh /etc/rc.d/init.d/oracle
chmod 755 /etc/rc.d/init.d/oracle
chkconfig --add oracle
chkconfig oracle on

