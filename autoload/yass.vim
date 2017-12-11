" vim-yass https://github.com/matthsims/vim-yass
" File: yass.vim
" Author: Matt Simmons <matt.simmons at compbiol.org>
" License: MIT license

scriptencoding utf-8

if !exists('g:loaded_yass')
	finish
endif
let g:loaded_yass = 1


let s:save_cpo = &cpo
set cpo&vim

" Defaults
let g:yass_interval = exists('g:yass_interval') ? g:yass_interval : 20
let g:yass_minimum = exists('g:yass_minimum') ? g:yass_minimum : 8

if !exists('g:Yass#speed')
	let g:Yass#speed = {y -> 55 + 2*y + 50*tanh((y-10)/5)}
endif

function! s:scroll_handler(timer)
	if s:remaining <= 0 ||
				\ (line('.') == 1 && s:direction == -1) ||
				\ (line('.') == line('$') && s:direction == 1)
		call timer_stop(a:timer)
		silent! unlet s:timer_id  " silent for the looped version in #scroll
		let s:direction = 0
		return
	endif

	" calculate dy ...
	let l:speed = g:Yass#speed(s:remaining + s:dy)
	if l:speed <= 8
		let l:speed = 8
	endif

	let s:dy += l:speed * reltimefloat(reltime(s:relt))
	let s:relt = reltime()
	let l:dy_step = float2nr(floor(s:dy))
	if l:dy_step == 0
		return
	endif
	let s:dy -= l:dy_step
	let s:remaining -= l:dy_step

	" scroll ...
	if l:dy_step <= 0
		return
	endif
	let l:save_scrolloff = &scrolloff
	set scrolloff=0
	let l:cmd = 'normal! ' . string(l:dy_step) . (s:direction > 0 ? "\<C-e>" : "\<C-y>")
	if s:scroll_with_cursor
		let l:cmd .= string(l:dy_step) . (s:direction > 0 ? "gj" : "gk")
	endif
	execute l:cmd
	let &scrolloff = l:save_scrolloff
	redraw
endfunction

function! yass#reset()
	let s:dy = 0.0
	let s:remaining = 0
	let s:direction = 0
	let s:scroll_with_cursor = 0

	if has('timers') && exists('s:timer_id')
		call timer_stop(s:timer_id)
		unlet s:timer_id
	endif
endfunction

function! yass#scroll(distance, ...)
	let s:scroll_with_cursor = (a:0 >= 1) ? a:1 : 0
	let l:override = (a:0 >= 2) ? a:2 : 0
	if l:override
		call yass#reset()
	endif
	let s:remaining = s:direction * s:remaining + float2nr(a:distance)
	let s:direction = s:remaining > 0 ? 1 : -1
	let s:remaining = abs(s:remaining)
	let s:relt = reltime()

	let l:interval = float2nr(round(g:yass_interval))
	if !has('timers')
		while s:remaining > 0
			let s:timer_id = 1
			call s:scroll_handler(s:timer_id)
			execute 'sleep '.l:interval.'m'
		endwhile
	elseif !exists("s:timer_id")
		let s:timer_id = timer_start(l:interval, function("s:scroll_handler"), {'repeat': -1})
	endif
endfunction

call yass#reset()

let &cpo = s:save_cpo
unlet s:save_cpo
