" TODO: rewrite to lua modules

if empty(glob('~/.config/nvim' . '/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()

Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'

Plug 'easymotion/vim-easymotion'

Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-endwise'
Plug 'valloric/MatchTagAlways'

Plug 'janko-m/vim-test'

Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug 'brooth/far.vim'
let g:far#source = 'rg'

" Navigation 
Plug 'kyazdani42/nvim-tree.lua'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Color Themes 
Plug 'ksevelyar/joker.vim'
Plug 'shaunsingh/nord.nvim'
Plug 'folke/tokyonight.nvim'
" Plug '/c/joker.vim'

Plug 'rafalbromirski/vim-aurora'
Plug 'dracula/vim'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'

Plug 'luochen1990/rainbow'
Plug 'tpope/vim-scriptease'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-lualine/lualine.nvim'

" Dev
Plug 'ruanyl/vim-gh-line'
Plug 'tomtom/tcomment_vim'
let g:tcomment_maps = 0

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'slashmili/alchemist.vim'
Plug 'LnL7/vim-nix'
Plug 'elixir-editors/vim-elixir'
Plug 'neovimhaskell/haskell-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'dag/vim-fish'
Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

Plug 'chr4/nginx.vim'

Plug 'sirtaj/vim-openscad'

Plug 'Yggdroot/indentLine'
let g:indentLine_fileType = ['nix', 'html', 'vue']
let g:indentLine_char = '┊'
let g:indentLine_color_gui = "#3f3b52"

Plug 'digitaltoad/vim-pug'

" LSP
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

lua require('config')

set completeopt=menu,menuone,noselect

" -------------------------------------------------------------------------------------------------
" Autocommands
" -------------------------------------------------------------------------------------------------

" sane terminal
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au TermOpen * setlocal nonumber

" -------------------------------------------------------------------------------------------------
" Core Settings
" -------------------------------------------------------------------------------------------------
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
set shortmess=AI

set wildmenu
set wildmode=list:longest,full

if (has("termguicolors"))
  set termguicolors
endif

" neovim-qt
if exists('g:GuiLoaded')
  GuiTabline 0
  GuiPopupmenu 0
  GuiLinespace 2
  GuiFont! Terminus:h16
endif

" :Colors to change theme
silent! colorscheme joker

" Tree view for netrw
let g:netrw_liststyle = 3

" Clipboard ---------------------------------------------------------------------------------------
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
au BufWritePre * let &bex = 'gh' . '@' . strftime("%F.%H") . '.bac'

set undofile
set undolevels=999
set display+=lastline
set nojoinspaces

" Format ------------------------------------------------------------------------------------------
" Do not automatically insert a comment leader after an enter
autocmd FileType * setlocal formatoptions-=ro

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set list
set listchars=nbsp:¬,tab:>•,extends:»,precedes:«

" Search ------------------------------------------------------------------------------------------
set ignorecase
set smartcase

set incsearch
set inccommand=split
set gdefault


" Switch between the last two files:
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
set so=2 " Set 2 lines to the cursor - when moving vertically using j/k

" -------------------------------------------------------------------------------------------------
" Key Mappings
" -------------------------------------------------------------------------------------------------
let g:mapleader = " "

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

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

nnoremap <silent>\ :Goyo<cr>

nnoremap <leader>y :%y+<cr>

cmap w!! w !sudo tee % >/dev/null<Up>

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
