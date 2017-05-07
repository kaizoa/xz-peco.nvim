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
              \'stadout': []
              \}))
endfunction

function s:Peco.run() dict abort
  termopen(self.cmd . ' | peco', self)
endfunction

function s:Peco.on_stdout(id, data) dict
  echomsg join(a:data)
endfunction

function s:Peco.on_stderr(id, data) dict
  " no-op
endfunction

function s:Peco.on_exit(id, data) dict
  " no-op
endfunction


function! xz#peco#open(cmd)
  let l:job = s:Peco.new(cmd)
  call l:job.run()
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
" vim: ts=2 sw=2 sts=2 et foldenable foldmethod=marker foldcolumn=1

