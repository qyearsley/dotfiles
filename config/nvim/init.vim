set tabstop=4      " number of visual spaces per TAB
set softtabstop=4  " number of spaces in tab when editing
set expandtab      " tabs are spaces
set autoindent     " copy indent from current line
set number         " show line numbers
set showmatch      " show matching brackets when text indicator is over them
set hlsearch       " highlight all matches on previous search pattern
set incsearch      " show search matches incrementally
filetype plugin indent on  " enable filetype detection
syntax on          " enable syntax highlighting
autocmd BufEnter *.js :setlocal tabstop=2 shiftwidth=2 expandtab
autocmd BufEnter *.py :setlocal tabstop=4 shiftwidth=4 expandtab
