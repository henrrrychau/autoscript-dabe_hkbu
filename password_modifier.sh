# COPYRIGHT: 
#!/bin/bash 

#############################################################################################################                                                                                            
# Description	:  A script written by HenryChau@HKBU for automatically installing Azure SQL Edge on Mac OS.                                                                                                                                                                          
# Author       	:  Henry Chau                                                
# Email         :  hinwaizau@gmail.com
# Github        :  https://github.com/henrrrychau                                           
#############################################################################################################


echo "******* NOTICE:ROOT PRIVILEGE IS NEEDED *******"
read -p "Please enter your password for MSSQL sa user (upper-case and lower-case letters and at least one symbol should be contained):" password
echo "Your SQL SA password is:"$password


if [[ -z $(docker images | grep 'azure-sql-edge') ]]
then
    echo "Azure-SQL-Edge not installed! Pulling..."
    sudo docker pull mcr.microsoft.com/azure-sql-edge
fi

if [[ $(docker ps -a | grep 'mssqledge') ]]
then
    echo "Instance mssqledge found. Terminating..."
    sudo docker stop mssqledge
    sudo docker container rm mssqledge
fi

sudo docker run --cap-add SYS_PTRACE -e "MSSQL_PID=Developer" -e 'ACCEPT_EULA=1' -e 'MSSQL_SA_PASSWORD='$password -p 1433:1401 --name mssqledge -d mcr.microsoft.com/azure-sql-edge

