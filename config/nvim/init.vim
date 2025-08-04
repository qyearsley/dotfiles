" ============================================================================
" VANILLA NEOVIM CONFIGURATION
" ============================================================================
" No plugins - just pure Neovim settings and key mappings

" ============================================================================
" BASIC SETTINGS
" ============================================================================
set nocompatible  " Use Vim settings, not Vi
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Indentation
set tabstop=4      " number of visual spaces per TAB
set softtabstop=4  " number of spaces in tab when editing
set shiftwidth=4   " number of spaces for autoindent
set expandtab      " tabs are spaces
set autoindent     " copy indent from current line
set smartindent    " smart autoindent

" Display
set number         " show line numbers
set relativenumber " show relative line numbers
set showmatch      " show matching brackets when text indicator is over them
set hlsearch       " highlight all matches on previous search pattern
set incsearch      " show search matches incrementally
set ignorecase     " ignore case in search
set smartcase      " but not if search contains uppercase
set showcmd        " show command in bottom bar
set cursorline     " highlight current line
set colorcolumn=80 " highlight column 80
set scrolloff=5    " keep 5 lines above/below cursor

" File handling
filetype plugin indent on  " enable filetype detection
syntax on          " enable syntax highlighting
set hidden         " allow switching buffers without saving
set nobackup       " don't create backup files
set noswapfile     " don't create swap files
set undofile       " persistent undo
set undodir=~/.vim/undodir

" Performance
set lazyredraw     " don't redraw while executing macros
set ttyfast        " faster terminal connection

" ============================================================================
" KEY MAPPINGS
" ============================================================================
" Use space as leader key
let mapleader=" "

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>

" Quick buffer navigation
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bd<CR>

" Split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick split creation
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" Search and replace
nnoremap <leader>sr :%s//g<Left><Left>
vnoremap <leader>sr :s//g<Left><Left>

" Clear search highlighting
nnoremap <leader><CR> :nohlsearch<CR>

" Quick file operations (using built-in features)
nnoremap <leader>e :Explore<CR>
nnoremap <leader>f :find 
nnoremap <leader>t :tag 

" Git operations (using terminal)
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gc :!git commit<CR>
nnoremap <leader>gp :!git push<CR>

" ============================================================================
" BUILT-IN FEATURE SETTINGS
" ============================================================================
" Netrw (file explorer) settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Wildmenu for better file completion
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.pyc,*.pyo,*.so,*.dll,*.dylib,*.exe,*.out,*.app

" Better search
set ignorecase
set smartcase
set gdefault

" ============================================================================
" COLOR SCHEME
" ============================================================================
set background=dark
" Use built-in color schemes
if has('termguicolors')
    set termguicolors
endif
" You can change this to any built-in scheme: desert, slate, murphy, etc.
colorscheme desert

" ============================================================================
" FILE TYPE SPECIFIC SETTINGS
" ============================================================================
" JavaScript/TypeScript
autocmd BufEnter *.js,*.jsx,*.ts,*.tsx :setlocal tabstop=2 shiftwidth=2 expandtab

" Python
autocmd BufEnter *.py :setlocal tabstop=4 shiftwidth=4 expandtab

" Markdown
autocmd BufEnter *.md :setlocal spell spelllang=en_us

" YAML
autocmd BufEnter *.yml,*.yaml :setlocal tabstop=2 shiftwidth=2 expandtab

" JSON
autocmd BufEnter *.json :setlocal tabstop=2 shiftwidth=2 expandtab

" Shell scripts
autocmd BufEnter *.sh,*.bash,*.zsh :setlocal tabstop=2 shiftwidth=2 expandtab

" ============================================================================
" AUTOCOMMANDS
" ============================================================================
" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Auto-reload vimrc when it's saved
autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
