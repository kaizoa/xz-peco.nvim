"=============================================================================
"" File: xz-peco.nvim
" Author: kaizoa
" " Created: 2017-05-06
" "=============================================================================
scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim


let s:Peco = {}

function s:Peco.new(cmd) dict abort
  return copy(extend(self, {
              \'cmd': a:cmd,
              \'tempname': tempname()
              \}))
endfunction

function s:Peco.run() dict abort
  let l:cmd = self.cmd . ' | peco >| ' . self.tempname
  if has('nvim')
    call termopen(l:cmd, self)
  else
    exec 'silent !' . l:cmd
    exec 'edit ' . system('cat ' . self.tempname)
    redraw!
  endif
endfunction

function s:Peco.on_exit(id, data) dict
  execute ':edit ' . system('cat ' . self.tempname)
endfunction

function! xz#peco#edit(cmd) abort
  call s:Peco.new(a:cmd).run()
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: ts=2 sw=2 sts=2 et foldenable foldmethod=marker foldcolumn=1

