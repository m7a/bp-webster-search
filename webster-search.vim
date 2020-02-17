function! WebsterSearch(term)
  execute "let output = system('webster_dict " . l:command . "')"
  vnew
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile encoding=utf8
  call setline(1, split(output, "\n"))
endfunction
command! -nargs=1 WebsterSearch call WebsterSearch(<args>)
