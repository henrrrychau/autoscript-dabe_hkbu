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
brew install --cask docker
osascript -e 'quit app "Docker"'
open -a docker

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
echo "Do you need Azure Data Studio? (Please enter y or n):"
read ans
if [[ $ans == 'y' || $ans == 'Y' || $ans == 'yes' || $ans == 'YES' || $ans == 'Yes' ]]
then
    echo "[!] Installing Azure Data Studio..."
    sudo wget -O ./azuresqlstudio.zip --max-redirect=20 https://go.microsoft.com/fwlink/?linkid=2204569
    sudo unzip ./azuresqlstudio.zip && sudo mv ./"Azure Data Studio.app" /Applications/"Azure Data Studio.app" && sudo rm -rf ./azuresqlstudio.zip ./"Azure Data Studio.app"
    echo "Done!"
else
    echo "Done!"
fi
