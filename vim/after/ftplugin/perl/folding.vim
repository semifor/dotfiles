" Custome folding for perl
" Based on the script Drew Neil persented at
" http://vimcasts.org/episodes/writing-a-custom-fold-expression/
function! PerlFolds()
  let thisline = getline(v:lnum)
  if match(thisline, '^\w.*[\[{}(]$' ) >= 0
    return ">1"
  endif
  return "="
endfunction
setlocal foldmethod=expr
setlocal foldexpr=PerlFolds()

function! PerlFoldText()
  let foldsize = (v:foldend-v:foldstart)
  return getline(v:foldstart).' '.foldsize.' lines'
endfunction
setlocal foldtext=PerlFoldText()
