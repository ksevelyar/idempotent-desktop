" https://github.com/ksevelyar/dotfiles/blob/master/modules/packages/nvim.nix

" NOTE: type za to toggle current fold.
":help folding".

" Preinstall
" Install Vim Plug if not installed
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
  " silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    " \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  " autocmd VimEnter * PlugInstall
" endif
"
" Automatically install missing plugins on startup
" autocmd VimEnter *
  " \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  " \|   PlugInstall --sync | q
  " \| endif

""" Plugins
call plug#begin()
Plug 'laher/fuzzymenu.vim'
Plug 'ruanyl/vim-gh-line'
Plug 'w0rp/ale'
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 0
let g:ale_sign_error = '◉'
let g:ale_sign_warning = '◉'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'sass': ['stylelint'],
\   'elixir': ['mix_format'],
\   'nix': ['nixpkgs-fmt'],
\   'haskell': ['stylish-haskell']
\}

let g:ale_linters = {
\   'c': [], 'cpp': [], 'elixir': [], 'go': [], 'sh': [],
\   'html': [], 'css': [], 'javascript': [], 'typescript': [],
\   'json': [], 'vue': [],
\ }

let g:coc_global_extensions = [
\ 'coc-vetur', 'coc-json', 'coc-html', 'coc-css', 'coc-eslint', 'coc-tsserver',
\ 'coc-elixir', 'coc-go', 'coc-yaml', 'coc-tag', 'coc-markdownlint', 'coc-yank',
\ 'coc-vimlsp', 'coc-sh', 'coc-emoji', 'coc-git', 'coc-highlight', 'coc-svg'
\ ]
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup cocnvim
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


Plug 'rbgrouleff/bclose.vim'
" Plug 'ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'

Plug 'preservim/nerdcommenter'
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1

Plug 'majutsushi/tagbar'

" Plug 'vim-scripts/YankRing.vim'
" let g:yankring_clipboard_monitor=0

" Plug 'easymotion/vim-easymotion'


" Plug 'dracula/vim', { 'as': 'dracula' }

" let g:colorizer_auto_filetype='css,sass,vim'
" let g:colorizer_disable_bufleave = 1
" Plug 'chrisbra/Colorizer'


" Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rails'
" Plug 'tpope/vim-haml'
" Plug 'slim-template/vim-slim'

Plug 'slashmili/alchemist.vim'
Plug 'LnL7/vim-nix'
Plug 'elixir-editors/vim-elixir'
Plug 'neovimhaskell/haskell-vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'godlygeek/tabular'
" Plug 'ervandew/supertab'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dag/vim-fish'

Plug 'tpope/vim-endwise'
Plug 'valloric/MatchTagAlways'
" Plug 'Raimondi/delimitMate'

Plug 'pangloss/vim-javascript'
Plug 'othree/yajs.vim'
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

Plug 'chr4/nginx.vim'

Plug 'janko-m/vim-test'
"let g:gitgutter_override_sign_column_highlight = 0
"let g:gitgutter_grep = 'rg'
" Plug 'airblade/vim-gitgutter'

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
let g:far#file_mask_favorites = ['%', '**/*.*', '**/*.rb', '**/*.slim', '**/*.js', '**/*.css', '**/*.sass']

" Plug 'jsfaint/gen_tags.vim'
Plug 'mbbill/undotree'

let g:gen_tags#ctags_auto_gen = 1

" Interpolation
" Plug 'hwartig/vim-seeing-is-believing'
" augroup seeingIsBelievingSettings
"   autocmd!
"
"   autocmd FileType ruby nmap <buffer> <F2> <Plug>(seeing-is-believing-mark-and-run)
"   autocmd FileType ruby xmap <buffer> <F2> <Plug>(seeing-is-believing-mark-and-run)
" augroup END

" -------------------------
" UI
" -------------------------
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-scriptease'

Plug 'vim-airline/vim-airline'
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


Plug 'tpope/vim-fugitive'
" Plug 'posva/vim-vue'
" let g:vue_pre_processors = ['pug', 'sass']
Plug 'digitaltoad/vim-pug'

""" Navigation
" Plug 'SirVer/ultisnips'
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind'] }
let NERDTreeMinimalUI=1
let NERDTreeWinSize=39
"   let NERDTreeShowHidden=1
"   let NERDTreeDirArrows=1
" let g:NERDTreeChDirMode=2

