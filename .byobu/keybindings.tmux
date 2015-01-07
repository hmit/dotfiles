# prefix setting
unbind-key -n C-a
set -qg prefix ^a
set -qg prefix2 ^b

# enable mouse support; doesn't work right now---enable mouse support somewhere
set -qg mouse-resize-pane on
set -qg mouse-select-pane on

# shorter repeats; allows to use arrow keys to move around in a pane right away!
set -qg repeat-time 150

# window colors
set -qwg window-status-current-attr default
set -qwg window-status-current-fg brightred
set -qwg window-status-activity-attr bold

# disable a bunch of kill options
unbind '\' # server kill

# remap to vertical split
bind '\' split-window -h

# pane options
# 150 ms is too short to view the display pane idx
set -qg display-panes-time 750

# pane options
unbind r
bind r displayp
unbind q
bind q breakp
unbind !
unbind z
bind z resizep -Z
unbind J
unbind j
bind J command-prompt -p "join pane to:" "joinp -t '%%'"
bind j command-prompt -p "join pane to:" "joinp -t '%%'"
unbind S
unbind s
bind S command-prompt -p "join pane from:" "joinp -s '%%'"
bind s command-prompt -p "join pane from:" "joinp -s '%%'"
unbind k
bind k confirm-before kill-pane
# debug: the following is not working for some reason
unbind K
bind K confirm-before -p "kill all panes but current (#P)? (y/n)" "killp -a"
unbind C-k
bind C-k confirm-before kill-window
# enable pipe-pane for long outputs; hack until i learn copy-mode
unbind C-p
bind C-p pipep -o 'cat >>~/output.#I-#P'

# remove session bindings from meta
unbind -n M-Left
unbind -n M-Right
unbind -n M-Up
unbind -n M-Down
unbind M-Left
unbind M-Right
unbind M-Up
unbind M-Down

bind M-Left resizep -R 8
bind M-Right resizep -L 8
bind M-Up resizep -U 8
bind M-Down resizep -D 8
# disable client detach on F6 and prefix d
unbind d
unbind -n F6
