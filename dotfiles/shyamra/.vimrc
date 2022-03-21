set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'groenewege/vim-less'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Quramy/tsuquyomi'

call vundle#end()

set number
set tabstop=4 shiftwidth=4 expandtab
set backspace=indent,eol,start
syntax enable
set background=dark
filetype on

colorscheme solarized

autocmd FileType sml set tabstop=2|set shiftwidth=2|set expandtab
autocmd FileType cpp set tabstop=2|set shiftwidth=2|set expandtab

au BufRead,BufNewFile *.sig set filetype=sml

" folding settings
set foldmethod=indent    "fold based on indent
set foldnestmax=10       "deepest fold is 10 levels
set nofoldenable         "don't fold be default
set foldlevel=1
set mouse=a

set autoindent

set splitbelow
set splitright

nnoremap <C-p> :Files<CR>
nmap <C-n> :NERDTreeToggle<cr>
map <C-a> :FixWhitespace<cr>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set laststatus=2

let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
