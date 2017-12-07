"=============================
" File: yass.vim
" Author: Matt Simmons
" License: MIT license
"=============================

scriptencoding utf-8

if exists('g:loaded_yass')
	finish
endif
let g:loaded_yass = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <Plug>YassDown :call yass#scroll(&scroll, 1)<CR>
nnoremap <Plug>YassUp :call yass#scroll(-&scroll, 1)<CR>

nnoremap <silent> <Plug>Yass_zCR   ^:<C-u>call yass#scroll(line(".") - line("w0") + &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zt     :<C-u>call yass#scroll(line(".") - line("w0") + &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zdot  ^:<C-u>call yass#scroll(line(".") - (line("w$") + line("w0")) / 2, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zz     :<C-u>call yass#scroll(line(".") - (line("w$") + line("w0")) / 2, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zdash ^:<C-u>call yass#scroll(&scrolloff + line(".") - line("w$"), 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zb     :<C-u>call yass#scroll(&scrolloff + line(".") - line("w$"), 0, 1)<CR>

if !hasmapto('<Plug>YassDown') && maparg('<C-d>', 'n') ==# '' && !exists('g:yass_noc')
	nmap <C-d> <Plug>YassDown
	nmap <C-u> <Plug>YassUp
endif

if !hasmapto('<Plug>Yass_zz') && maparg('zz', 'n') ==# '' && !exists('g:yass_noz')
	nmap z<CR> <Plug>Yass_zCR
	nmap zt    <Plug>Yass_zt
	nmap z.    <Plug>Yass_zdot
	nmap zz    <Plug>Yass_zz
	nmap z-    <Plug>Yass_zdash
	nmap zb    <Plug>Yass_zb
endif

let &cpo = s:save_cpo
unlet s:save_cpo
