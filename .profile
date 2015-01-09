# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ ! -d "$HOME/dotfiles" ] ; then
    git clone git@github.com:hmit/dotfiles.git
fi

pushd "$HOME/dotfiles" >/dev/null
git stash 2>/dev/null; git pull --rebase; git stash pop 2>/dev/null
popd >/dev/null

for dot_file in `ls -AB "$HOME/dotfiles" -I '.git' -I 'README*'`
do
    if [ ! -e "$HOME/$dot_file" ] ; then
	ln -v -s "$HOME/dotfiles/$dot_file" -t "$HOME"
    fi
done
