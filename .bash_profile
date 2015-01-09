
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# clone my dotfiles
if [ ! -d "$HOME/dotfiles" ] ; then
    git clone git@github.com:hmit/dotfiles.git
fi

# sync with remote on every login
pushd "$HOME/dotfiles" >/dev/null
git stash; git pull --rebase; git stash pop 2>/dev/null
popd >/dev/null

# symlink the required dot files; ignore .git, README and backup files
for dot_file in `ls -AB "$HOME/dotfiles" -I '.git' -I 'README*'`
do
    if [ ! -e "$HOME/$dot_file" ] ; then
	ln -v -s "$HOME/dotfiles/$dot_file" -t "$HOME"
    fi
done
