"Rod Treweek
set nocompatible              " be iMproved, required
filetype off                  " required

" Let vim-plug manage things
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'stephpy/vim-yaml'
Plug 'gabrielelana/vim-markdown'
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'Shougo/neocomplete'
Plug 'tpope/vim-dispatch'
Plug 'voxpupuli/vim-puppet'
Plug 'w0rp/ale'
Plug 'nsf/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
call plug#end()

filetype plugin indent on    " required

:so ~/.vimrc.settings
