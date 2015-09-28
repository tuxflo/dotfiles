set nocompatible " Use Vim defaults (much better!)
set ruler " show the cursor position all the time
set shell=zsh

" ignore whitespace in vimdiff
if &diff
  set diffopt+=iwhite
endif

" Show the filename in the window titlebar.
if exists("+title")
  set title
endif

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

set number

" toggle for "paste" & "nopaste"
set pastetoggle=<F2>

" enable mouse in all modes
if exists("+mouse")
  set mouse=a
endif

" Ignore case when searching
set ignorecase
set smartcase

" Makes search act like search in modern browsers
if exists("+incsearch")
  set incsearch
endif

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" keep a backup-file
set backup
if exists("+writebackup")
  set writebackup
  set backupdir=~/.vim/backups
endif

" centralize backups, swapfiles and undo history
set directory=~/.vim/swaps
if exists("+undodir")
  set undodir=~/.vim/undo
endif

" Don't backup files in temp directories or shm
if exists('&backupskip')
  set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
endif

" Don't keep swap files in temp directories or shm
if has('autocmd')
  augroup swapskip
    autocmd!
    silent! autocmd BufRead,BufNewFilePre
      \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
      \ setlocal noswapfile
  augroup END
endif


" don't keep undo files in temp directories or shm
if has('persistent_undo') && has('autocmd')
 augroup undoskip
   autocmd!
   silent! autocmd BufWritePre
     \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
     \ setlocal noundofile
  augroup END
endif

set undofile

" expand tabs to spaces
set expandtab

" insert spaces for tabs according to shiftwidth
if exists("+smarttab")
  set smarttab
endif

" does nothing more than copy the indentation from the previous line,
" when starting a new line
" info: if we active this, then we have trouble when we copy paste via mouse
if exists("+autoindent")
  set noautoindent
endif

" automatically inserts one extra level of indentation in some cases
if exists("+smartindent")
  set smartindent
endif

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2



filetype off

" Plugin settings

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'Yggdroot/indentLine'
Bundle 'gmarik/vundle'
Bundle 'digitaltoad/vim-jade'
Bundle 'othree/html5.vim'
Bundle 'bronson/vim-visual-star-search'
Bundle "scrooloose/nerdtree"
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''*vagrant'' --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'
let g:ctrlp_extensions = ['funky']
let g:ctrlp_open_multiple_files = '1ijr'
let g:ctrlp_use_caching = 1
let g:ctrlp_lazy_update = 350
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 0
" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''*vagrant'' --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

Bundle 'valloric/MatchTagAlways'
Bundle 'jwhitley/vim-matchit'
Bundle 'bling/vim-bufferline'

let g:bufferline_echo = 0
Bundle 'flazz/vim-colorschemes'
Bundle 'scrooloose/nerdcommenter'
Bundle 'gorodinskiy/vim-coloresque'
Bundle 'bling/vim-airline'

let g:airline_theme                           = 'molokai'
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tmuxline#enabled     = 0
let g:airline#extensions#bufferline#enabled   = 0
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#syntastic#enabled    = 1

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close vim and NERDTree if no file is open and we try to close vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

syntax on

filetype plugin indent on

" Return to last edit position when opening files (You want this!)
if has('autocmd')
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Remember info about open buffers on close
set viminfo^=%

set hidden

" Always show the status line
set laststatus=2

" Format the status line
set statusline=[%n]\ %<%f%m%r\ %w\ %y\ \ <%{&fileformat}>\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%=[%b\ 0x%02B]\ [%o]\ %l,%c%V\/%L\ \ %P

" Show current mode in the status line.
if exists("+showmode")
  set showmode
endif



" Mappings

map ( :bprevious<cr>
map ) :bnext<cr>

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w<cr>
nmap <leader>q :Bclose<cr>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" Yank and put system pasteboard with <Leader>y/p.
noremap <Leader>y "+y
noremap <Leader>Y "+y$
nnoremap <Leader>yy "+yy
noremap <Leader>p "+p
noremap <Leader>P "+P
noremap <Leader>wq :wq<cr>
" select all
map <Leader>a ggVG

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack

nnoremap <leader>- :NERDTreeToggle<CR>

" Helper function
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

