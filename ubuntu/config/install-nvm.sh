#!/bin/bash

# Source https://tecadmin.net/how-to-install-nvm-on-ubuntu-20-04/
touch ~/.bashrc
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 

source ~/.bashrc

nvm install 14