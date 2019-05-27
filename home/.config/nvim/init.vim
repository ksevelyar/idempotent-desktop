" pacman -S --noconfirm ripgrep

" NOTE: type za to toggle current fold.
":help folding".

""" Preinstall
" Install Vim Plug if not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

""" Plugins
call plug#begin()

let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_lint_on_enter = 0
let g:ale_completion_max_suggestions = 15
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'javascript': ['eslint'],
\   'vue': ['eslint', 'stylelint'],
\   'json': ['prettier'],
\   'sass': ['stylelint'],
\}
set completeopt=menu,menuone,preview,noselect,noinsert " fix ale + solargraph
Plug 'w0rp/ale' " gem install neovim solargraph

Plug 'tomtom/tcomment_vim'

Plug 'majutsushi/tagbar'

Plug 'vim-scripts/YankRing.vim'
let g:yankring_clipboard_monitor=0

Plug 'easymotion/vim-easymotion'

" Plug 'dracula/vim', { 'as': 'dracula' }

let g:colorizer_auto_filetype='css,sass,vim'
let g:colorizer_disable_bufleave = 1
Plug 'chrisbra/Colorizer'

Plug 'slashmili/alchemist.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-haml'
Plug 'cakebaker/scss-syntax.vim'
Plug 'slim-template/vim-slim'
Plug 'godlygeek/tabular'
Plug 'ervandew/supertab'
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'

Plug 'tpope/vim-endwise'
Plug 'valloric/MatchTagAlways'
Plug 'Raimondi/delimitMate'

Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

Plug 'mutewinter/nginx.vim'

Plug 'janko-m/vim-test'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_grep = 'rg'

Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
let g:prosession_dir = '~/.config/nvim/session/'

Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1

Plug 'brooth/far.vim'
let g:far#source = 'agnvim'
let g:far#file_mask_favorites = ['%', '**/*.*', '**/*.rb', '**/*.slim', '**/*.js', '**/*.css', '**/*.sass']

Plug 'jsfaint/gen_tags.vim'
Plug 'mbbill/undotree'

" let g:gen_tags#ctags_opts = '-R --sort=yes --languages=ruby,javascript --exclude=.git --exclude=log --exclude=public . $(bundle list --paths)'
let g:gen_tags#ctags_auto_gen = 1

" -------------------------
" UI
" -------------------------
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-scriptease'

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" let g:airline_section_a = ''
" let g:airline_section_z = ''
" let g:airline#extensions#default#layout = [ [ 'a', 'b', 'c' ], [ 'x', 'y', 'z', 'error', 'warning' ] ]
let airline#extensions#ale#error_symbol = ' '
let airline#extensions#ale#warning_symbol = ' '
let airline#extensions#ale#show_line_numbers = 0
let airline#extensions#ale#open_lnum_symbol = ''
let airline#extensions#ale#close_lnum_symbol = ''

let g:airline#extensions#default#layout = [ [ 'b', 'c' ], [ 'x', 'y', 'warning', 'error' ] ]
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#ctrlp#show_adjacent_modes = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_skip_empty_sections = 1

Plug 'vim-airline/vim-airline'

Plug 'tpope/vim-fugitive'
Plug 'posva/vim-vue'
Plug 'digitaltoad/vim-pug'

""" Navigation
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_mruf_max = 999


if executable('rg')
  set grepprg=rg\ --color=never

  " Use rg in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
  " rg is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

""" Themes
Plug 'whatyouhide/vim-gotham'
Plug 'ksevelyar/joker.vim'
Plug 'cocopon/iceberg.vim'
Plug 'whatyouhide/vim-gotham'
" Plug 'liuchengxu/space-vim-dark'

Plug 'ryanoasis/vim-devicons' " yay aur/nerd-fonts-complete

call plug#end()

""" autocmd

set autoread
if exists("g:gui_oni")
else
  " Autoread hack for terminal
  au FocusGained * :checktime

  let NERDTreeShowHidden=1
  let NERDTreeWinSize=39
  let NERDTreeDirArrows=1
  let NERDTreeMinimalUI=1

  map  <silent> <F3> :NERDTreeToggle<cr>
  imap <silent> <F3> <Esc> :NERDTreeToggle<cr>
endif

""" GUI

set termguicolors

" hi EndOfBuffer guifg=bg
silent! colorscheme joker
" set background=dark


