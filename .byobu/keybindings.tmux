# disable client detach on F6
unbind -n F6

# prefix setting
unbind-key -n C-a
set -qg prefix ^a
set -qg prefix2 ^b

# enable mouse support;
# TODO: enable mouse support somewhere; doesn't work right now
set -qg mouse-resize-pane on
set -qg mouse-select-pane on

# shorter repeats; allows to use arrow keys to move around in a pane right away!
# not using repeat functionality anyway
set -qg repeat-time 150
set -qg display-time 1500

# window colors
set -qwg window-status-current-attr default
set -qwg window-status-current-fg brightred
set -qwg window-status-activity-attr bold

# remap splits
unbind '\' # server kill earlier
unbind |
unbind -
bind '\' split-window
bind - split-window
bind | split-window -h

# pane options
# 150 ms is too short to view the display pane idx
set -qg display-panes-time 750

# pane options
unbind r
unbind q
unbind !
unbind z
unbind d
bind d displayp
bind q breakp
bind z resizep -Z

unbind j
unbind J
bind j command-prompt -p "join pane to:" "joinp -t '%%'"
bind J choose-window "joinp -t '%%'"

unbind s
unbind S
bind s command-prompt -p "join pane from:" "joinp -s '%%'"
bind S choose-window "joinp -s '%%'"

unbind k
unbind K
unbind C-k
bind k confirm-before -p "kill pane-#P? (y/n)" kill-pane
bind K confirm-before -p "kill all panes but current (#P)? (y/n)" "killp -a"
bind C-k confirm-before kill-window

# enable pipe-pane for long outputs; hack until i learn copy-mode
unbind C-p
bind C-p pipep -o 'mkdir ~/byobu-pipes; cat >>~/byobu-pipes/output.#I-#P' \; display-message "logging toggle to $HOME/byobu-pipes/output.#I-#P"

# remove session bindings from meta
unbind -n M-Left
unbind -n M-Right
unbind -n M-Up
unbind -n M-Down
unbind M-Left
unbind M-Right
unbind M-Up
unbind M-Down

# TODO: left, right bindings aren't working right now!
# possible explanation here: http://superuser.com/questions/660013/resizing-pane-is-not-working-for-tmux-on-mac
bind M-Left resizep -R 8
bind M-Right resizep -L 8
bind M-Up resizep -U 8
bind M-Down resizep -D 8
