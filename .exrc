setl spell
setl nocursorline
setl nuw=10

setl stl=%2n%{mode()}\ %q%f\ %{Status_wordcount()}\ %m%=%l/%L\ %-4P

function! Status_wordcount(...)
  if ( a:0 > 0 )
    let format = a:1
  else
    let format = '[%sw]'
  endif
  let oldstat = v:statusmsg
  let position = getpos('.')
  exe ":silent normal! g\<C-g>"
  let status = v:statusmsg
  let wordcount = ''
  if ( status != '--No lines in buffer--' )
    let st = split(substitute(status, ';', '', 'g'))
    if ( mode() !~? '[v]' )
      let wordcount = st[11]
    else
      let wordcount = st[7] . '(' . st[5] . ')'
    endif
  endif
  let v:statusmsg = oldstat
  call setpos('.', position)
  unlet oldstat position status
  return printf(format, wordcount)
endfunction