""" General
syntax on
filetype plugin on " to use filetype plugin
filetype indent on " to use filetype indent

set noshowmode
set clipboard=unnamedplus " sync vim clipboard with linux clipboard

set hidden
set number
" set relativenumber
set colorcolumn=100

set encoding=utf-8
set fileformat=unix

set history=1000
set title
set mouse=a

set shortmess=AI

" --- Backups --- "
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
if isdirectory($HOME . '/.config/nvim/backup') == 0
  :silent !mkdir -p ~/.config/nvim/backup > /dev/null 2>&1
endif

set undodir=~/.config/nvim/undo//
set noswapfile

set backup
set backupdir=~/.config/nvim/backup//
set writebackup "Make backup before overwriting the current buffer
set backupcopy=yes "Overwrite the original backup file

"Meaningful backup name, ex: filename@2015-04-05.14
au BufWritePre * let &bex = 'gh' . '@' . strftime("%F.%H") . '.bac'

set undofile
set undolevels=500
set display+=lastline
set nojoinspaces

" No annoying sound on errors
set noerrorbells
set novisualbell

:cabbrev h vert h

""" Format

" File type settings
" Do not automatically insert a comment leader after an enter
" set autowrite
autocmd FileType * setlocal formatoptions-=ro

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set list
set listchars=nbsp:¬,tab:>•,extends:»,precedes:«

autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

set updatetime=100


""" Search
set ignorecase
set smartcase

set incsearch
set inccommand=split
set gdefault

let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()

""" Bindings
:let g:mapleader = ","

" Switch between the last two files:
" nmap <Leader><Leader> <C-^>
" map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
set so=2 " Set 2 lines to the cursor - when moving vertically using j/k
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"Max out the height of the current split - ctrl + w _
"Max out the width of the current split - ctrl + w |
"Normalize all split sizes - ctrl + w =

"Swap top/bottom or left/right split - Ctrl+W R
"Break out current window into a new tabview - Ctrl+W T
"Close every window in the current tabview but the current one - Ctrl+W o

set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J> " navigate down
nnoremap <C-K> <C-W><C-K> " navigate up
nnoremap <C-L> <C-W><C-L> " navigate right
nnoremap <C-H> <C-W><C-H> " navigate left

map gcp <Leader>_p " Comment the current inner paragraph

nmap <leader>s <C-w>v<CR>
nmap <leader>hs <C-w>s<CR>

" FIXME: fix keys
" nnoremap <Leader>e :AleError<cr>
" nnoremap <Leader>w :AleWarning<cr>

nmap <leader>t <C-w>v<C-w>l:terminal<CR>
nmap <leader>ht <C-w>s<C-w>j:terminal<CR>

nnoremap <Space>s :Rg<cr>
nmap s <Plug>(easymotion-overwin-f2)

"command! SW :execute ':silent w !sudo tee % > /dev/null' | :edit!
cmap w!! w !sudo tee % >/dev/null<Up>

" copy curent buffer filepath
nmap <leader>fp :let @+=expand("%:p")<CR>

nmap <Leader>ct :ColorToggle<cr>

" copy / paste
vmap <C-C> "+y

nnoremap ; :
nnoremap <leader>; q:i

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" F1-F12
map  <F1> :CtrlPBookmarkDir<cr>
imap <F1> <Esc>:CtrlPBookmarkDir<cr>
map <leader>ba :CtrlPBookmarkDirAdd<cr>

map  <silent><F2> :YRShow<cr>
imap <silent><F2> <Esc>:YRShow<cr>

nmap  <silent><F4> :update<cr>
vmap <silent><F4> <Esc><F4>gv
imap <silent><F4> <Esc><F4>

map <F5> :TagbarToggle<cr>
imap <F5> <Esc>:TagbarToggle<cr>

map  <F6> :CtrlP<cr>
imap <F6> <Esc>:CtrlP<CR>

map  <F7> :CtrlPRoot<cr>
imap <F7> <Esc>:CtrlPRoot<CR>

map  <F8> :CtrlPMRU<cr>
imap <F8> <Esc>:CtrlPMRU<CR>

map  <F9> :UndotreeToggle<cr>
imap <F9> <Esc>:UndotreeToggle<CR>

" Enable/Disable paste mode, where data won't be autoindented
set pastetoggle=<F10>

map  <F11> :ALEFix<CR>
imap <F11> <Esc>:ALEFix<CR>

map <F12> :qa<cr>
imap <F12> <Esc>:qa<CR>

command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

"" vim:fdm=expr:fdl=1
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
