" perl

let perl_include_pod = 1
let perl_extended_vars = 1
let perl_fold = 1
let perl_nofold_packages = 1
let perl_fold_anonymous_subs = 1

set tabstop=4      "Tab indentation levels every four columns
set shiftwidth=4   "Indent/outdent by four columns
set expandtab      "Convert all tabs that are typed into spaces
set shiftround     "Always indent/outdent to nearest tabstop
set smarttab       "Use shiftwidths at left margin, tabstops everywhere else

setl cindent tw=0 nolist nodigraph spell foldmethod=syntax

nnoremap [[ ?{<CR>w99[{
nnoremap ]] j0[[%/{<CR>

setl makeprg=perl\ -Ilib\ -c\ %\ $*
setl errorformat=%f:%l:%m

" comment blocks of code
vmap <leader>c :s/^/#/g<Enter>  "comment
vmap <leader>C :s/^#//g<Enter>  "uncomment

" Align on =>
nmap <leader>al :Align =><CR>

