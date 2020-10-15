#!/bin/bash

# this function is called when Ctrl-C is sent
function trap_ctrlc ()
{
    # perform cleanup here
    echo "Ctrl-C caught...performing clean up"
    echo "Doing cleanup"
    # exit shell script with error code 2
    # if omitted, shell script will continue execution
    exit 2
}
# initialise trap to call trap_ctrlc function
# when signal 2 (SIGINT) is received
trap "trap_ctrlc" 2

#Check if Homebrew is install

 if [[ $(command -v brew) == “” ]];then
                echo -n “Homebrew is not installed.Do you want to install? [Y/n]:”
                read answer
                if [ "$answer" != "${answer#[Yy]}" ] ;then
                     echo "Installing Homebrew..........."
                     ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
                else
                    exit
                fi
 else
                echo -n “Do you want to update your Homebrew? [Y/n]:”
                read answer
                if [ "$answer" != "${answer#[Yy]}" ] ;then
                    echo "Updating Homebrew........"
                    brew update
                else
                    exit
                fi
 fi


#Check if Node is installed
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}
testvercomp () {
    vercomp $1 $2
    case $? in
        0) op='=';;
        1) op='>';;
        2) op='<';;
    esac
    if [[ $op != $3 ]]
    then
        myresult='false'
    else
        myresult='true'
    fi
}
PREFFERED_NODE=10.15.5
getNodeVersion() {
    node --version
}
firstString=$(getNodeVersion)
secondString=""
removeV() {
    echo "${firstString/v/$secondString}"
}
INSTALLED_VERSION=$(removeV)
echo $INSTALLED_VERSION
echo $PREFFERED_NODE
testvercomp $INSTALLED_VERSION $PREFFERED_NODE '<'
echo $myresult
if which node > /dev/null;then
    if [ $myresult = 'true' ];then
        echo "The node version you installed is less than version 10,you need to update your node version.Do you want to update?[Y/n]:"
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
            echo "Installing Node........"
            brew install node@10
            echo "node version 10 has been installed."
        else
            echo "Exiting now ...."
        fi
    else
        echo "Node currently installed. skipping ..."
    fi
else
    echo "You did not have node installed.Do you want to install?[Y/n]:"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo "Installing Node......"
        brew install node@10
        echo "node version 10 has been installed."
    else
        exit
    fi
fi


#Check for Docker
dockertestvercomp () {
    vercomp $1 $2
    case $? in
        0) op='=';;
        1) op='>';;
        2) op='<';;
    esac
    if [[ $op != $3 ]]
    then
        myDockerresult='false'
    else
        myDockerresult='true'
    fi
}
PREFFERED_DOCKER=19.03.5
getDockerVersion() {
   docker -v
}
string=$(getDockerVersion)
echo $string
del=","
myresult2="${string%%$del*}"

firstString=$myresult2
secondString=""
removeTextPart() {
    echo "${firstString/Docker version /$secondString}"
}
INSTALLED_VERSION=$(removeTextPart)
echo "This is your installed version $INSTALLED_VERSION"

echo "Installed version: $INSTALLED_VERSION"
echo "Preffered version: $PREFFERED_DOCKER"
dockertestvercomp $INSTALLED_VERSION $PREFFERED_DOCKER '<'
echo $myDockerresult
if [ -x "$(command -v docker)" ]; then
     if [ $myresult = 'true' ];then
         echo "The docker version you installed is less than PREFFERED_DOCKER version,you need to update your Docker version.Do you want to update?[Y/n]:"
         read answer
         if [ "$answer" != "${answer#[Yy]}" ] ;then
             echo "Installing Docker........"
             brew install docker@19.03.5
             sudo apt-get install docker-ce docker-ce-cli containerd.io
             echo "docker is installed, skipping..."
         else
            echo "Exiting now..."
         fi
     else
        echo "Docker is currently installed"
     fi

else
    echo "You did not have docker installed.Do you want to install?[Y/n]:"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
         echo "Installing Docker......"
         brew install docker@19.03.5
         echo "Docker has been installed."
    else
        exit
    fi
fi



#Check if git installed

gittestvercomp () {
    vercomp $1 $2
    case $? in
        0) op='=';;
        1) op='>';;
        2) op='<';;
    esac
    if [[ $op != $3 ]]
    then
        myGitresult='false'
    else
        myGitresult='true'
    fi
}
PREFFERED_GIT=2.23.0
getGitVersion() {
   git version
}
mystring=$(getGitVersion)
echo $mystring
del=","
myresult3="${mystring%%$del*}"

firstString1=$myresult3
secondString=""
textPartremoved() {
    echo "${firstString1/git version /$secondString}"
}
VERSION_INSTALLED=$(textPartremoved)
#echo "here12"
echo "This is your installed version $VERSION_INSTALLED"
PREFFERED_GIT=2.23.0

#echo "here13"
echo "Installed version: $VERSION_INSTALLED"
echo "Preffered version: $PREFFERED_GIT"
gittestvercomp $VERSION_INSTALLED $PREFFERED_GIT '<'
echo $myGitresult
if which git > /dev/null;then
     if [ $myresult = 'true' ];then
          echo "The git version you installed is less than version PREFFERED_GIT,you need to update your git version.Do you want to update?[Y/n]:"
          read answer
          if [ "$answer" != "${answer#[Yy]}" ] ;then
               echo "Installing Git........"
               brew install git@2
               echo "git has been installed."
          else
              echo "Exiting now..........."
          fi
     else
         echo "git installed"
      fi

else
    echo "You did not have git installed.Do you want to install?[Y/n]:"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
         echo "Installing Git......"
         brew install git
         echo "git has been installed."
     else
        exit
     fi
fi


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
#echo "Installing Kubectl........"
#brew install kubectl

#To start minikube
echo "You are deleting minikube"
  minikube delete
echo "minikube starting............"
 minikube start
 #To get running pods
kubectl get pods
GET_PODS='kubectl get pods'
if [ -z "$GET_PODS" ]
then
      echo "\$GET_PODS is empty"
else
      echo "get pods test passed!"
fi

#To get SVC
GET_SVC='kubectl get svc'
if [ -z "$GET_SVC" ]
then
      echo "\$GET_SVC is empty"
else
      echo "get svc test passed!"
fi

#To get Running Deployment
GET_DEPLOYMENT='kubectl get deployment'
if [ -z "$GET_DEPLOYMENT" ]
then
      echo "\$GET_DEPLOYMENT is empty"
else
      echo "get svc test passed!"
fi

#To clone a project from github

echo -n "Enter Project Name: "
 read PROJECT_NAME
 PROJECT_NAME=$PROJECT_NAME


echo -n "Enter Github URL: "
 read url 
 URL=$url 

 git clone ${URL} ${PROJECT_NAME}


