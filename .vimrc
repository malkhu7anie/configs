" vim-plug
" install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" vundle 

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
" Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" PLUGINS__
"
Plug 'itchyny/lightline.vim'                       " Lightline statusbar
Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
Plug 'vifm/vifm.vim'                               " Vifm
Plug 'scrooloose/nerdtree'                         " Nerdtree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " Highlighting Nerdtree
Plug 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" coc.nvim
let g:coc_disable_startup_warning = 1
" COLOUR SCHEMES
" sloarized dark
" syntax enable
" set background=dark

" nerdtree
map <F5> :NERDTreeToggle<CR>

" nord theme
" Plug 'arcticicestudio/nord-vim'
colorscheme nord

" vim customization
set autoindent
set cindent
set shiftwidth=2
set expandtab
set mouse=a
set number
set relativenumber
set wildmenu
set wildmode=longest:full,full

" auto paranthesisation

" using tab for completion
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


if !has('gui_running')
  set t_Co=256
endif




" lightline color scheme
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ }

"let s:nord0 = ["#2E3440", "NONE"]
"let s:nord1 = ["#3B4252", 0]
"let s:nord2 = ["#434C5E", "NONE"]
"let s:nord3 = ["#4C566A", 8]
"let s:nord4 = ["#D8DEE9", "NONE"]
"let s:nord5 = ["#E5E9F0", 7]
"let s:nord6 = ["#ECEFF4", 15]
"let s:nord7 = ["#8FBCBB", 14]
"let s:nord8 = ["#88C0D0", 6]
"let s:nord9 = ["#81A1C1", 4]
"let s:nord10 = ["#5E81AC", 12]
"let s:nord11 = ["#BF616A", 1]
"let s:nord12 = ["#D08770", 11]
"let s:nord13 = ["#EBCB8B", 3]
"let s:nord14 = ["#A3BE8C", 2]
"let s:nord15 = ["#B48EAD", 5]

" additional color for accent
"let s:nord3_bright = ["#616E88", 8]

"let s:p.normal.left = [[ s:nord4, s:nord3, 'bold' ], [ s:nord4, s:nord1 ]]
"let s:p.normal.middle = [[ s:nord4, s:nord1 ]]
"let s:p.normal.right = [[ s:nord4, s:nord3 ]]

" Always show statusline
set laststatus=2

" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

