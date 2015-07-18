dotfiles_sync()
{
    # clone my dotfiles
    if [ ! -d "$HOME/dotfiles" ] ; then
	git clone git@github.com:hmit/dotfiles.git
    fi
    local day=`date +%-w`
    local prev=$(((($day+6))%7))
    local pref="$HOME/.sync_record"
    # daily pull from remote
    if [ ! -e "$pref.$day" ]; then
	pushd "$HOME/dotfiles" >/dev/null
	local lcl_commit_id=`git rev-parse HEAD`
	local remote_commit_id=`git ls-remote git@github.com:hmit/dotfiles.git master | cut -f1`
	if [ "$lcl_commit_id" != "$remote_commit_id" ]; then
	    git stash; git pull --rebase; git stash pop
	fi
	popd >/dev/null
	rm -rf "$pref".* 2>/dev/null
        touch "$pref.$day"
    fi

    # include .bashrc if it exists
    [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc"

    # symlink the required dot files; ignore .git, README and backup files
    local dot_file
    for dot_file in `ls -AB "$HOME/dotfiles"`
    do
	if [[ ! "$dot_file" = "emacs-lisp" ]] && [[ ! "$dot_file" = "#"* ]] && [[ ! "$dot_file" = *"~" ]] && [[ ! "$dot_file" = ".git"* ]] && [[ ! "$dot_file" == "README"* ]] && [ ! -e "$HOME/$dot_file" ] ; then
	    ln -v -s "$HOME/dotfiles/$dot_file" "$HOME"
	fi
    done
}

emacsd_sync()
{
    [ ! -d "$HOME/.emacs.d" ] && mkdir -p "$HOME/.emacs.d"
    local emacs_dir="$HOME/.emacs.d/lisp"
    [ ! -d "$emacs_dir" ] && mkdir -p "$emacs_dir"

    local emacs_pkgs
    declare -A emacs_pkgs
    emacs_pkgs[php-mode]="https://github.com/ejmr/php-mode.git"
    emacs_pkgs[mmm-mode]="https://github.com/purcell/mmm-mode.git"
    emacs_pkgs[json-snatcher]="https://github.com/Sterlingg/json-snatcher.git"
    emacs_pkgs[json-reformat]="https://github.com/gongo/json-reformat.git"
    emacs_pkgs[json-mode]="https://github.com/joshwnj/json-mode.git"
    emacs_pkgs[elpy]="https://github.com/jorgenschaefer/elpy.git"
    emacs_pkgs[powerline]="https://github.com/milkypostman/powerline.git"
    emacs_pkgs[git-gutter]="https://github.com/syohex/emacs-git-gutter.git"
    emacs_pkgs[solarized]="https://github.com/sellout/emacs-color-theme-solarized.git"
    emacs_pkgs[rainbow-delims]="https://github.com/Fanael/rainbow-delimiters.git"
    emacs_pkgs[ido-vertical-mode]="https://github.com/gempesaw/ido-vertical-mode.el.git"
    emacs_pkgs[dired-more]="https://github.com/Fuco1/dired-hacks.git"
    emacs_pkgs[auto-complete]="https://github.com/auto-complete/auto-complete.git"
    emacs_pkgs[company-mode]="https://github.com/company-mode/company-mode.git"
    emacs_pkgs[key-chord]="https://github.com/emacsmirror/key-chord.git"


    pushd "$emacs_dir" >/dev/null
    local i
    for i in "${!emacs_pkgs[@]}"
    do
	if [ ! -d "$i" ] ; then
	    git clone ${emacs_pkgs[$i]} "$i"
	fi
    done
    popd >/dev/null
}

dotfiles_sync
emacsd_sync
