" TODO: rewrite to lua modules

if empty(glob('~/.config/nvim' . '/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

" Behaviour
Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
Plug 'janko-m/vim-test'
Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug 'ruanyl/vim-gh-line' " :GH

Plug 'tomtom/tcomment_vim'
let g:tcomment_maps = 0

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Syntax 
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

Plug 'LnL7/vim-nix'
Plug 'dag/vim-fish'

Plug 'elixir-editors/vim-elixir'

Plug 'cakebaker/scss-syntax.vim' " TODO: replace with sugarss
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

Plug 'chr4/nginx.vim'

Plug 'sirtaj/vim-openscad'

" Navigation
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" UI
Plug 'lukas-reineke/indent-blankline.nvim'
let g:indent_blankline_char = '|'

Plug 'nvim-lualine/lualine.nvim'

" Color Themes
Plug 'ksevelyar/joker.vim'
" Plug '/c/joker.vim'
Plug 'shaunsingh/nord.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'rafalbromirski/vim-aurora'
Plug 'dracula/vim'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'

Plug 'luochen1990/rainbow'
Plug 'tpope/vim-scriptease'

" IDE
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

lua require('config')

" Core Settings
set conceallevel=0

set splitbelow
set splitright

syntax on
filetype plugin on " to use filetype plugin
filetype indent on " to use filetype indent

set updatetime=100
set laststatus=2
set signcolumn=yes
set hidden
set path+=** " type gf to open file under cursor
set number
set colorcolumn=100

set encoding=utf-8
set fileformat=unix

set title

" Disable annoying sound on errors
set noerrorbells
set novisualbell

" UI ----------------------------------------------------------------------------------------------
set mouse=a

" T truncate other messages in the middle if they are too long
" A don't give the "ATTENTION" message when an existing swap file is found
" I don't give the intro message when starting Vim |:intro|
set shortmess=AIT

set wildmenu
set wildmode=list:longest,full

if (has("termguicolors"))
  set termguicolors
endif

" :Colors to change theme
silent! colorscheme joker

" Tree view for netrw
let g:netrw_liststyle = 3

set noshowmode " cause the shape of cursor indicates the mode already
set clipboard=unnamedplus " sync vim clipboard with linux clipboard

" Backups -----------------------------------------------------------------------------------------
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
if isdirectory($HOME . '/.config/nvim/backup') == 0
  :silent !mkdir -p ~/.config/nvim/backup > /dev/null 2>&1
endif

set history=1000
set undodir=~/.config/nvim/undo//
set noswapfile

set backup
set backupdir=~/.config/nvim/backup//
set writebackup "Make backup before overwriting the current buffer
set backupcopy=yes "Overwrite the original backup file

" Meaningful backup name, ex: filename@2015-04-05.14
autocmd BufWritePre * let &bex = 'gh' . '@' . strftime("%F.%H") . '.bac'

set undofile
set undolevels=999
set display+=lastline
set nojoinspaces

" Behaviour ------------------------------------------------------------------------------------------
" go to last file on startup
autocmd VimEnter * nested
      \  if argc() == 0
      \|   let last = filter(filter(copy(v:oldfiles), 'match(v:val, getcwd()) == 0'), 'filereadable(v:val)')
      \|   if !empty(last)
      \|     execute 'edit' fnameescape(last[0])
      \|   endif
      \| endif

" go to last position in file on sttartup
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

" Do not automatically insert a comment leader after an enter
autocmd FileType * setlocal formatoptions-=ro

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set list
set listchars=nbsp:¬,tab:>•,extends:»,precedes:«,trail:¶

" Search ------------------------------------------------------------------------------------------
set ignorecase
set smartcase

set incsearch
set inccommand=split
set gdefault

" JK motions: Line motions
set so=2 " Set 2 lines to the cursor - when moving vertically using j/k

" -------------------------------------------------------------------------------------------------
" Key Mappings
" -------------------------------------------------------------------------------------------------
let g:mapleader = " "

nnoremap <C-J> <C-W><C-J> " navigate down
nnoremap <C-K> <C-W><C-K> " navigate up
nnoremap <C-L> <C-W><C-L> " navigate right
nnoremap <C-H> <C-W><C-H> " navigate left

nmap <leader>c :TComment<cr>
xmap <leader>c :TComment<cr>

nnoremap <leader>v <C-w>v<cr>
nnoremap <leader>h <C-w>s<cr>

nnoremap <leader><leader> <cmd>Telescope find_files<cr>
nnoremap <leader>r <cmd>Telescope live_grep<cr>
nnoremap <leader>b <cmd>Telescope git_branches<cr>
nnoremap <leader>m <cmd>Telescope oldfiles<cr>
nnoremap <leader>l <cmd>Telescope lsp_document_symbols<cr>

nnoremap <leader>t :NvimTreeToggle<cr>
nnoremap <leader>f :NvimTreeFindFile<cr>
nnoremap <silent><leader>w :w<cr>

nnoremap <leader>y :%y+<cr>

set spelllang=en_us
nnoremap <leader>o :set spell!<cr>

" copy / paste
imap <C-V> <esc>"+pi

nnoremap ; :
" Shift+V d for cut
nnoremap d "_d

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
