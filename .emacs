(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))
;;
;; Add emacslib to path
;;

(setq home (getenv "HOME"))
(setq emacslib (concat home "/emacslib"))
(setq load-path (append (list (concat home "/emacslib"))
			(list (concat home "/.emacs.d"))
			(list (concat home "/.emacs.d/mmm-mode"))
                        load-path))

(setq custom-theme-load-path (append (list (concat home "/.emacs.d/solarized"))
				     custom-theme-load-path))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Require a final newline in a file, to avoid confusing some tools
(setq require-final-newline t)
(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq mustache-basic-offset 4)

(defun no-tabs-hook ()
  (setq c-basic-offset 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil))

;; let emacs use the system clipboard
(setq x-select-enable-clipboard t)

;; web-mode setup
(unless (fboundp 'prog-mode) (defalias 'prog-mode 'fundamental-mode))
(setq web-mode-html-offset 4)
(setq web-mode-css-offset 2)
(setq web-mode-script-offset 4)

(setq font-lock-maximum-decoration
      '((web-mode . 1)
        (js2-mode . 1)
        (python-mode . 1)
        (mustache-mode . 1)))

(autoload 'mustache-mode "mustache-mode" nil t)
(autoload 'js2-mode "js2" nil t)
(autoload 'web-mode "web-mode" nil t)
(autoload 'thrift-mode "thrift" nil t)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.thrift$" . thrift-mode))

(add-hook 'mustache-mode-hook 'no-tabs-hook)
(add-hook 'python-mode-hook 'no-tabs-hook)
(add-hook 'web-mode-hook 'no-tabs-hook)
(add-hook 'java-mode-hook 'no-tabs-hook)
(add-hook 'web-mode-user-hook 'no-tabs-hook)
;;(add-hook 'javascript-mode-hook 'js2-mode)
(add-hook 'css-mode-hook 'no-tabs-hook)
(add-hook 'thrift-mode-hook 'no-tabs-hook)
;;(add-hook 'js2-mode-hook 'no-tabs-hook)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;
;; Unique duplicate buffer names
;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; dont use tab (spaces instead)
(setq indent-tabs-mode nil)

;; Miscellaneous emacs mode stuff
(setq kill-whole-line t) ;; delete the new-line char too if at the start of the line
(setq vc-follow-symlinks nil)
(setq column-number-mode t)
(setq global-font-lock-mode t)
(setq adaptive-fill-mode t)
(setq paragraph-start paragraph-separate)
(setq next-screen-context-lines 5)
(setq mouse-scroll-delay .05)
(setq next-line-add-newlines nil)
(setq hilit-quietly t)
(setq inhibit-startup-message t)
(setq require-final-newline t)
(setq read-file-name-completion-ignore-case t)
(setq completion-auto-help t)
(setq sentence-end-double-space t)
(setq shell-pushd-dunique t)
(setq shell-pushd-tohome nil)
(setq comint-input-ring-size 128)
(setq comint-eol-on-send t)
(setq grep-command "grep --colour=never -n -e ")
(autoload 'hippie-expand "hippie-exp" "Try to expand text.") ;; Hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev try-expand-dabbrev-all-buffers try-complete-file-name))
(setq compile-window-height 20)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(setq scroll-preserve-screen-position t)

;; Key bindings
;;

;; explicit mappings to for special keys to overcome terminfo problems
(define-key esc-map "[1~" 'beginning-of-buffer)
(define-key esc-map "[7~" 'beginning-of-buffer)
(define-key esc-map "[4~" 'end-of-buffer)
(define-key esc-map "[8~" 'end-of-buffer)
(define-key esc-map "[1;4D" 'backward-word)
(define-key esc-map "[1;4C" 'forward-word)


(global-set-key "\M-h" 'hippie-expand)
(global-set-key [M-backspace] 'backward-kill-word)
(global-set-key "\r" 'newline-and-indent)
(global-set-key "\C-xl" 'ispell-complete-word)
(global-set-key "\C-xf" 'font-lock-fontify-buffer)
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-z" 'my-scroll-forward)
(global-set-key [backspace] 'backward-delete-char)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
(global-set-key [page up] 'scroll-up)
(global-set-key [page down] 'scroll-down)
(global-set-key "\C-\\" 'advertised-undo)
(global-set-key "\C-x\C-a" 'find-alternate-file)
(define-key esc-map "r" 'replace-regexp)
(define-key esc-map "g" 'goto-line)
(define-key ctl-x-map "t" 'find-tag)
(define-key ctl-x-map "\C-n" 'next-error)
(define-key ctl-x-map "\C-p" 'previous-error)
(define-key ctl-x-map "\C-z" 'save-buffers-kill-emacs)
(define-key esc-map "z" 'my-scroll-backward)
(define-key esc-map "Z" 'my-scroll-backward)
(define-key esc-map "w" 'copy-region-as-kill)
(define-key esc-map "W" 'copy-region-as-kill)
(define-key esc-map "=" 'my-shell)
(define-key ctl-x-map "d" 'delete-window)
(define-key ctl-x-map "D" 'delete-window)
(define-key ctl-x-map "g" 'enlarge-window)
(define-key ctl-x-map "G" 'enlarge-window)
(define-key ctl-x-map "s" 'shrink-window)
(define-key ctl-x-map "S" 'shrink-window)
(define-key ctl-x-map "4t" 'find-tag-other-window)
(define-key ctl-x-map "4T" 'find-tag-other-window)
(define-key esc-map "j" 'fill-paragraph)
(define-key esc-map "J" 'fill-paragraph)
(define-key esc-map "q" 'query-replace-regexp)
(define-key esc-map "Q" 'query-replace-regexp)
(define-key ctl-x-map "\C-i" 'insert-file)
(define-key ctl-x-map "2" 'my-split-window)
(define-key ctl-x-map "\C-m" 'write-modified-buffers)
(define-key global-map "\C-x=" 'buffer-info)
(define-key ctl-x-map ">" 'shift-region-right)
(define-key ctl-x-map "<" 'shift-region-left)
(define-key ctl-x-map "n" 'my-next-window)
(define-key ctl-x-map "p" 'my-previous-window)
(define-key esc-map "o" 'other-window)
(define-key esc-map "." 'find-tag-other-window)
(global-set-key (kbd "ESC p") 'backward-paragraph)
(global-set-key (kbd "ESC n") 'forward-paragraph)

;; turn off menu bar
(menu-bar-mode 0)

;; User defined functions to do various neat stuff
;;

;Make shell mode split the window.
;
(defun my-shell ()
  (interactive)
  (if (= (count-windows) 1)
      (progn (split-window)))
  (select-window (next-window))
  (shell))


(defun current-line-number ()
  "Returns the current line number, such that goto-line <n> would
go to the current line."
  (save-excursion
    (let ((line 1)
          (limit (point)))
      (goto-char 1)
      (while (search-forward "\n" limit t 40)
        (setq line (+ line 40)))
      (while (search-forward "\n" limit t 1)
        (setq line (+ line 1)))
      line)))

(defun buffer-info ()
  "Display information about current buffer."
  (interactive)
  (let* ((this-line (current-line-number))
         (total-lines (+ this-line (count-lines (point) (buffer-size))))
         (filename (or (buffer-file-name) (buffer-name))))
    (message (format "\"%s\" column %d, line %s/%s, char %d/%d (%d pct)."
                     (file-name-nondirectory filename)
                     (current-column)
                     this-line (1- total-lines)
                     (1- (point)) (buffer-size)
                     (/ (* 100.0 (1- (point))) (buffer-size))))))


(defun write-modified-buffers (arg)
  (interactive "P")
  (save-some-buffers (not arg)))

(defun end-of-window ()
  "Move point to the end of the window."
  (interactive)
  (goto-char (- (window-end) 1)))

(defun beginning-of-window ()
  "Move point to the beginning of the window."
  (interactive)
  (goto-char (window-start)))

(defun my-split-window ()
  (interactive)
  (split-window)
  (select-window (next-window)))

(defun my-scroll-forward (arg)
  "Scrolls forward by 1 or ARG lines."
  (interactive "p")
  (scroll-up (if (= arg 0) 1 arg)))

(defun my-scroll-backward (arg)
  "Scrolls forward by 1 or ARG lines."
  (interactive "p")
  (scroll-down (if (= arg 0) 1 arg)))

(defun my-next-window ()
  "moves to the window above the current one"
   (interactive)
   (other-window 1))

(defun my-previous-window ()
  "moves to the window above the current one"
   (interactive)
   (other-window -1))

(defun cdf ()
  "switches to *shell* and cd's to the current buffer's file dir."
  (interactive)
  (let ((shell-window (get-buffer-window "*shell*"))
        (fn (buffer-file-name)))
    (if shell-window
        (select-window shell-window)
      (my-shell))
    (switch-to-buffer "*shell*")
    (insert "cd " fn)
    (search-backward "/")
    (kill-line)
    (comint-send-input)))

(setq default-major-mode 'text-mode)
(setq-default truncate-lines nil)

;;replace occurences of a with b in path
(defun replace-char (path a b)
  (progn
    (while (string-match a path)
      (setq path (replace-match b t t path)))
    path))

;;Some shell stuff

(define-key ctl-x-map "!" 'shell-command)

(defun nuke-shell-buffer ()
  "clears the whole buffer without confirmation"
  (interactive)
  (delete-region (point-min) (point-max)))

(defun get-defaulted-arg-value (arg default)
  (if (consp arg)
      (car arg)
    (if (null arg)
        default
      arg)))

(defun shift-region-left (arg)
  (interactive "P")
  (let ((m (mark)) (p (point)) tmp)
    (if (< p m) (progn (setq tmp p) (setq p m) (setq m tmp)))
    (indent-rigidly m p (- (get-defaulted-arg-value arg 4)))))

(defun shift-region-right (arg)
  (interactive "P")
  (let ((m (mark)) (p (point)) tmp)
    (if (< p m) (progn (setq tmp p) (setq p m) (setq m tmp)))
    (indent-rigidly m p (get-defaulted-arg-value arg 4))))

(defun filter-region (&optional command)
  "Filter region through shell command."
  (interactive)
  (let* ((command (or command (read-input "Filter command: "))))
    (shell-command-on-region (point) (mark) command t)))

(defun replace-in-region-regexp (&optional old new)
  "Replace REGEXP with TO-STRING in region."
  (interactive)
  (let* ((old (or old (read-input "Replace regexp: ")))
         (new (or new (read-input (concat "Replace regexp: " old " with: ")))))
    (narrow-to-region (point) (mark))
    (beginning-of-buffer)
    (replace-regexp old new)
    (widen)))


(defun get-empty-buffer (name)
  (let ((b (get-buffer-create name)))
    (save-excursion
      (set-buffer b)
      (delete-region (point-min) (point-max)))
    b))

(defun save-position ()
  (cons (current-line-number) (current-column)))

(defun restore-position (state)
  (goto-line (car state))
  (move-to-column (cdr state)))

(put 'downcase-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((((class color) (min-colors 8)) (:foreground "orange" :weight bold))))
 '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "orange" :weight bold)))))
  ;; If there is more than one, they won't work right.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(git-gutter:added-sign "+")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "~")
 '(git-gutter:separator-sign "|")
 '(js2-auto-indent-p t)
 '(js2-cleanup-whitespace t)
 '(js2-enter-indents-newline t)
 '(js2-indent-on-enter-key t))

(defun py-compile()
  (compile (concat "python " (buffer-name))))

(defun get-todos ()
  (interactive)
  (multi-occur-in-matching-buffers ".*" "TODO:"))

(defun backward-kill-word-or-region ()
  "do backwards kill word or kill-region depending on whether there is an active region"
  (interactive)
  (if (and transient-mark-mode mark-active)
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(global-set-key (kbd "C-w") 'backward-kill-word-or-region)

;; load js2 mode when javascript mode loads
(add-hook 'javascript-mode-hook (lambda ()
                                  (js2-mode)))

;; make sure we get no tabs in js2
(setq js2-mode-hook
      '(lambda () (progn
                    (set-variable 'indent-tabs-mode nil))))


;; python linting helpers
(defun my-py-lint ()
  "execute pyflakes on the current buffer"
  (interactive)
  (compile (concat "pyflakes " (buffer-file-name))))

(defun my-py-breaking ()
  "execute pybreaking on the current buffer"
  (interactive)
  (compile (concat "pybreaking.py " (buffer-file-name))))

(add-hook 'python-mode-hook
          '(lambda ()
             (define-key python-mode-map (kbd "C-c p")
	       'my-py-lint)))

(add-hook 'python-mode-hook
          '(lambda ()
             (define-key python-mode-map (kbd "C-c P")
               'my-py-breaking)))
(setq compilation-auto-jump-to-first-error t)
(defun compile-autoclose (buffer string)
  (cond ((string-match "finished" string)
         (message "Compiled okay! Window closed.")
         (delete-window (get-buffer-window (get-buffer "*compilation*"))))
        (t (message "Compilation %s" string))))

(setq compilation-finish-functions 'compile-autoclose)
;; To use display buffer alist for this sort of task
;; (setq special-display-buffer-names "*compilation*")

(defun backward-kill-line (arg)
  "Kill 1 line backward"
  (interactive "p")
  (kill-line 0))
(global-set-key (kbd "M-k") 'backward-kill-line)

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
(setq ido-file-extensions-order '(".py" ".php" ".emacs" ".xml" ".el" ".ini" ".cfg" ".cnf"))
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(ido-mode t)
(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-\\") (kbd "C-c @ C-c"))
(require 'json-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)
(require 'php-mode)
(global-set-key "\M-x"
  (lambda () (interactive)
    (call-interactively (intern (ido-completing-read
    "M-x " (all-completions "" obarray 'commandp))))))
(show-paren-mode 1) ;; the setq is mode specific and hence doesn't work sometimes
(defun my-reload-init ()
  "reloads the profile file ~/.emacs"
  (interactive)
  (load-file (concat home "/.emacs")))
(global-set-key (kbd "M-R") 'my-reload-init)

(setq-default mode-line-format (list "%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position
 `(vc-mode vc-mode)
   "  " mode-line-modes mode-line-misc-info "- " system-name mode-line-end-spaces))

(add-hook 'after-init-hook 'global-git-gutter-mode)



;; (require 'powerline)
;; (powerline-default-theme)
(load-theme 'solarized t)
(setq frame-background-mode 'dark)
