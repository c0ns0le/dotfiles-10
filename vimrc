set nocompatible              " be iMproved, required
"filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim' " manage vundle
Plugin 'scrooloose/nerdtree' " nerdtree
Plugin 'tpope/vim-fugitive' " fun with git
Plugin 'bling/vim-airline' " powerline
Plugin 'ekalinin/Dockerfile.vim' " docker syntax
Plugin 'nathanaelkane/vim-indent-guides' " indent guides
Plugin 'scrooloose/syntastic' " syntax
Plugin 'valloric/youcompleteme' " completion
Plugin 'tpope/vim-rails' " rails
Plugin 'tpope/vim-bundler' " bundler
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-endwise'
Plugin 'raimondi/delimitmate'
Plugin 'thaerkh/vim-workspace'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'sheerun/vim-polyglot'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

" Nerdtree config
map <C-n> :NERDTreeToggle<CR>

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256
" colours)
set t_Co=256

" Backups
set directory=~/.vim/swap        " keep swp files under ~/.vim/swap

" Set spacing
set expandtab
set shiftwidth=2
set softtabstop=2

" Enable NerdTree
autocmd vimenter * NERDTree

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
