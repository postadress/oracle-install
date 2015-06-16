# oracle-install
Script to install Oracle Enterprise Edition 11.2.0.4 on a basic CentOS 64 bit system ("puphpet/centos65-x64") by using packer vagrant. This script 
use the oracle installation in silent mode. Therefore you will find predefined responsefiles.

```
database software = /install/oracle/customized_responsefiles/db_install.rsp
database instance = /install/oracle/customized_responsefiles/dbca.rsp
oracle listener   = /install/oracle/customized_responsefiles/netca.rsp
```

Feel free to change the default predefined properties.

## pre-requirements
Before you can install the vagrant box (including oracle software) you have to install the following software on your workstation.
- Virtualbox 4.3.22
- Vagrant 1.7.2

## preparation of installation
You have to download the setup files for the oracle software from the oracle website. This box is designed to 
use the oracle setup files for enterprise edition 11.2.0.4. In total you have to download 7 files.

```
p13390677_112040_Linux-x86-64_1of7.zip
p13390677_112040_Linux-x86-64_2of7.zip
p13390677_112040_Linux-x86-64_3of7.zip
p13390677_112040_Linux-x86-64_4of7.zip
p13390677_112040_Linux-x86-64_5of7.zip
p13390677_112040_Linux-x86-64_6of7.zip
p13390677_112040_Linux-x86-64_7of7.zip
```

Extract all Zip-Files into a temporary folder. After you have done this go into that folder and copy the contents of the database subdirectory into 

```
/install/oracle/database
```

At the end you should have the following directories

```
/install/oracle/database
  |_ install
  |_ response
  |_ rpm
  |_ sshsetup
  |_ stage
  |_ readme.html
  |_ runInstaller
  |_ welcome.html
```

## installation
  Open a command line and go into the folder where you have checkout the setup files of this repository. This have to be the folder where 
  the file "Vagrantfile" is located. Then start the installation of the vagrant box with the following command.

```
vagrant up
```
  
  Please visit the offical vagrant website for further detailed information of how to use start/stop/deinstall vagrant boxes. 
  
## how to access the database
```
HOST: localhost
SID: ORADB
Port: 1521

USER: SYSTEM
PASSWORD: ORADB
```





