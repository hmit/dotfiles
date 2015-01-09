# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

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
rm .*~ 2>/dev/null
rm *~ 2>/dev/null
git stash; git pull --rebase; git stash pop 2>/dev/null
popd >/dev/null

# symlink the required dot files; ignore .git, README and backup files
for dot_file in `ls -AB "$HOME/dotfiles"`
do
    if [ ! "$dot_file" == ".git" ] && [[ ! "$dot_file" == "README"* ]] && [ ! -e "$HOME/$dot_file" ] ; then
	ln -v -s "$HOME/dotfiles/$dot_file" "$HOME"
    fi
done

if [ -d "$HOME/.emacs.d" ] ; then
    mkdir -p "$HOME/.emacs.d"
fi

declare -A emacs_pkgs
emacs_pkgs[php-mode]="git@github.com:ejmr/php-mode.git"
emacs_pkgs[mmm-mode]="git@github.com:purcell/mmm-mode.git"
emacs_pkgs[json-snatcher]="https://github.com/Sterlingg/json-snatcher.git"
emacs_pkgs[json-reformat]="https://github.com/gongo/json-reformat.git"
emacs_pkgs[json-mode]="https://github.com/joshwnj/json-mode.git"
emacs_pkgs[elpy]="git@github.com:jorgenschaefer/elpy.git"

pushd "$HOME/.emacs.d" >/dev/null
for i in "${!emacs_pkgs[@]}"
do
    if [ ! -d "$i" ] ; then
	git clone ${emacs_pkgs[$i]}
	ln -s "$i/$i.el" "$HOME/.emacs.d/"
    fi
done
popd >/dev/null
