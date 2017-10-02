" Let vim-plug manage things
call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'gabrielelana/vim-markdown'
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular'
Plug 'lifepillar/vim-mucomplete'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'fatih/vim-go'
Plug 'davidhalter/jedi-vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'docker/docker'
Plug 'vim-scripts/bash-support.vim'
Plug 'tpope/vim-commentary'

call plug#end()

:so ~/.vimrc.settings