""" Themes
Plug 'rafalbromirski/vim-aurora'
Plug 'dracula/vim'
Plug 'whatyouhide/vim-gotham'

"Plug 'ksevelyar/joker.vim'
Plug '/c/joker.vim'

Plug 'arcticicestudio/nord-vim'
Plug 'chriskempson/base16-vim'
Plug 'cocopon/iceberg.vim'
Plug 'ryanoasis/vim-devicons'
Plug '907th/vim-auto-save'
let g:auto_save = 0
augroup ft_markdown
  au!
  au FileType markdown let b:auto_save = 1
augroup END

call plug#end()

set termguicolors

" hi EndOfBuffer guifg=bg
" :Colors to change theme
silent! colorscheme joker
" set background=dark


""" General
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

syntax on
filetype plugin on " to use filetype plugin
filetype indent on " to use filetype indent

set noshowmode
set clipboard=unnamedplus " sync vim clipboard with linux clipboard

set signcolumn=yes
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
" set shortmess+=c

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


""" Format

" File type settings
" Do not automatically insert a comment leader after an enter
" set autowrite
autocmd FileType * setlocal formatoptions-=ro

set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

set list
set listchars=nbsp:¬,tab:>•,extends:»,precedes:«

autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

set updatetime=200


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
" :verbose imap

:let g:mapleader = " "

" Switch between the last two files:
" nmap <Leader><Leader> <C-^>
" map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
set so=2 " Set 2 lines to the cursor - when moving vertically using j/k
"Max out the height of the current split - ctrl + w _
"Max out the width of the current split - ctrl + w |
"Normalize all split sizes - ctrl + w =

"Swap top/bottom or left/right split - Ctrl+W R
"Break out current window into a new tabview - Ctrl+W T
"Close every window in the current tabview but the current one - Ctrl+W o
set splitbelow
set splitright

" -- :help index --

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :AutoSaveToggle<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListRsume<CR>


map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

nnoremap <C-J> <C-W><C-J> " navigate down
nnoremap <C-K> <C-W><C-K> " navigate up
nnoremap <C-L> <C-W><C-L> " navigate right
nnoremap <C-H> <C-W><C-H> " navigate left

" ctags
nmap <leader>c <plug>NERDCommenterToggle
xmap <leader>c <plug>NERDCommenterToggle

nmap <leader>v <C-w>v<CR>
nmap <leader>h <C-w>s<CR>

nmap \ <C-w>:Files<CR>
nmap . :Rg<cr>
nmap m <C-w>:History<CR>
nmap <leader>u :UndotreeToggle<CR>
nmap <leader>x :qa<cr>
nmap <leader>t :NERDTreeToggle<cr>
nmap <C-T> :NERDTreeFind<cr>
nmap <silent><leader>w :w<cr>
nmap <leader>s :TagbarToggle<cr>
" copy curent buffer filepath
nmap <silent><leader>p :let @+=expand("%:p")<CR>
"command! SW :execute ':silent w !sudo tee % > /dev/null' | :edit!
cmap w!! w !sudo tee % >/dev/null<Up>

" legacy mappings
nmap  <C-F3> :NERDTreeToggle<cr>
nmap  <C-F4> :w<cr>
nmap  <C-F7> <C-w>:Files<CR>
nmap  <C-F8> :History<cr>

" Enable/Disable paste mode, where data won't be autoindented
set pastetoggle=<C-F1>
set spelllang=en_us
nmap  <C-F2> :set spell!<CR>

" copy / paste
vmap <C-C> "+y
imap <C-V> <esc>"+pi

nnoremap ; :
nnoremap <leader>; q:i

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"
:cabbrev h vert h
