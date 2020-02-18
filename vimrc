"----------------------------------------
" Welcome to kotamiyake's vimrc
"

if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

"----------------------------------------
" Plugins
"

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('neoclide/coc.nvim', { 'rev': 'release' })
  call dein#add('w0rp/ale')
  call dein#add('junegunn/fzf.vim')
  call dein#add('mileszs/ack.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('janko-m/vim-test')
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')
  call dein#add('tpope/vim-rails')
  call dein#add('fatih/vim-go')
  call dein#add('mattn/webapi-vim')
  call dein#add('mattn/gist-vim')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
        \ 'build': 'cd app & yarn install' })
  call dein#add('udalov/kotlin-vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('StanAngeloff/php.vim')

  call dein#end()
  call dein#save_state()
endif

" vim-gitgutter
augroup MyAutoCmd
  autocmd ColorScheme * highlight GitGutterAdd cterm=bold ctermfg=82 ctermbg=0
  autocmd ColorScheme * highlight GitGutterChange cterm=bold ctermfg=11 ctermbg=0
  autocmd ColorScheme * highlight GitGutterDelete cterm=bold ctermfg=red ctermbg=0
augroup END

" coc.vim
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

autocmd CursorHold * silent call CocActionAsync('highlight')

" ale
let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'ruby': ['rubocop', 'reek'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'elixir': ['credo', 'elixir-ls'],
      \ 'scss': ['stylelint'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['eslint'],
      \ 'go': ['goimports', 'gofmt'],
      \ 'scss': ['stylelint'],
      \ }
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '△'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_javascript_prettier_use_local_config = 1
augroup MyAutoCmd
  autocmd ColorScheme * highlight ALEErrorSign cterm=bold ctermfg=red ctermbg=0
  autocmd ColorScheme * highlight ALEWarningSign cterm=bold ctermfg=11 ctermbg=0
augroup END

" fzf.vim
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap t :Files<CR>
nmap r :Tags<CR>

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nmap [q :cnext<CR>
nmap ]q :cprev<CR>
nmap , :Ack "\b<cword>\b" <CR>

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" vim-test
nmap <silent> <Leader><C-n> :TestNearest<CR>
nmap <silent> <Leader><C-f> :TestFile<CR>
nmap <silent> <Leader><C-s> :TestSuite<CR>
nmap <silent> <Leader><C-l> :TestLast<CR>
nmap <silent> <Leader><C-g> :TestVisit<CR>
let test#strategy = 'dispatch'

" vim-surround
let g:surround_61 = "<%= \r %>"
let g:surround_45 = "<% \r %>"

" vim-fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

filetype plugin indent on
syntax enable

"----------------------------------------
" Encoding:
"

set encoding=utf-8

"----------------------------------------
" Search:
"

set ignorecase
set smartcase
set incsearch
set hlsearch

"----------------------------------------
" Edit:
"

set smarttab
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set modeline
set modelines=1
set backspace=indent,eol,start
set autoindent
set smartindent
set ambiwidth=double
set splitbelow
set clipboard+=unnamed

augroup MyAutoCmd
  " Cusom filetypes
  autocmd BufNewFile,BufRead .babelrc,.eslintrc set filetype=json
  autocmd BufNewFile,BufRead Gemfile,*.jb set filetype=ruby
  autocmd BufNewFile,BufRead .envrc set filetype=sh
augroup END

"----------------------------------------
" View:
"
set number
set laststatus=2
set showcmd
set wildmenu
set wildmode=longest,list
set listchars=tab:>.,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set list
set history=1000
set nobackup
set noswapfile
set nowritebackup
set noundofile
let php_folding=1

highlight Pmenu ctermbg=6 guibg=#4c745a
highlight PmenuSel ctermbg=3 guibg=#d4b979
highlight PmenuSbar ctermbg=0 guibg=#333333
highlight Search cterm=BOLD ctermfg=yellow ctermbg=NONE

colorscheme gruvbox
set background=dark

"----------------------------------------
" KeyMap:
"

map ¥ <Leader>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
imap <C-a> <C-o>0
imap <C-e> <C-o>$
imap <C-f> <right>
imap <C-b> <left>
map <C-e> $
map <C-a> 0
