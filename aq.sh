#!/bin/bash
echo "Setting Up AQ and installing packages......................................................................"
# Check to see if Homebrew is installed, and install it if it is not

PREFFERED_BREW='Homebrew 2.5.2'
INSTALLED_BREW='brew -v'
 if [[ $(command -v brew) == “” ]];then
                if [$INSTALLED_BREW -lt $PREFFERED_BREW]
                then
                echo "The brew version you installed is less than $PREFFERED_BREW,you need to update your brew version.Do you want to update?[Y/n]:"
                read answer
                if [ "$answer" != "${answer#[Yy]}" ] ;then
                echo "Installing Homebrew..........."
                  ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
                else
                  echo "node version $INSTALLED_BREW is installed."
                fi
  else  
     echo "You did not have brew installed.Do you want to install?[Y/n]:"
     read answer
     if [ "$answer" != "${answer#[Yy]}" ] ;then
     echo "Installing Home Brew......"
     ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
     echo "node version 10 has been installed."
     else
        exit
     fi
fi



#Check to see if Node is installed, and install it if is not not

PREFFERED_NODE=v10.16.0
INSTALLED_NODE='node -v'
if which node > /dev/null
    then
    if [$INSTALLED_NODE -lt $PREFFERED_NODE]
    then
      echo "The node version you installed is less than version 10,you need to update your node version.Do you want to update?[Y/n]:"
      read answer
      if [ "$answer" != "${answer#[Yy]}" ] ;then
      echo "Installing Node........"
      brew install node@10
      echo "node version 10 has been installed."
      else
         echo "node version $INSTALLED_NODE is installed, skipping..."
      fi

else
  echo "You did not have node installed.Do you want to install?[Y/n]:"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ] ;then
  echo "Installing Node......"
  brew install node@10
  echo "node version 10 has been installed."
fi



#Check to see if Docker is installed, and install it if is not not

INSTALLED_DOCKER='docker version'
PREFFERED_DOCKER=19.03.5
if [ -x "$(command -v docker)" ]; then
    if [$INSTALLED_NODE -lt $PREFFERED_NODE]
    then
    echo "The docker version you installed is less than version $PREFFERED_DOCKER,you need to update your Docker version.Do you want to update?[Y/n]:"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing Docker........"
    brew install docker
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    else
    echo "brew version $INSTALLED_DOCKER is installed, skipping..."
    fi
else
  echo "You did not have brew installed.Do you want to install?[Y/n]:"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ] ;then
  echo "Installing Node......"
  brew install docker
  echo "node version $INSTALLED_DOCKER has been installed."
fi



#Check to see if Git is installed, and install it if is not install.

PREFFERED_GIT=git version 2.28.0
INSTALLED_GIT='git version'
if which git > /dev/null
    then
    if [$INSTALLED_GIT -lt $PREFFERED_GIT]
    then
      echo "The git version you installed is less than version $PREFFERED_GIT,you need to update your git version.Do you want to update?[Y/n]:"
      read answer
      if [ "$answer" != "${answer#[Yy]}" ] ;then
      echo "Installing Git........"
      brew install git
      echo "git has been installed."
      else
         echo "git version $INSTALLED_GIT is installed, skipping..."
      fi

else
  echo "You did not have git installed.Do you want to install?[Y/n]:"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ] ;then
  echo "Installing Git......"
  brew install git
  echo "git has been installed."
fi


#To install minikube,virtualbox have to be installed.
#To install virtualbox
if ! type "virtualbox" > /dev/null; then
  brew cask install virtualbox;
else
  echo "virtualbox is already installed."
  vboxmanage --version
fi


#Installing minikube to your machine
echo "Installing minikube.........."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && \
chmod +x minikube && \
sudo mv minikube /usr/local/bin/

#Installing Kubectl
echo "Installing Kubectl........"
brew install kubectl

#To start minikube
echo "You are deleting minikube"
  minikube delete
echo "minikube starting............"
 minikube start
# To get running pods
#kubectl get pods
#GET_PODS='kubectl get pods'
#if [ -z "$GET_PODS" ]
#then
#      echo "\$GET_PODS is empty"
#else
#      echo "get pods test passed!"
#fi

#To get SVC
#GET_SVC='kubectl get svc'
#if [ -z "$GET_SVC" ]
#then
#      echo "\$GET_SVC is empty"
#else
#      echo "get svc test passed!"
#fi

#To get Running Deployment
#GET_DEPLOYMENT='kubectl get deployment'
#if [ -z "$GET_DEPLOYMENT" ]
#then
#      echo "\$GET_DEPLOYMENT is empty"
#else
#      echo "get svc test passed!"
#fi

#To clone a project from github

#echo -n "Enter Project Name: "
# read PROJECT_NAME
# PROJECT_NAME=$PROJECT_NAME

          
#echo -n "Enter Github URL: "
# read url  
# URL=$url 
        
# git clone ${URL} ${PROJECT_NAME}
#EOF
