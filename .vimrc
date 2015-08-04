" make Vim more useful
set nocompatible

" set the shell
set shell=zsh

map ( :bprevious<cr>
map ) :bnext<cr>
" Tell vim to use the .vim path first (colors and so)
set runtimepath=~/.vim,$VIMRUNTIME
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file (instead of '\')
let mapleader = ","
let g:mapleader = ","

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

" Sets how many lines of history VIM has to remember
set history=100

" ignore whitespace in vimdiff
if &diff
  set diffopt+=iwhite
endif

" enable filetype detection
filetype on

" enable filetype-specific plugins
filetype plugin on

" enable filetype-specific indenting
filetype indent on

" decrease timeout for faster insert with 'O'
set ttimeoutlen=100

" Try to detect file formats.
" Unix for new files and autodetect for the rest.
set fileformats=unix,dos,mac

" Show the filename in the window titlebar.
if exists("+title")
  set title
endif

" Fast saving
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>


" :W sudo saves the file
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" always show all line numbers
set number

" enhance command-line completion
if exists("+wildmenu")
  set wildmenu
  " type of wildmenu
  set wildmode=longest:full,list:full
endif

" (text) completion settings
set completeopt=longest,menuone

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif

" allow cursor keys in insert mode
set esckeys

" toggle for "paste" & "nopaste"
set pastetoggle=<F2>

" enable mouse in all modes
if exists("+mouse")
  set mouse=a
endif

" enable the popup menu
set mousem=popup

" Ignore case when searching
set ignorecase

" Use intelligent case while searching.
" If search string contains an upper case letter, disable ignorecase.
set smartcase


" Makes search act like search in modern browsers
if exists("+incsearch")
  set incsearch
endif

" For regular expressions turn magic on
set magic

" show the cursor position
if exists("+ruler")
  set ruler
endif

" Start scrolling at this number of lines from the bottom.
set scrolloff=2

" Start scrolling three lines before the horizontal window border.
set scrolloff=3

" Start scrolling horizontally at this number of columns.
set sidescrolloff=4

" enable line numbers
set number


" no annoying sound on errors
set noerrorbells
"set vb t_vb=""
set visualbell

" Show matching brackets when text indicator is over them
set showmatch

" Include angle brackets in matching.
set matchpairs+=<:>
" switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  try
    colorscheme molokai
  catch /^Vim\%((\a\+)\)\=:E185/
    " not available
  endtry

  " Visual line marking 80 characters (vim 7.3)
  if v:version >= 703
    set colorcolumn=80
  endif

  " Enable coloring for dark background terminals.
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif

  " settings for the molokai-colorscheme
  "let g:rehash256 = 1
  "let g:molokai_original = 1

  " turn on color syntax highlighting
  if exists("+syntax")
    syntax on
    " increases syntax accuracy
    syntax sync fromstart
  endif


  " set to 256 colors
  " set t_Co=256

  " Also switch on highlighting the last used search pattern.
  if exists("+hlsearch")
    set hlsearch
  endif

  " highlight current line
  "if exists("+cursorline")
    "set cursorline
  "endif

  " highlight trailing spaces in annoying red
  if has('autocmd')
    highlight ExtraWhitespace ctermbg=1 guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    if exists('*clearmatches')
      autocmd BufWinLeave * call clearmatches()
    endif
  endif

  " reload .vimrc when updating it
  if has("autocmd")
    autocmd BufWritePost .vimrc nested source %
  endif

  " highlight conflict markers
  match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

endif


" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
endif

" use UTF-8 without BOM
scriptencoding utf-8 nobomb
set termencoding=utf-8 nobomb
set encoding=utf-8 nobomb

" Use Unix as the standard file type
set ffs=unix,dos,mac

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

" Enable vim to remember undo chains between sessions (vim 7.3)
if v:version >= 703
  set undofile
endif

" don't keep viminfo for files in temp directories or shm
if has('viminfo')
  if has('autocmd')
    augroup viminfoskip
      autocmd!
      silent! autocmd BufRead,BufNewFilePre
        \ /tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
        \ setlocal viminfo=
    augroup END
  endif
endif

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

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" allow virtual edit in visual block ..
set virtualedit=block

" gI moves to last modification
nnoremap gI `.

nnoremap <(> :bnext<cr>

" Movement & wrapped long lines
" This solves the problem that pressing down jumps your cursor 'over' the curren
nnoremap j gj
nnoremap k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>


" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
if has('autocmd')
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2

" Format the status line
set statusline=[%n]\ %<%f%m%r\ %w\ %y\ \ <%{&fileformat}>\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%=[%b\ 0x%02B]\ [%o]\ %l,%c%V\/%L\ \ %P

" Show current mode in the status line.
if exists("+showmode")
  set showmode
endif

" Show the (partial) command as itâs being typed.
if exists("+showcmd")
  set showcmd
endif

" automatic commands
if has("autocmd")
  " file type detection

  " Ruby
  au BufRead,BufNewFile *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby

  " Ruby on Rails
  au BufRead,BufNewFile *.builder,*.rxml,*.rjs     set filetype=ruby

  " Rakefile
  au BufRead,BufNewFile [rR]akefile,*.rake         set filetype=ruby

  " Rantfile
  au BufRead,BufNewFile [rR]antfile,*.rant         set filetype=ruby

  " IRB config
  au BufRead,BufNewFile .irbrc,irbrc               set filetype=ruby

  " eRuby
  au BufRead,BufNewFile *.erb,*.rhtml              set filetype=eruby

  " Thorfile
  au BufRead,BufNewFile [tT]horfile,*.thor         set filetype=ruby

  " css - preprocessor
  au BufRead,BufNewFile *.less,*.scss,*.sass       set filetype=css syntax=css

  " markdown
  au BufRead,BufNewFile *.md,*.markdown,*.ronn     set filetype=markdown

  " special text files
  au BufRead,BufNewFile *.rtxt       set filetype=html spell
  au BufRead,BufNewFile *.stxt       set filetype=markdown spell

  au BufRead,BufNewFile *.sql        set filetype=pgsql

  au BufRead,BufNewFile *.rl         set filetype=ragel

  au BufRead,BufNewFile *.svg        set filetype=svg

  au BufRead,BufNewFile *.haml       set filetype=haml

  " aura cmp files
  au BufRead,BufNewFile *.cmp        set filetype=html

  au BufRead,BufNewFile *.json       set filetype=json syntax=javascript

  au BufRead,BufNewFile *.hbs        set syntax=handlebars

  au BufRead,BufNewFile *.mustache   set filetype=mustache

	au BufRead,BufNewFile *.zsh-theme  set filetype=zsh

  au Filetype gitcommit              set tw=68 spell
  au Filetype ruby                   set tw=80

  " allow tabs on makefiles
  au FileType make                   setlocal noexpandtab
  au FileType go                     setlocal noexpandtab
endif

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

" map Ctrl Backspace to delete word
imap <C-BS> <C-w>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" quickfix mappings
map <F7>  :cn<CR>
map <S-F7> :cp<CR>
map <A-F7> :copen<CR>

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" When you press gv you Ack after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position
map <leader>g :Ack

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

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
