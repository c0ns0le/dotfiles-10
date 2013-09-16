" .vimrc

" Use Pathogen for plugins

" Enable filetype plugin
filetype indent on
filetype plugin on
syntax on

"
" General
set encoding=utf8
set nocompatible
set t_Co=256

"
" Colors
set background=light
colorscheme elflord

"
" Gui Options
if has("gui")
  set guifont=Source\ Code\ Pro:h14
  set gfn=Source\ Code\ Pro:h14
  set guioptions+=i  " show Vim icon in Taskbar
  set guioptions-=a  "remove autoselect
  set guioptions-=A  "remove autoselect
  set guioptions-=m  "remove menu bar
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=l  "remove left-hand scroll bar
  set guioptions-=R  "remove right-hand scroll bar if there is a vertical split
  set guioptions-=L  "remove left-hand scroll bar if there is a vertical split
else
  " set mousehide
  " set mouse=a
  " set ttymouse=xterm2
endif

"
" Text Format
set ai
set si
set wrap
set autoread
set softtabstop=2
set shiftwidth=2
set tabstop=2
set shiftround             " round > and < to nearest shiftwitdh
set expandtab              " expand tabs to spaces
set smarttab               " insert blanks according to shiftwidth, tabstop, etc
set virtualedit=block      " allow virtual edit in visual block ..

"
" UI
set backspace=eol,start,indent
set cursorline
set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
"set redraw
set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
" set ch=2                   " command line height
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set showmode
set statusline=%F%m%r%h%w\ %#LineNr#%#StatusLine#\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set scrolloff=3
"set ttyfast
"set showcmd                " Show (partial) command in status line.
set nofoldenable
"set report=0               " report when > 0 lines changed by command
set completeopt=longest,menuone

setlocal comments-=:#
set hidden              " Enable 'hidden' buffers

"
" Backups
set directory=~/.vim/swap        " keep swp files under ~/.vim/swap

"
" Searching
set hlsearch               " highlight searches
set incsearch              " do incremental searching
set ignorecase             " ignore case when searching
set smartcase              " ... unless ther's a cApItOl"

"
"  Highlight
"highlight Comment         ctermfg=DarkGrey guifg=#444444
highlight StatusLineNC    ctermfg=Black    ctermbg=DarkGrey cterm=bold
highlight StatusLine      ctermbg=Black    ctermfg=LightGrey
highlight SpecialKey      ctermfg=DarkGray ctermbg=Black

"
" Highlight Trailing Whitespace
set list
set listchars=tab:»·,trail:·
"set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
"set showbreak=↪

"
" Visual Cues
set mat=2
set showmatch
set laststatus=2
set visualbell



" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"
" Disable autocompletion popup.
let g:AutoComplPop_NotEnableAtStartup = 1

"----- viewoutput configuration
let g:viewoutput_newbuffer="bot 5new"

map <C-c> <Plug>Traditionalj

"
" Make JSON readable.
map <leader>j :%!perl -MJSON -e 'local $/; my $j =JSON->new(); print $j->pretty()->encode($j->decode(<>));'<CR>


"
" Printing Options
set printoptions=header:2,syntax:a,number:y,wrap:y,duplex:long,collate:y,jobsplit:y,paper:letter

" ---------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ---------------------------------------------------------------------------
function! StripWhitespace ()
    exec ':%s/ \+$//gc'
endfunction
map ,s :call StripWhitespace ()<CR>

" ---------------------------------------------------------------------------
"  Type specific things
" ---------------------------------------------------------------------------
au BufRead,BufNewFile *.md       set wrap linebreak spell filetype=markdown
au BufRead,BufNewFile *.markdown set wrap linebreak spell filetype=markdown
au BufRead,BufNewFile *pf.conf*  set filetype=pf
au BufRead,BufNewFile *.py       set softtabstop=4 shiftwidth=4 tabstop=4
au FileType gitcommit DiffGitCached | wincmd j
au BufRead $HOME/.mutt/temp* set syntax=mail
