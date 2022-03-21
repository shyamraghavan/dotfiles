#!/bin/bash

BOLD="\033[0;1m"
RED="\033[0;31m"
END="\033[0m"

echo -e "${BOLD}Setting up mac...${END}"

# Install Brew
echo "Do you wish to install homebrew? (you probably do if you don't already have it)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile; eval "$(/opt/homebrew/bin/brew shellenv)"; break;;
        No ) echo -e "${RED}We can't install other services without brew. Exiting.${END}"; exit;;
    esac
done

# Install TMUX
echo "Do you wish to install tmux? (most users don't require tmux)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) brew install tmux; break;;
        No ) break;;
    esac
done

# Install zsh and oh-my-zsh
echo "Do you wish to install zsh? (most users don't require zsh)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) brew install zsh; chsh -s /usr/local/bin/zsh; sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; break;;
        No ) break;;
    esac
done

# Install hammerspoon
echo "Do you wish to install hammerspoon for window automation? (most users don't require hammerspoon)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) brew install --cask hammerspoon; cp -R dotfiles/shyamra/hammerspoon ~/.hammerspoon
        No ) break;;
    esac
done