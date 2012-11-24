"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{

augroup vim_folding
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Sets how many lines of history VIM has to remember
set history=700

" Enable Pathogen
call pathogen#runtime_append_all_bundles()

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
nnoremap <leader>e :e! $MYVIMRC<cr>
nnoremap <leader>ev :vs $MYVIMRC<cr>

" Key to reload .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase
set smartcase

set hlsearch

set incsearch 
set nolazyredraw "Don't redraw while executing macros 

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Transparency
set transparency=20
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
syntax enable

func! MySys()
  return "mac"
endfunc

" Set font according to system
if MySys() == "mac"
  set gfn=Monaco:h13
  set shell=/bin/bash
elseif mysys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  colorscheme vividchalk 
endif

set number

set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files, Backups and Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text, Tab and Indent Related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %y\ 
set statusline+=%=CWD:\ %r%{CurDir()}%h\ \ POS:\ %4l/%4L:%4c\ \  

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/Sunday', "~", "g")
    return curdir
endfunction
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
" Disable the annoying scrolling bar in the NERDTree window
set guioptions-=L 


:augroup NERDTreeAU
    autocmd!
    autocmd VimEnter * NERDTree
    autocmd TabEnter * NERDTreeMirror
    autocmd TabEnter * wincmd p
    autocmd VimEnter * wincmd p
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
:augroup END

nnoremap ` :call SwitchBetweenNERDTreeAndFile()<CR>
nnoremap ~ :call NERDTreeToggleMy()<CR>

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" This function toggles NERDTree and make sure the cursor is 
" in the main buffer
function! NERDTreeToggleMy()
    NERDTreeToggle
    wincmd p
endfunction

" This function switches the cursor between the currently edited
" file and NERDTree. 
function! SwitchBetweenNERDTreeAndFile()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) == winnr()
            wincmd l
        else
            wincmd h
        end
    end
endfunction
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CoffeeScript
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
hi link coffeeSpaceError NONE
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" EasyCompile
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
nnoremap <leader>r :call OneKeyRun()<CR>

function OneKeyRun()
    if &ft == 'ruby'
        setlocal makeprg=ruby\ %
    elseif &ft == 'python'
        setlocal makeprg=python\ %
    elseif &ft == 'cpp'
        setlocal makeprg=g++\ -o\ /tmp/vimtmp\ %\ &&\ /tmp/vimtmp
    else
        echom "OneKeyRun is not defined for filetype " . &ft
        return
    endif
    make
endfunction
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing Shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{
nnoremap <space><space> dd
inoremap jk <esc>

" Trainning purpose
inoremap <esc> <nop>

" Motion for parameter
onoremap p i(

" Shortcut for unhighlighting search
nnoremap <leader><cr> :noh<cr>

" Ctrl-A, Ctrl-E
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
nnoremap <c-a> I<esc>
nnoremap <c-e> A<esc>

" Ctrl-K
inoremap <c-k> <esc>d$A
nnoremap <c-k> d$

" Movements in wrapped lines
noremap k gk
noremap j gj
noremap 0 g0
noremap $ g$

" Indent shift
nnoremap <tab><tab> >>
" }}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" {{{


" }}}
