## An automatic solution for DABE Students@HKBU

Since Microsoft SQL Server is not compatible with Mac OS and a number of students have been undergoing knotty problems during installation, an automatic solution is here for DABE students of HKBU to automatically configure Azure SQL Edge on Mac OS.

## Main files

* [install.sh](https://github.com/henrrrychau/autoscript-dabe_hkbu/blob/main/install.sh) is for downloading [Docker](https://www.docker.com/) and [Brew](https://brew.sh/) and initializing your Azure SQL Edge on Docker.
* [password_modifier.sh](https://github.com/henrrrychau/autoscript-dabe_hkbu/blob/main/password_modifier.sh) is for modifying SA password and reinitializing the Azure SQL Edge container. Please run this script only under that you've been all set.


## How to use

### For your first-time installation

1. Start a new terminal and enter the command below to install [Brew](https://brew.sh/) on your computer:
```
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
```

2. Once you have finished installing curl, continue to type the command below, which will run the script without downloading it on your computer:
```
curl -L https://raw.githubusercontent.com/henrrrychau/autoscript-dabe_hkbu/main/install.sh | bash
```


3. You will see this, which requires you to input your SA password:
```
Please enter your password for MSSQL sa user (upper-or-lower-case alphabets, at least one symbol and one number should be contained):
```
NOTICE: This line of prompt is different from ```Password:``` where your computer account password is required(__NOT THE PASSWORD FOR YOUR MSSQL SA USER__) and what you enter won't be displayed

### For altering your SA password

1. Start a new terminal and enter the command below to install [Brew](https://brew.sh/) on your computer:
```
curl -L https://raw.githubusercontent.com/henrrrychau/autoscript-dabe_hkbu/main/password_modifier.sh | bash
```

