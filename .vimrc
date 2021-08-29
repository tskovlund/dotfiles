"""""""""""""""""""""""""""""""""""""
" Author:
"     Thomas Skovlund Hansen
"
" Inspiration:
"     Amir Salihefendic
"     https://github.com/amix/vimrc
"
" Version:
"     2020-09-10
"
" Sections:
"     General settings
"     Plugins
"     User interface
"     Navigation
"     Editing
"     Searching
"     Clipboard
"""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""

" Disable vi compatibility setting
set nocompatible

" Set utf8 as standard encoding 
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,mac,dos

"""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""

" Automatic vim-plug detection and installation
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Gruvbox color scheme
Plug 'morhetz/gruvbox'

" autocompletion
let ycm_clangd_binary_path='/usr/bin/clangd'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --all --system-libclang' }

" latex-suite
Plug 'vim-latex/vim-latex'

" lightline
Plug 'itchyny/lightline.vim'

" Track coding time
Plug 'wakatime/vim-wakatime'

" Ale formatting
Plug 'dense-analysis/ale'

" Coq
Plug 'whonore/Coqtail'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Enable lightline
set laststatus=2
" Don't show status anywhere else but in the powerline
set noshowmode

" Set ALE to fix files when you save them.
" let g:ale_fix_on_save = 1

" Pimp the linter symbols
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'

" Change mapleader to space
let mapleader="\<Space>"
" Map :ALEFix to shortcuts
nmap <leader>ff :ALEFix<CR>
nmap <leader>fj :ALENextWrap<CR>
nmap <leader>fk :ALEPreviousWrap<CR>

"""""""""""""""""""""""""""""""""""""
" User interface
"""""""""""""""""""""""""""""""""""""

" Color scheme
set background=dark
colorscheme gruvbox
set termguicolors

" Set language to English
language messages en_US.UTF-8
set langmenu=en_US.UTF-8

" Enable wildmenu
set wildmenu

" Enable syntax highlighting
syntax enable

" Show matching brackets when text indicator is over them
set showmatch

" Show line numbers
set number

" Show bottom ruler
set ruler

" Show commands
set showcmd
set timeoutlen=2000

" Height of the command bar
set cmdheight=2

" No error bells and whistles
set noerrorbells
set novisualbell
set t_vb=

" Ignore various files
set wildignore+=*.~,*.swp,*.o,*.pyc,*.class,*.DS_Store

" Performance setting - don't redraw while executing macros
set lazyredraw

"""""""""""""""""""""""""""""""""""""
" Navigation
"""""""""""""""""""""""""""""""""""""

set ttimeoutlen=50

" Enable mouse
set mouse=a

" Set 5 lines of scrolloff when moving vertically with j/k
set so=5

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""
" Editing
"""""""""""""""""""""""""""""""""""""

" Tabs are spaces
set expandtab
" Number of visual spaces per TAB
set tabstop=4
" Number of spaces in tab when editing
set softtabstop=4
" Number of spaces when auto indenting
set shiftwidth=4
" Round indent to a multiple of 'shiftwidth'
set shiftround
" Match indentation of previous line
set autoindent

" Enable filetype specific indentation
" To create settings for different filetypes,
" create files for different languages such as
" python.vim and html.vim in ~/.vim/after/ftplugin
" (Beware, using the "after" directory means that the
" settings will override plugin settings)
"
" smartindent and cindent may not be used along with this setting
filetype plugin indent on

" Don't auto-wrap comments on new lines
autocmd FileType * setlocal formatoptions-=cro

" Allow backspacing over autoindents, line ends and over start of insert
set backspace=indent,eol,start    

" Wrap around lines with arrow keys
set whichwrap+=<,>,h,l,[,]

" Turn persistent undo on
" means that you can undo even when you close a buffer/VIM
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile

"""""""""""""""""""""""""""""""""""""
" Searching
"""""""""""""""""""""""""""""""""""""

" Ignore case when searching
set ignorecase
" Don't ignore case when specifically writing capital letters
set smartcase
" Infer cases when completing
set infercase
" Highlight search results
set hlsearch
" Incremental search
set incsearch
" Map , to remove highlighting
nnoremap , :noh<CR>

"""""""""""""""""""""""""""""""""""""
" Filetype specific configuration
"""""""""""""""""""""""""""""""""""""
au FileType python nnoremap <LEADER>r O<C-A> = <Esc>p
au FileType tex nnoremap <LEADER>r O\newcommand{<C-A>}{<Esc>pA}<Esc>

"""""""""""""""""""""""""""""""""""""
" Clipboard
"""""""""""""""""""""""""""""""""""""

" Use the system clipboard
set clipboard^=unnamed,unnamedplus

