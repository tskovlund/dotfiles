"""""""""""""""""""""""""""""""""""""
" Author:
"     Thomas Skovlund Hansen
"
" Inspiration:
"     Amir Salihefendic
"     https://github.com/amix/vimrc
"
" Version:
"     2018-01-29
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

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Gruvbox color scheme
Plug 'morhetz/gruvbox'

" autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clang-completer' }

" latex-suite
Plug 'vim-latex/vim-latex'

" vue highlighting
Plug 'posva/vim-vue'

" lightline
Plug 'itchyny/lightline.vim'

" fzf fuzzy find
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Distraction free vim
Plug 'junegunn/goyo.vim'

" Markdown support
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 

" Track coding time
Plug 'wakatime/vim-wakatime'

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

" Map fzf to ;
map <Up> :Files<CR>

" Markdown in Goyo mode
function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  elseif &ft == 'pandoc'
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction

augroup goyo_markdown
  autocmd!
  autocmd BufNewFile,BufRead * call s:auto_goyo()
augroup END

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

" Custom filetype highligthing definitions
autocmd BufNewFile,BufRead *.svelte set syntax=html

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

" Enable mouse
set mouse=a

" Set 5 lines of scrolloff when moving vertically with j/k
set so=5

" Smart way to move between windows
let g:C_Ctrl_j = 'off'
let g:BASH_Ctrl_j = 'off'

map <C-h> <C-W>h
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-l> <C-W>l

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"""""""""""""""""""""""""""""""""""""
" Editing
"""""""""""""""""""""""""""""""""""""

" Change mapleader to space
let mapleader="\<Space>"

" Tabs are spaces
set expandtab
" Number of visual spaces per TAB
set tabstop=4
" Number of spaces in tab when editing
set softtabstop=4
" Number of spaces when auto indenting
set shiftwidth=4

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

" Linebreak on 79 characters (PEP 8 compliant)
set linebreak
set textwidth=79

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
" Shortcuts
"""""""""""""""""""""""""""""""""""""
au FileType python nnoremap <LEADER>r O<C-A> = <Esc>p
au FileType tex nnoremap <LEADER>r O\newcommand{<C-A>}{<Esc>pA}<Esc>

"""""""""""""""""""""""""""""""""""""
" Clipboard
"""""""""""""""""""""""""""""""""""""

" Use the system clipboard
set clipboard=unnamed
