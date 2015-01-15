""""""""""""""""""""""""""
" VUNDLE SETUP START
"
 set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()

 " let Vundle manage Vundle
 " required!
 Plugin 'gmarik/Vundle.vim'


 " My Plugins
 Plugin 'Lokaltog/vim-powerline'
 Plugin 'Lokaltog/powerline-fonts'
 Plugin 'trailing-whitespace'
 Plugin 'tpope/vim-fugitive'
 Plugin 'altercation/vim-colors-solarized'

 filetype plugin indent on     " required!
 "
 " Brief help
 " :PluginList          - list configured Plugins
 " :PluginInstall(!)    - install(update) Plugins
 " :PluginSearch(!) foo - search(or refresh cache first) for foo
 " :PluginClean(!)      - confirm(or auto-approve) removal of unused Plugins
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Plugin command are not allowed..

call vundle#end()

" VUNDLE SETUP END
""""""""""""""""""""""""""

syntax on

" Default Google Settings - Disabled on Mac
" source /usr/share/vim/google/google.vim

" Mouse and Numbering
set number
set mouse=a

" Tab handling
set expandtab
set shiftwidth=2
set softtabstop=2

" perforce commands
command! -nargs=* -complete=file PEdit :!g4 edit %
command! -nargs=* -complete=file PRevert :!g4 revert %
command! -nargs=* -complete=file PDiff :!g4 diff %

function! s:CheckOutFile()
 if filereadable(expand("%")) && ! filewritable(expand("%"))
   let s:pos = getpos('.')
   let option = confirm("Readonly file, do you want to checkout from p4?"
         \, "&Yes\n&No", 1, "Question")
   if option == 1
     PEdit
   endif
   edit!
   call cursor(s:pos[1:3])
 endif
endfunction
au FileChangedRO * nested :call <SID>CheckOutFile()

function! HighlightTooLongLines()
  highlight def link RightMargin Error
  if &textwidth != 0
    exec ('match RightMargin /\%<' . (&textwidth + 3) . 'v.\%>' . (&textwidth + 1) . 'v/')
  endif
endfunction

augroup filetypedetect
au WinEnter,BufNewFile,BufRead * call HighlightTooLongLines()
augroup END

" Highlight Search Results
set hlsearch

" Set Tab Movement
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>

" Set Tab movements ALT keys.
inoremap <M-Left> <Esc>:tabprev<CR>a
inoremap <M-Right> <Esc>:tabnext<CR>a
noremap <M-Left> <Esc>:tabprev<CR>
noremap <M-Right> <Esc>:tabnext<CR>

" Numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
au FocusLost * :set number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" This shows what you are typing as a command.  I love this!
set showcmd

command NoTrail %s/\s\+$//e

" Solarized Colorscheme
set background=dark
if has('gui_running')

else
  let g:solarized_termcolors=256
  set t_Co=256
endif
colorscheme solarized


" Powerline
if has('gui_running')
  set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
endif
set laststatus=2
set encoding=utf-8
"let g:Powerline_symbols = 'fancy'

" Color Column
set cc=121
