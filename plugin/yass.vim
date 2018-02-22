" vim-yass https://github.com/matthsims/vim-yass
" File: yass.vim
" Author: Matt Simmons <matt.simmons at compbiol.org>
" License: MIT license

scriptencoding utf-8

if exists('g:loaded_yass')
	finish
endif
if !has('patch-7.4.1285') && !has('nvim')
	finish
endif
let g:loaded_yass = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>YassDown      :call yass#scroll(&scroll, 1)<CR>
nnoremap <silent> <Plug>YassUp        :call yass#scroll(-&scroll, 1)<CR>
nnoremap <silent> <Plug>YassPageDown  :call yass#scroll(&scroll * 2, 0)<CR>
nnoremap <silent> <Plug>YassPageUp    :call yass#scroll(-&scroll * 2, 0)<CR>
nnoremap <silent> <Plug>Yass_zCR     ^:<C-u>call yass#scroll(winline() - &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zt       :<C-u>call yass#scroll(winline() - &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_z.      ^:<C-u>call yass#scroll(winline() - winheight(0)/2, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zz       :<C-u>call yass#scroll(winline() - winheight(0)/2, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_z-      ^:<C-u>call yass#scroll(winline() - winheight(0) + &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>Yass_zb       :<C-u>call yass#scroll(winline() - winheight(0) + &scrolloff, 0, 1)<CR>
nnoremap <silent> <Plug>YassC-e       :<C-u>call yass#scroll(v:count1, 0)<CR>
nnoremap <silent> <Plug>YassC-y       :<C-u>call yass#scroll(- v:count1, 0)<CR>

let s:bindings = {
			\  '<C-e>' : '<Plug>YassC-e',
			\  '<C-y>' : '<Plug>YassC-y',
			\  '<C-d>' : '<Plug>YassDown',
			\  '<C-u>' : '<Plug>YassUp',
			\  '<C-f>' : '<Plug>YassPageDown',
			\  '<C-b>' : '<Plug>YassPageUp',
			\  'z<CR>' : '<Plug>Yass_zCR',
			\  'zt'    : '<Plug>Yass_zt',
			\  'z.'    : '<Plug>Yass_z.',
			\  'zz'    : '<Plug>Yass_zz',
			\  'z-'    : '<Plug>Yass_z-',
			\  'zb'    : '<Plug>Yass_zb'
			\ }

if !exists('g:yass_nobind')
	for bind in keys(s:bindings)
		if !hasmapto(s:bindings[bind]) && maparg(bind, 'n') ==# ''
			execute	'nmap ' . bind . ' ' . s:bindings[bind]
		endif
	endfor
endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=2 sw=2 tw=99 noet :
