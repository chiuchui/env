# install zsh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install zsh git
sudo chsh -s /bin/zsh

#install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo 'alias ll="ls -al"' >> ~/.zshrc

