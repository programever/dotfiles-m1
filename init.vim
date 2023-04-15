" Start declaring all Plugins
autocmd!
let g:loaded_python_provider = 0 " Turn off python2
call plug#begin('~/.nvim/plugged')

" Use solarized color scheme
Plug 'iCyMind/NeoSolarized'

" Read the file automatically when returning back to Vim
Plug 'djoshea/vim-autoread'

" Toggles between relative and absolute line numbers automatically
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Fuzzy file matching
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag --path-to-ignore ~/Workspace/dotfiles/.agignore --literal --files-with-matches --nocolor --hidden -g "" %s'

" Ag silver searcher plugin
Plug 'numkil/ag.nvim'
let g:ag_prg = 'ag --path-to-ignore ~/Workspace/dotfiles/.agignore --vimgrep --silent'

" Easy commenting in code (gcc)
Plug 'tpope/vim-commentary'

" Easy manipulation of enclosing brackets/etc (ysiw)
Plug 'tpope/vim-surround'

" dot operator repeat for vim-commentary/vim-surrond
Plug 'tpope/vim-repeat'

" Displays a | for indentation
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '⁞'
let g:indentLine_color_term = 254 " Solarized base2 color 

" Overwrites Yggdroot/indentLine conceal level properly for Json
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Display tsx file
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

" Nice status bar
Plug 'vim-airline/vim-airline'
" Disable all extensions for vim-airline for better performance
let g:airline_extensions=['coc']
let g:airline#extensions#coc#enabled = 1

" Displays directory file system on the side
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['node_modules', '.git$', '\.swp$', 'rethinkdb_data', '\.DS_Store$']

" Autocomplete with Language Server Support
" Requirements:
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [ 'coc-eslint', 'coc-json', 'coc-prettier', 'coc-css', 'coc-html', 'coc-snippets', 'coc-fsharp', 'coc-tsserver', 'coc-rust-analyzer', 'coc-sql', 'coc-sh', 'coc-diagnostic' ]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap          gn <Plug>(coc-rename)
nmap <silent> gh :call ShowDocumentation()<CR>
nmap          go <Plug>(coc-float-jump)
nmap          gl <Plug>(coc-codelens-action)
nmap          gf <Plug>(coc-fix-current)
nmap          ga <Plug>(coc-codeaction-selected)<CR>
nmap          gA <Plug>(coc-codeaction)
nmap <silent> gk <Plug>(coc-diagnostic-prev)
nmap <silent> gj <Plug>(coc-diagnostic-next)
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Map navigation & Enter in insert mode for auto-completion
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap         <expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap         <expr> <CR>  coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Coding shorthands
inoremap <c-f> ∀
inoremap <c-l> ->

" Syntax highlighting for elm
Plug 'andys8/vim-elm-syntax'

" F# Syntax highlight
Plug 'kongo2002/fsharp-vim'

" firestore.rules Syntax highlight
Plug 'delphinus/vim-firestore'

" Syntax highlighting for Purescript
Plug 'purescript-contrib/purescript-vim'

" Syntax highlighting for Dhall
Plug 'vmchale/dhall-vim'

" Initialize plugin system
call plug#end()

" *****************************************
"     Vim Settings
" *****************************************

" Color scheme
set background=light
colorscheme NeoSolarized
hi CocUnusedHighlight ctermfg=Red

set updatetime=300
set signcolumn=yes
set wildmenu
set wildmode=full
set switchbuf=useopen,usetab
set history=500
set splitbelow
set splitright
set number
set cursorline
set hlsearch
set incsearch
set nowrap
set showcmd

" Set the folding behaviors
set foldmethod=syntax
set nofoldenable

" Yanks text into system clipboard
set clipboard=unnamed

" Make backspace works like normal
set backspace=indent,eol,start

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Lower timeout for mappings (faster response)
set ttimeout
set timeout timeoutlen=300 ttimeoutlen=300

" Live preview of subsitution
set inccommand=split

" Faster escape in insert mode
autocmd InsertEnter * set timeoutlen=0 ttimeoutlen=0
autocmd InsertLeave * set timeoutlen=300 ttimeoutlen=300

" Set markdown syntax highlight
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.md set wrap linebreak
autocmd BufNewFile,BufReadPost *.purs set filetype=purescript

" Saves undo into a file and use it across all vim sessions
set undodir=~/.nvim/undo
set undofile

" *****************************************
"     Personal Key mapping
" *****************************************

" Auto-expand %% to the current file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Navigation around windows
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <tab><tab> <c-w><c-w>

" Insert a line break above
nmap K 0i<cr><esc>

" Toggle relative line number
nnoremap <silent> <C-n> :set relativenumber!<cr>

" *****************************************
"     Leader Mappings
" *****************************************

let mapleader = " "

" Save the file
nnoremap <Leader>s :w<CR>

" Quickfix windows open and close
map <Leader>qq :cclose<CR>
map <Leader>qf :copen<CR>

" Split lines below
map <Leader>k i<cr><esc>

" Opens NerdTree
map <Leader>n :NERDTreeToggle<CR>

" Clear highlighted search
map <Leader>/ :nohlsearch<CR>

" Toggle paste and nopaste mode
nnoremap <Leader>p :set invpaste paste?<CR>

" Displays the registers
map <Leader>r :reg<CR>

" Yank the whole page
map <Leader>y mcggVGy`c
