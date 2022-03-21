#!/bin/bash

BOLD="\033[0;1m"
RED="\033[0;31m"
END="\033[0m"

echo -e "${BOLD}Setting up java development with Intellij...${END}"

brew update
brew install openjdk
brew install --cask intellij-idea

if [ $? -ne 0 ]; then
    echo "${RED}Failed to install intellij with brew. This might happen if you've already installed the application but didn't use brew" 
fi
