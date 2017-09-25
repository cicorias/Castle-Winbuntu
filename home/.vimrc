" Let vim-plug manage things
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline'
Plug 'gabrielelana/vim-markdown'
Plug 'morhetz/gruvbox'
Plug 'godlygeek/tabular'
Plug 'lifepillar/vim-mucomplete'
Plug 'PProvost/vim-ps1'
Plug 'tpope/vim-fugitive'
Plug 'rodjek/vim-puppet'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
call plug#end()

:so ~/.vimrc.settings
