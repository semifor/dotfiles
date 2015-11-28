" perl

setl ts=4 sw=4 sts=4 cindent tw=0 nolist expandtab nodigraph spell

nnoremap [[ ?{<CR>w99[{
nnoremap ]] j0[[%/{<CR>

setl makeprg=perl\ -Ilib\ -c\ %\ $*
setl errorformat=%f:%l:%m

" comment blocks of code
vmap <leader>c :s/^/#/g<Enter>
vmap <leader>C :s/^#//g<Enter>

" Align on =>
nmap <leader>al :Align =><CR>

let perl_include_pod = 1
let perl_extended_vars = 1
