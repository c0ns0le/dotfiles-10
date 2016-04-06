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
