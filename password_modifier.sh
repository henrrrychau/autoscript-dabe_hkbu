# COPYRIGHT: 
#!/bin/bash 

#############################################################################################################                                                                                            
# Description	:  A script written by HenryChau@HKBU for automatically installing Azure SQL Edge on Mac OS.                                                                                                                                                                          
# Author       	:  Henry Chau                                                
# Email         :  hinwaizau@gmail.com
# Github        :  https://github.com/henrrrychau                                           
#############################################################################################################


echo "******* NOTICE:ROOT PRIVILEGE IS NEEDED *******"
echo "Please enter your password for MSSQL sa user (upper-or-lower-case alphabets, at least one symbol and one number should be contained e.g. password@123):"
read password
echo "Your SQL SA password is:"$password
echo "Please enter your container name(e.g. mssqledge):"
read containername
echo "This is the 
echo "Your OLD container name is (You can check it with 'docker ps'):"$containername


if [[ -z $(docker images | grep 'azure-sql-edge') ]]
then
    echo "Azure-SQL-Edge not installed! Pulling..."
    sudo docker pull mcr.microsoft.com/azure-sql-edge
fi

if [[ $(docker ps -a | grep $containername) ]]
then
    echo "Instance $containername found. Terminating..."
    sudo docker stop $containername
    sudo docker container rm $containername
fi

sleep 2

sudo docker run --cap-add SYS_PTRACE -e "MSSQL_PID=Developer" -e 'ACCEPT_EULA=1' -e 'MSSQL_SA_PASSWORD='$password -p 1401:1433 --name=$containername -d mcr.microsoft.com/azure-sql-edge

