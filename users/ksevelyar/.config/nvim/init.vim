" https://idempotent-desktop.netlify.app/vim.html
" https://github.com/ksevelyar/idempotent-desktop/blob/master/packages/nvim.nix

" Plugins
call plug#begin()

Plug 'rbgrouleff/bclose.vim'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'

Plug 'majutsushi/tagbar'

Plug 'easymotion/vim-easymotion'

Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-endwise'
Plug 'valloric/MatchTagAlways'

Plug 'janko-m/vim-test'

Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

Plug 'tpope/vim-obsession'

Plug 'dhruvasagar/vim-prosession'
let g:prosession_dir = '~/.config/nvim/session/'

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug 'tpope/vim-abolish'

Plug 'brooth/far.vim'
let g:far#source = 'rg'

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

"" Navigation 
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
let NERDTreeMinimalUI=1
let NERDTreeWinSize=40
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"" Color Themes 
Plug 'ksevelyar/joker.vim'
" Plug '/c/joker.vim'

Plug 'rafalbromirski/vim-aurora'
Plug 'dracula/vim'
Plug 'whatyouhide/vim-gotham'
Plug 'arcticicestudio/nord-vim'
Plug 'cocopon/iceberg.vim'

Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-scriptease'

Plug 'itchyny/lightline.vim' " :h lightline
let g:lightline = {
\ 'active': {
\   'left':[[ 'filename', ], [ 'gitbranch', 'modified', 'readonly', 'paste']],
\   'right':[[ 'fileformat', 'fileencoding', 'filetype' ]],
\ },
\ 'inactive': {
\ 'left': [[ 'filename', 'modified' ]],
\ 'right': [],
\ },
\ 'component_function': {
\   'modified': 'LightlineModified',
\   'readonly': 'LightlineReadonly',
\   'gitbranch': 'LightlineFugitive'
\ }
\ }

function! LightlineModified()
  let modified = &modified ? '+' : ''
  return &readonly ? '' : modified
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = {  'left': '', 'right': '' }
let g:lightline.colorscheme = 'joker'

Plug '907th/vim-auto-save'
let g:auto_save = 0

"" Dev
Plug 'ruanyl/vim-gh-line'
Plug 'tomtom/tcomment_vim'
let g:tcomment_maps = 0

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

Plug 'tpope/vim-fugitive'
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

Plug 'posva/vim-vue'
let g:vue_pre_processors = ['pug', 'sass', 'scss']
Plug 'digitaltoad/vim-pug'

Plug 'jsfaint/gen_tags.vim'
Plug 'neovim/nvim-lspconfig'
let g:gen_tags#ctags_auto_gen = 0

call plug#end()

" npm install -g typescript typescript-language-server vls

lua <<EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vuels.setup{}
require'lspconfig'.elixirls.setup{}
EOF

" Autocommands
"" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * silent! PlugInstall
endif

"" Automatically install missing plugins on startup
autocmd VimEnter * silent!
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | q
      \| endif

"" sane terminal
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au TermOpen * setlocal nonumber
au FileType fzf tunmap <buffer> <Esc>

" Core Settings
set conceallevel=0

set splitbelow
set splitright

syntax on
filetype plugin on " to use filetype plugin
filetype indent on " to use filetype indent
set updatetime=200
set laststatus=2
set signcolumn=yes
set hidden
set path+=** " type gf to open file under cursor
set number
set colorcolumn=100

set encoding=utf-8
set fileformat=unix

set title

"" Disable annoying sound on errors
set noerrorbells
set novisualbell

" UI 
set mouse=a
set shortmess=AI

set wildmenu
set wildmode=list:longest,full

if (has("termguicolors"))
  set termguicolors
endif

"" neovim-qt
if exists('g:GuiLoaded')
  GuiTabline 0
  GuiPopupmenu 0
  GuiLinespace 2
  GuiFont! Terminus:h16
endif

"" :Colors to change theme
silent! colorscheme joker


"" Clipboard 
set noshowmode
set clipboard=unnamedplus " sync vim clipboard with linux clipboard

" Backups 
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

"" Meaningful backup name, ex: filename@2015-04-05.14
au BufWritePre * let &bex = 'gh' . '@' . strftime("%F.%H") . '.bac'

set undofile
set undolevels=999
set display+=lastline
set nojoinspaces

"" Format 
"" Do not automatically insert a comment leader after an enter
autocmd FileType * setlocal formatoptions-=ro

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set list
set listchars=nbsp:¬,tab:>•,extends:»,precedes:«

"" Search 
set ignorecase
set smartcase

set incsearch
set inccommand=split
set gdefault


"" Switch between the last two files:
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

"" JK motions: Line motions
set so=2 " Set 2 lines to the cursor - when moving vertically using j/k

" Key Mappings
let g:mapleader = " "

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

nnoremap <silent> <space>a  :AutoSaveToggle<cr>
"" Manage extensions.

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

nnoremap <C-J> <C-W><C-J> " navigate down
nnoremap <C-K> <C-W><C-K> " navigate up
nnoremap <C-L> <C-W><C-L> " navigate right
nnoremap <C-H> <C-W><C-H> " navigate left

nmap <leader>c :TComment<cr>
xmap <leader>c :TComment<cr>
nnoremap <silent> <Leader>. :Files <C-r>=expand("%:h")<CR>/<CR>
nnoremap <silent> <Leader>g :GFiles?<CR>
nnoremap <silent> <Leader>\  :Commits<CR>
nnoremap <silent> <Leader>b :BCommits<CR>
nnoremap <silent> <Leader>i :IndentLinesToggle<CR>

nnoremap <silent> <Leader>]  :Tags<CR>
nnoremap <silent> <Leader>b] :BTags<CR>

nnoremap <leader>v <C-w>v<CR>
nnoremap <leader>h <C-w>s<CR>

nnoremap <leader><leader> :Files<CR>
nnoremap <leader>r :Rg<cr>
nnoremap <leader>m <C-w>:History<CR>

nnoremap <leader>u :UndotreeToggle<CR>
nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <leader>s :TagbarToggle<cr>

nnoremap <silent>\ :Goyo<cr>

"" copy curent buffer filepath
nnoremap <silent> <leader>p :let @+=expand("%:p")<CR>
"command! SW :execute ':silent w !sudo tee % > /dev/null' | :edit!
cmap w!! w !sudo tee % >/dev/null<Up>

set spelllang=en_us
nnoremap <leader>o :set spell!<CR>

"" copy / paste
"" vmap <C-C> "+y
imap <C-V> <esc>"+pi

nnoremap ; :
"" Shift+V d for cut
nnoremap d "_d

"" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
