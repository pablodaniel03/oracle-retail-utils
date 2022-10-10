

apt update
apt upgrade -y

apt install -y build-essential
apt install -y libncurses-dev
apt install -y zsh tree bat fzy
apt install -y nodejs npm
apt install -y python3 python3-pip python3-dev

ln -s /usr/bin/python3 /usr/bin/python
ln -s /usr/bin/chardet3 /usr/bin/chardet



# Oh My ZSH Installation
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
echo -e "\n#### Zplug" >> ~/.zshrc
echo "source ~/.zplug/init.zsh" >> ~/.zshrc

# zsh-syntax-highlighting
#   https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
#   https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-completions
#   https://github.com/zsh-users/zsh-completions/blob/master/README.md
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

# K
#   https://github.com/supercrabtree/k
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/k

# git-flow-completion
#   https://github.com/bobthecow/git-flow-completion/blob/master/README.markdown
git clone https://github.com/bobthecow/git-flow-completion.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/git-flow-completion

# Enhanced CD command
#   https://github.com/b4b4r07/enhancd
git clone https://github.com/b4b4r07/enhancd ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-enhancd