#!/bin/bash

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt update
apt upgrade

apt install zsh

x=1
while [ $x == 1 ]
do
  read -p "Do you want to set zsh as default shell? [y/n]: " defaultsh
  
  if [ ${defaultsh,,} == "n" ]
  then
    (( x++ ))
  
  elif [ ${defaultsh,,} == "y" ]
   then
    chsh -s $(which zsh)
    (( x++ ))
  
  else
    echo "Unknown input"  
  
  fi
done

x=1
while [ $x == 1 ]
do
  read -p "Do you want to install oh-my-zsh? [y/n]: " installomz
  
  if [ ${installomz,,} == "y" ]
  then
    apt install fonts-powerline
  elif [ ${installomz,,} == "n" ]
  then
    echo "Script execution finished successfully!"
    exit
  
  else
    echo "Unknown input"
  
  fi
done

if ! git > /dev/null;
then
  x=1
  while [ $x ==1 ]
  do
    read -p "Git is not installed! Install? [y/n]: " installgit
    
    if [ ${installgit,,} == "y" ]
    then
      apt install -y git
      (( x++ ))
    
    elif [ ${installgit,,} == "n" ]
    then
      echo "Operation cannot be completed without git. Please rerun the script or manualy install git!"
      exit
    
    else
      echo "Unknown input"
      
    fi
  done
fi 

git clone https://github.com/robbyrussell/oh-my-zsh.git
chmod +x oh-my-zsh/tools/install.sh
./oh-my-zsh/tools/install.sh

x=1
while [ $x == 1 ]
do
  read -p "Do you want to change the theme? [y/n]: " chtheme
  
  if [ ${chtheme,,} == "y" ]
  then
    echo "You can find all Themes on https://github.com/robbyrussell/oh-my-zsh/wiki/Themes"
    read -p "Which theme do you want to use? " themename
    sed -i -e 's/ZSH_THEME=.*/ZSH_THEME=\"$themename\"/g' ~/.zshrc
    
  elif [ ${chtheme,,} == "n" ]
  then
    echo "Script execution finished successfully!"
    exit
  
  else
    echo "Unknown input"
  
  fi
done