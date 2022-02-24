if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('morhetz/gruvbox')
  call dein#add('itchyny/lightline.vim')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('junegunn/fzf.vim')
  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
  call dein#add('w0rp/ale')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-endwise')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
      \ 'build': 'cd app & yarn install' })
  call dein#add('github/copilot.vim')
  call dein#end()
  call dein#save_state()
endif

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}

filetype plugin indent on
syntax enable

" Show line number
set number

" Split window to below
set splitbelow

" Set colorscheme with gruvbox
colorscheme gruvbox
set background=dark

" Copy yank to clipboard
set clipboard=unnamedplus

" fzf.vim
set rtp+=/usr/local/opt/fzf
nmap ; :Buffers<CR>
nmap t :Files<CR>
nmap r :Tags<CR>

" coc.vim
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ale
let g:ale_fix_on_save = 1
let g:ale_linters = {
      \ 'ruby': ['rubocop', 'reek'],
      \ 'javascript': ['eslint'],
      \ 'typescript': ['eslint'],
      \ 'vue': ['eslint'],
      \ 'elixir': ['credo', 'elixir-ls'],
      \ 'scss': ['stylelint'],
      \ 'sass': ['stylelint'],
      \}
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'javascriptreact': ['prettier'],
      \ 'vue': ['prettier', 'eslint'],
      \ 'go': ['goimports', 'gofmt'],
      \ 'scss': ['stylelint'],
      \ 'sass': ['stylelint'],
      \ }
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_use_global_executables = 0

" neosnippet.vim
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" copilot.vim
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

"----------------------------------------
" Encoding:
"

set encoding=utf-8
set fileencodings=utf-8,cp932

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

" ファイルパスをコピー
nnoremap <Space><C-g> :<C-u>echo "copied fullpath: " . @% \| let @+=@%<CR>

" カスタムファイルタイプ設定
augroup SetFileType
  " Cusom filetypes
  autocmd BufNewFile,BufRead .babelrc,.eslintrc set filetype=json
  autocmd BufNewFile,BufRead *.jb set filetype=ruby
  autocmd BufNewFile,BufRead .envrc set filetype=sh
  autocmd BufNewFile,BufRead .env.template set filetype=txt
  autocmd BufNewFile,BufRead *.turbo_stream.erb set filetype=eruby.html
augroup END
