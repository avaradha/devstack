#!/bin/bash

#################################################################################################################
# Author        : Aravindh Varadharaju
# Date          : 6th March 2014
# Description   : I was strugging with running the stack.sh file as a vagrant user. Though I run the file using
#                 "sudo su vagrant" the installation of devstack setup was failing with an error "/root/.my.cnf" 
#                 permission denied. I was looking for a solution and the below mentioned site had a solution to 
#                 run certain parts as root and certain parts as vagrant. This was really a blessing.
# Script source : http://stackoverflow.com/questions/16768777/can-i-switch-user-in-vagrant-bootstrap-shell-script
#################################################################################################################
case $(id -u) in
    0) 
        #echo "first: running as root"
        #echo "doing the root tasks..."

        sudo ufw disable
        sudo apt-get -q -y update
        sudo apt-get install -y git
        sudo apt-get install -y python-pip
        # sudo pip install -q netaddr
        git clone https://github.com/openstack-dev/devstack.git
        chown -R vagrant:vagrant devstack
        cd devstack
   
        # When creating the stack deployment for the first time,
        # you are going to see prompts for multiple passwords.
        # Your results will be stored in the localrc file.
        # If you wish to bypass this, and provide the passwords up front,
        # add in the following lines with your own password to the localrc file

        #echo '[[local|localrc]]' > localrc
        echo ADMIN_PASSWORD=1qaz2wsx > localrc
        echo MYSQL_PASSWORD=1qaz2wsx >> localrc
        echo RABBIT_PASSWORD=1qaz2wsx >> localrc
        echo SERVICE_PASSWORD=1qaz2wsx >> localrc
        echo SERVICE_TOKEN=1qaz2wsx >> localrc
        source localrc

        sudo -u vagrant -i $0  # script calling itself as the vagrant user
        ;;
    *) 
        #echo "then: running as vagrant user"
        #echo "doing the vagrant user's tasks"
        #echo "########################################"
        #echo "I going to run ./stack.sh as `whoami`"
        #echo "########################################"
        cd /home/vagrant/devstack
        ./stack.sh
        ;;
esac