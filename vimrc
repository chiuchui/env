set nu
set ai
set tabstop=4
set shiftwidth=4
set mouse=a 
set ruler
set backspace=2
set incsearch 
set ignorecase
set hlsearch
set cindent
set noexpandtab
set laststatus=2
set cursorline

filetype indent on

inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap { {}<ESC>i
inoremap ' ''<ESC>i
inoremap [ []<ESC>i

"Monokai color scheme
syntax enable
colorscheme monokai

