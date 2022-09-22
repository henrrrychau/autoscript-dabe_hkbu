# COPYRIGHT: 
#!/bin/bash 

#############################################################################################################                                                                                            
# Description	:  A script written by HenryChau@HKBU for automatically installing Azure SQL Edge on Mac OS.                                                                                                                                                                          
# Author       	:  Henry Chau                                                
# Email         :  hinwaizau@gmail.com
# Github        :  https://github.com/henrrrychau                                           
#############################################################################################################

#Brew & Wget installation
echo "[!] Installing Brew & Wget..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install wget

echo "******* NOTICE:ROOT PRIVILEGE IS NEEDED *******"
echo "Please enter your password for MSSQL sa user (upper-or-lower-case alphabets, at least one symbol and one number should be contained e.g. password@123):"
read password
echo "Your SQL SA password is:"$password
echo "Please enter your container name(e.g. mssqledge):"
read containername
echo "Your container name is:"$containername

# Docker Desktop installation
echo "[!] Installing Docker Desktop..."
sudo wget -O ./docker.dmg --max-redirect=20 https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module
sudo hdiutil attach ./docker.dmg
sudo /Volumes/Docker/Docker.app/Contents/MacOS/install
sudo hdiutil detach /Volumes/Dockers

if [[ -z $(docker images | grep 'azure-sql-edge') ]]
then
    echo "Azure-SQL-Edge not installed! Pulling..."
    sudo docker pull mcr.microsoft.com/azure-sql-edge
fi

if [[ $(docker ps -a | grep $containername) ]]
then
    echo "Instance mssqledge found. Terminating..."
    sudo docker stop $containername
    sudo docker container rm $containername
fi

sleep 2

sudo docker run --cap-add SYS_PTRACE -e 'ACCEPT_EULA=1' -e "MSSQL_PID=Developer" -e 'MSSQL_SA_PASSWORD='$password -p 1401:1433 --name=$containername -d mcr.microsoft.com/azure-sql-edge

# Azure Data Studio installation
echo "[!] Installing Azure Data Studio..."
sudo wget -O ./azuresqlstudio.zip --max-redirect=20 https://go.microsoft.com/fwlink/?linkid=2204569
sudo unzip ./azuresqlstudio.zip