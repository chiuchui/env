" ======Vim-plug settings=====
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" 標籤展示以及快速跳轉(增強vim的書籤功能)
Plug 'kshenoy/vim-signature'

" vim起始頁插件 可顯示最近使用文件等等
Plug 'mhinz/vim-startify'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colorscheme
" Plug 'morhetz/gruvbox'
" Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'

Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'tpope/vim-commentary'

" 語法檢查
Plug 'w0rp/ale'

" for autocomplete
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Rip-Rip/clang_complete'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 多重cursor(光標) 先學正規語言
"Plug 'terryma/vim-multiple-cursors'

" Auto-pairs for brakets, parens, quotes
Plug 'tpope/vim-surround'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" easymotion
Plug 'easymotion/vim-easymotion'

" Ultisnips
" Track the engine.
"Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
"Plug 'honza/vim-snippets'

call plug#end()
" ======Vim-plug settings finish=====

let mapleader = ","    "改變<leader> 預設是'\'
inoremap jj <Esc>

set nocompatible   "支持方向鍵
filetype off  "設定VI和VIM不相容模式
filetype plugin indent on

set mouse=a    " 讓mouse一選，就直接是選取模式了

set wrap   " 字數過長時換行。
set linebreak   " wrap but prevent linebreak
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <expr> <Up> (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> <Down> (v:count == 0 ? 'gj' : 'j')

" Display extra whitespace
set list listchars=tab:»·,trail:·
nnoremap <Tab> >>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
set tabstop=4
set shiftwidth=4
set shiftround
set expandtab

set cursorline  " 高亮當前行 (水平)
set cursorcolumn  " 高亮當前列 (垂直)。
set hlsearch  " 標記關鍵字。
set number  " 顯示行號 可加set numberwidth=5
set relativenumber "設定相對行號
set ruler  "顯示游標所在的座標

set ic  "搜尋時忽略大小寫
set autoread   "檔案遭其他程式更改時會自動重新讀取
set bsdir=buffer   "設定文件瀏覽器的目錄為當前的目錄
set showtabline=2  "總是顯示Tab列

" buffer settings: previous buffer,next buffer,close buffer
nnoremap <F5> :bp<cr>
nnoremap <F6> :bn<cr>
nnoremap <F7> :bd<cr>
nnoremap <leader>bd :bd<cr>

syntax on  "語法上色
set t_Co=256

set autochdir   " 自動切換當前目錄。
set scrolloff=3    " 捲動時保留底下 3 行。
set backspace=2   " Backspace deletes like most programs in insert mode
set directory^=$HOME/.vim/tmp//
set history=100
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit

" folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2


" Show function name on status line
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map <leader>n :call ShowFuncName() <CR>

" auto update ctags
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()

" cscope quick settings
" auto update cscope (map to F4)
map <F4> :!cscope -bRq<CR><CR>:cs add cscope.out<CR>:cs reset<CR><CR>
function! Create_cscope_file(execfile)                                           
    exe "! bash" a:execfile a:execfile                                                                  
endfunction

function! Create_cscope_out(cscope_files)                                           
    exe "! cscope -bRq -i" a:cscope_files                                                                  
endfunction

if has("cscope")
    let cscope_exec=findfile("build_cscope.sh", ".;")
    if !empty(cscope_exec)
        if cscope_exec ==? "build_cscope.sh"
            set csre
        endif
        silent call Create_cscope_file(cscope_exec)
        let cscope_files=findfile("cscope.files", ".;")
        if !empty(cscope_files) && filereadable(cscope_files)
            silent call Create_cscope_out(cscope_files)
            let cscope_out=findfile("cscope.out", ".;")
            if !empty(cscope_out) && filereadable(cscope_out)
                silent exe "cs add" cscope_out
            endif
        endif
    endif
endif
    
noremap <leader>cs :cs find s 
noremap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
noremap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
noremap <C-\>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

" Automatically include the headers
autocmd BufNewFile *.c r ~/template.c

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ariline
set laststatus=2
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#leftsep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline_powerline_fonts=1
noremap t1 <Plug>AirlineSelectTab1
noremap t2 <Plug>AirlineSelectTab2
noremap t3 <Plug>AirlineSelectTab3
noremap t4 <Plug>AirlineSelectTab4
noremap t5 <Plug>AirlineSelectTab5
noremap t6 <Plug>AirlineSelectTab6
noremap t7 <Plug>AirlineSelectTab7
noremap t8 <Plug>AirlineSelectTab8
noremap t9 <Plug>AirlineSelectTab9
noremap t[ <Plug>AirlineSelectPrevTab
noremap t] <Plug>AirlineSelectNextTab


" Color
set termguicolors
" set background=dark
colorscheme onedark
let g:onedark_terminal_italics=1
" let g:gruvbox_italic=1


" fzf settings
" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <leader>fl :Lines 
nnoremap <leader>fb :BLines 
nnoremap <leader>ff :Files 
nnoremap <leader>fg :GFiles 
nnoremap <leader>f? :GFiles? 
nnoremap <leader>ft :Tags<cr>
nnoremap <leader>fa :Ag 
nnoremap <leader>fc :Commits 

" startify 注意別跟Nerdtree衝到

" Deoplete
" " <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 3
let g:deoplete#max_list = 50

" multiple-cursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" easy-motion
" let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" clang_complete
let g:clang_library_path='/usr/lib/llvm-6.0/lib'
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" jedi-vim
let g:jedi#force_py_version = 3
let g:jedi#completions_command = '<C-N>'
let g:jedi#goto_command = '<leader>jg'
let g:jedi#documentation_command = '<leader>jd'
let g:jedi#usages_command = '<leader>ju'

" gitgutter
noremap <leader>hc :pclose<cr>

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"nnoremap <leader>us :UltiSnipsEdit
"let g:UltiSnipsExpandTrigger="<F3>"
"let g:UltiSnipsListSnippets="<c-tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips'] "right directory
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'c': ['clang'],
\   'cpp': ['clang'],
\   'python': ['pylint']
\}



