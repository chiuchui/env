# install zsh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install zsh git
sudo chsh -s /bin/zsh

#install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#install zsh-completions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
sed -if 's/\(plugins=(.*\)/\1 zsh-completions/' ~/.zshrc
echo 'autoload -U compinit && compinit' >> ~/.zshrc

echo 'alias ll="ls -al"' >> ~/.zshrc
