#!/bin/bash

BOLD="\033[0;1m"
END="\033[0m"

echo -e "${BOLD}Setting up mac...${END}"

# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"