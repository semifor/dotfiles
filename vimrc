execute pathogen#infect()
syntax on
filetype plugin indent on

set number hidden visualbell
set history=5000
set statusline=%<%f\ %y%m%r\ %{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" From Destroy All Software #10: File navigation in vim
" (https://www.destroyallsoftware.com/screencasts/catalog/file-navigation-in-vim)
set winwidth=84
" We want winheight larger than winminheight, but if we set winheight to a huge
" value before winminheight, set winminheight will fail.
set winheight=5
set winminheight=5
set winheight=999

" my fingers misspell these words all the time; fix em
ab gonig going
ab vaule value
ab relpy reply

" ------ trailing whitespace is the devil
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
highlight EOLWS ctermbg=red guibg=red

"------ Search related
set hlsearch
set incsearch
" keep search in center of window
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
" <ctr-l> also turns off highlighting
nnoremap <silent> <C-l> :<C-u>nohls<CR><C-l>

" default leader is a backslash. Comma is much easier
let mapleader=','
noremap \ ,

nnoremap <leader>y "*y
nnoremap <leader><leader> <C-^>

map <leader>al :Align =><cr>

" fugitive mappings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gb :Gblame -w<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gf :Glgrep<Space>
nnoremap <leader>gg :Ggrep<Space>
nnoremap <leader>gl :silent! Glog<CR>:copen<CR>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gp :Gpush<Space>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gt :Git
nnoremap <leader>gu :Gpull<Space>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gz :Gbrowse

" Keep the buffer list clean by deleted buffers created by fugitive when they
" are closed. Also from:
" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete

" for getting color in tmux/vim, see:
" http://bentomas.com/2012-03-28/256-colors-in-tmux.html
set t_Co=256

" see:
" http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
" solarized_termcolors = 256 works for me, but the background doesn't seem
" quite right.
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast   = "high"
let g:solarized_termcolors = 256
colorscheme solarized

" to make tmux+vim play nice with the Mac clipboard, see:
" https://coderwall.com/p/j9wnfw
" which says:
"   brew install reattach-to-user-namespace
"   in .vimrc: set clipboard=unnamed
"   in .tmux.conf:
"     set-option -g default-command "reattach-to-user-namespace -l bash"
"   in .bash_profile:
"     alias vi='mvim -v'
"     alias vim='mvim -v'
set clipboard=unnamed

let g:gist_put_url_to_clipboard_after_post = 1
let g:gist_clip_command = 'pbcopy'
let g:gist_show_privates = 1
let g:gist_post_private = 1
