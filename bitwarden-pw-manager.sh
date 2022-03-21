#!/bin/bash

BOLD="\033[0;1m"
END="\033[0m"

echo -e "${BOLD}Setting up bitwarden...${END}"

brew update
brew install bitwarden-cli
