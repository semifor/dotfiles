set nocompatible " this aint vi, it's vim

" initialize plugin manager
if has('nvim')
    call plug#begin('~/.local/share/nvim/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'mattn/gist-vim'
" required by gist-vim
Plug 'mattn/webapi-vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'pangloss/vim-javascript'

" sensible.vim plugin is not needed; Nvim has the same defaults built-in.
" Also, sensible.vim sets 'ttimeoutlen' to a sub-optimal value.
if !has('nvim')
    Plug 'tpope/vim-sensible'
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tsaleh/vim-align'
Plug 'vim-perl/vim-perl'
Plug 'vim-scripts/zoomwintab.vim'
Plug 'vimwiki/vimwiki'

" Damian's config has many plugins in a single plugin directory. I localized
" it in a branch by moving the plugin dir to unused-plugins and moving back
" the plugins I want.
"""Plug 'thoughtstream/Damian-Conway-s-Vim-Setup', { 'pinned': 1 }

" All of your Plugins must be added before the following line
call plug#end()            " required

syntax on
filetype plugin indent on

set hidden

" when both numbe and relative number are set, the current line displays the
" absolute number in the gutter, and the other lines display a relative number
set number
set relativenumber

set undodir=~/.vim/tmp/undo//
set undofile "persistent undo

set visualbell
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

set showbreak=↪

" my fingers misspell these words all the time; fix em
ab gonig going
ab vaule value
ab relpy reply
ab susbscriber subscriber
ab subsription subscription

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

"=====[ Search folding ]=====================

" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black

" Toggle on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':1})

" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
    autocmd!
    autocmd BufEnter * nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
    autocmd BufEnter * nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter * nmap <silent> <expr>             zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" Show only C #includes...
nmap <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})

" default leader is a backslash. Comma is much easier
let mapleader=','
noremap \ ,

nnoremap <leader>y "*y
nnoremap <leader><leader> <C-^>

map <leader>al :Align =><cr>
map <leader>so :source %<cr>

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
nnoremap <leader>gp :Dispatch! git push<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gt :Git
nnoremap <leader>gu :Dipatch! git pull<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gxp :Dispatch! git push -f<CR>
nnoremap <leader>gxu :Dispatch! git pull -r<CR>
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

"======[ from https://www.youtube.com/watch?v=XA2WjJbmmoM ]=======

" fuzzy filed with :find
set path+=**

"======[ https://twitter.com/MasteringVim/status/811868588785143808 ]=======

" move a visual block up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"======[ UltiSnips configruation ]============================================

let g:UltiSnipsSnippetsDir         = '~/.vim/UltiSnips/'
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsListSnippets        = '<shift-tab>'
let g:UltiSnipsJumpForwardTrigger  = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-h>'

"======[ zoomwintab.vim ]============================================

" I prefer <c-w>z, because sametimes I want :only via <c-w>o, too
let g:zoomwintab_remap = 0
noremap <c-w>z :ZoomWinTabToggle<cr>
noremap <c-w><c-z> :ZoomWinTabToggle<cr>

" unless overwridden by file types:
set ts=4 sw=4 sts=4 expandtab cindent

" In insert mode, insert a new line, above the cursor, and start editing,
" there. Since I type on a Dvorak layout, typicall on a Mac keyboard with the
" left shift key remapped to Ctrl, <C-o>O is a difficult combination to type.
" It would be like typiong <C-s>S on a QWERTY keyboard. So, make it a single
" keystroake with Ctrl on the left and `s` on the right.
"
" This is really handy for closing braces. E.g., in perl, the following
" keystrokes:
"
"     before all => sub{<ENTER>};
"
" produce:
"
"     before all => sub {
"     };
"
" with the cursor in insert mode, following the final semicolon.
"
" Now, pressing <C-s> inserts a blank line above the cursor and enters insert
" mode, which, with `ciendent` set places the cursor at the correct insert
" level so you never have to leave insert mode:
"
"     before all => sub {
"         | <- cursort here
"     };
"
imap <C-s> <C-o>O
