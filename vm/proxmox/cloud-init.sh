#! /bin/bash
# ubuntu 20.04, java application server

sudo apt install vim git curl zip unzip htop btop -y

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java 17.0.9-graalce
sdk install java 17.0.14-amzn
sdk install java 17.0.14-zulu 
sdk install gradle
sdk install maven


# filebeat
