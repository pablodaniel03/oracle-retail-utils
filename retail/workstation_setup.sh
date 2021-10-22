#!/usr/bin/bash

YUM="sudo yum"
DNF="sudo dnf"
SNAP="sudo snap"

YUM_INST_ALL="${YUM} install -y"
DNF_INST="${DNF} install -y"
DNF_MOD_INST="${DNF} module install -y"
SNAP_INST="${SNAP} install"

${YUM} update -y
${YUM} upgrade -y

${YUM_INST_ALL} https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
${DNF_INST} https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo dnf upgrade
dnf check-update


## Snap
${DNF_INST} snapd
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

# Glance
${SNAP_INST} glance --edge


${DNF_MOD_INST} python27 
# ${DNF_INST} python27-pip # Installed by python27

${DNF_MOD_INST} python39 
${DNF_INST} python39-pip

sudo alternatives --set python /usr/bin/python3.9
#sudo alternatives --set pip /usr/bin/pip3.9

#sudo ln -s /usr/bin/pip3 /usr/bin/pip
#sudo ln -s /usr/bin/python3 /usr/bin/python

${YUM_INST_ALL} ksh zsh
${YUM_INST_ALL} perl
${YUM_INST_ALL} htop
${YUM_INST_ALL} git
${YUM_INST_ALL} tree
${YUM_INST_ALL} ntfs-3g


## VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
${DNF_INST} code

## Broot
wget https://dystroy.org/broot/download/x86_64-linux/broot
sudo mv broot /usr/local/bin
sudo chmod +x /usr/local/bin/broot

## FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p