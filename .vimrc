set encoding=utf8
syntax on

"required to load the indent and the ftplugin
filetype plugin on
filetype indent on

"While typing a search command, show where the pattern matches
setlocal incsearch
"When there is a previous search pattern, highlight all its matches
setlocal hlsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set wildmenu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set wildmode=longest,list:full 
set wildignore=*.pyc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"supertab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let  g:SuperTabDefaultCompletionType="context"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"improved status line
set laststatus=2
set statusline=%5.85f\ %=%16(\ %m%r[%{&filetype}]%)\ [%04l\ %03c][%4P]\ \|\ %{strftime('%H\:%M')}

" from http://dev.gentoo.org/~bass/configs/vimrc.html
" Adapt the status line accourding to the window
if has("autocmd")
au FileType qf
\ if &buftype == "quickfix" |
\ setlocal statusline=\ F5\ \[Compiler\ Messages\] |
\ setlocal statusline+=%=%2*\ %<%P |
\ endif

fun! FixMiniBufExplorerTitle()
  if "-MiniBufExplorer-" == bufname("%")
    "setlocal statusline=%2*%-3.3n%0*
    setlocal statusline=F4\ \[Buffers\]
    setlocal statusline+=%=%2*\ %<%P
  endif
endfun

au BufWinEnter *
\ let oldwinnr=winnr() |
\ windo call FixMiniBufExplorerTitle() |
\ exec oldwinnr . " wincmd w"
endif
call FixMiniBufExplorerTitle()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Settings for python files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python source ~/.vim/ftplugin/python/python.vim

" função para inserir cabeçalhos python
fun! BufNewFile_PY()
   normal(1G)
   :set ft=python
   :set ts=2
   call append(0, "# -*- coding: utf-8 -*-")
   call append(1, "# Criado em:" . strftime("%a %d/%m/%Y hs %H:%M"))
   call append(2, "# Autor: Marcos Daniel Petry - <marcospetry@gmail.com>")
   call append(4, "")
   normal gg
endfun
autocmd BufNewFile *.py call BufNewFile_PY()
map ,py :call BufNewFile_PY()<cr>A

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"if quickfix or minibuf is the lastwindow I want it closed
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter * call MyLastWindow()
function! MyLastWindow()
  " if the window is quickfix go on
  if &buftype=="quickfix"
    " if this window is last on screen quit without warning
    if winbufnr(2) == -1
      quit!
    endif
  endif
endfunction

"minibufexplorer will be opened even if there is only one buffer
let g:miniBufExplorerMoreThanOne=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"control up down to change between buffers
noremap <C-Down>  <C-W>j
noremap <C-Up>    <C-W>k
"changes the buffer in the current window to the next or the previous one
noremap <C-right> <ESC>:bn<CR>
noremap <C-left> <ESC>:bp<CR>
"# Toggle line numbers and fold column for easy copying:
nnoremap w<F2> :set nonumber!<CR>:set foldcolumn=0<CR>

