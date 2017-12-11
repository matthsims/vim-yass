" vim-yass https://github.com/matthsims/vim-yass
" File: yass.vim
" Author: Matt Simmons <matt.simmons at compbiol.org>
" License: MIT license

scriptencoding utf-8

if exists('g:loaded_yass')
	finish
endif
let g:loaded_yass = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>YassDown      :call yass#scroll(&scroll, 1)<CR>
nnoremap <silent> <Plug>YassUp        :call yass#scroll(-&scroll, 1)<CR>

nnoremap <silent> <Plug>YassPageDown  :call yass#scroll(&scroll * 2, 1)<CR>
nnoremap <silent> <Plug>YassPageUp    :call yass#scroll(-&scroll * 2, 1)<CR>

nnoremap <silent> <Plug>Yass_zCR     ^:<C-u>call yass#scroll(winline() - &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zt       :<C-u>call yass#scroll(winline() - &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_z.      ^:<C-u>call yass#scroll(winline() - winheight(0)/2, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zz       :<C-u>call yass#scroll(winline() - winheight(0)/2, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_z-      ^:<C-u>call yass#scroll(winline() - winheight(0) + &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zb       :<C-u>call yass#scroll(winline() - winheight(0) + &scrolloff, 0, 1)<CR>

if !hasmapto('<Plug>YassDown') && maparg('<C-d>', 'n') ==# '' && !exists('g:yass_noc')
	nmap <C-d> <Plug>YassDown
	nmap <C-u> <Plug>YassUp

	nmap <C-f> <Plug>YassPageDown
	nmap <C-b> <Plug>YassPageUp
endif

if !hasmapto('<Plug>Yass_zz') && maparg('zz', 'n') ==# '' && !exists('g:yass_noz')
	nmap z<CR> <Plug>Yass_zCR
	nmap zt    <Plug>Yass_zt
	nmap z.    <Plug>Yass_z.
	nmap zz    <Plug>Yass_zz
	nmap z-    <Plug>Yass_z-
	nmap zb    <Plug>Yass_zb
endif

let &cpo = s:save_cpo
unlet s:save_cpo
