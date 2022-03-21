#!/bin/bash

BOLD="\033[0;1m"
RED="\033[0;31m"
END="\033[0m"

echo -e "${BOLD}Setting up development with VSCode...${END}"

brew update
brew install --cask visual-studio-code

if [ $? -ne 0 ]; then
    echo "${RED}Failed to install vscode with brew. This might happen if you've already installed the application but didn't use brew"
fi
