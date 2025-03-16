#! /bin/bash
# ubuntu 20.04, java application server

sudo apt install git curl zip unzip htop btop -y

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

sdk install java
sdk install gradle
sdk install maven


# filebeat
