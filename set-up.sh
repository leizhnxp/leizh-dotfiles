#!/usr/bin/env bash

osname=$(uname)

ts=`date "+%Y%m%d%H%M%S"`
provision_dir=$(dirname $(readlink -f $0))
echo checking in set up entry $ts , provision location: $provision_dir

mkdir -p ~/opt
mkdir -p ~/bin

[[ $osname == "Linux" ]] && $provision_dir/set_up_linux.sh || $provision_dir/set_up_other.sh

[ -d ~/.vim/bundle/Vundle.vim ] && echo need not to clone Vundle || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

dotfiles_backup_dir=~/.backup/dotfiles-at-$ts/files
mkdir -p $dotfiles_backup_dir
echo dotfiles_backup_dir $dotfiles_backup_dir

refresh_dotfile(){
    echo handle symlink $1
    backup_dotfile $1
    ln -sf $provision_dir/dotfiles/$1 ~/.$1
}

backup_dotfile(){
    [ -f ~/.$1 ] && cp ~/.$1 $dotfiles_backup_dir/$1
}

refresh_dotfile vimrc
refresh_dotfile screenrc
#refresh_dotfile gitignore

git config --global core.editor vim

# setup my custom zsh content

[[ -d $ZSH_CUSTOM ]] && ln -sf $provision_dir/dotfiles/myzshrc.zsh $ZSH_CUSTOM/myzshrc.zsh || ln -sf $provision_dir/dotfiles/myzshrc.zsh $ZSH/custom/myzshrc.zsh

# only for bash
#curl -L https://raw.githubusercontent.com/juven/maven-bash-completion/master/bash_completion.bash -o ~/.maven_bash_completion.bash
#curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o ~/.docker-completion.sh
#curl -L https://raw.githubusercontent.com/git/git/v1.8.3.1/contrib/completion/git-completion.bash -o ~/.git-completion.bash
#

# should be refinement ...
#git config --global color.ui true
#git config --global core.autocrlf false
#git config --global core.safecrlf warn
#git config --global core.excludesfile ~/.gitignore
#git config --global push.default current
#
#mkdir -p ~/.vim
#
#if [ $osname == "Darwin" ]; then
#    refresh_dotfile bash_profile
#fi
#
#backup_dotfile bashrc
#grep "bashrc.my.sh" ~/.bashrc || printf "\nsource ~/dotfiles/files/bashrc.my.sh\n" >> ~/.bashrc
#
#
