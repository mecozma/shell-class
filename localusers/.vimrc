set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mattn/emmet-vim'
Plugin 'fatih/vim-go'
" All of your Plugins must be added before the following line
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

"My settings start here

"Layout
set splitbelow
set splitright

"Layout navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Map ESC to JK
inoremap jk  <Esc>

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za 		" Enable folding with spacebar
let g:SimpylFold_docstring_preview=1	" Shows the docstrings for the folded
"code

"PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=2
    \     softtabstop=4
    \     shiftwidth=4
    \     textwidth=79
    \     expandtab
    \     autoindent
    \     fileformat=unix

"Full stack development
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2
    \     softtabstop=2
    \     shiftwidth=2

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags	"html autocomplete
iabbrev <// </<C-X><C-O>

" Display tabs at the beginning of a line in Python mode as bad.
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
set list listchars=tab:»\ ,trail:°

"Flagging unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"YouCompleteMe customizations
let mapleader = " "
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

"Color scheme logic
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

call togglebg#map("<F5>")

"NERDtree customizations
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree	"Hide the .pyc
"files

"-- EMMET CONFIG --
let g:user_emmet_mode='a'
"redefine trigger key
let g:user_emmet_leader_key=','

syntax on
set nu rnu
set nowrap
set smartcase
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set encoding=utf-8
let python_highlight_all=1
set clipboard=unnamed
"air-line settings
let g:airline_powerline_fonts=1
let g:airline_theme='bubblegum'
set laststatus=2    "Shows the vim-airline
"Automatically change the working path to the path of the curent file
autocmd BufNewFile,BufEnter * silent! lcd %:p:h
"80 characters limit column
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=red

"-- Python settings--
"Run Python in VIM
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" Syntactic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"Learn vimscript the hard way

"Map - to move a line down
nnoremap - ddp
"Map _ to move a line up
nnoremap _ ddkP
"Map Ctrl + u to uppercase the current word in insert mode
imap <c-u> <esc>viwUwA
