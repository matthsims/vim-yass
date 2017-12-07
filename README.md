# vim-yass: yet another smooth scroller

This plugin is motivated by the lack of customizability of other smooth
scrollers.

yass simply provides a scroll function that smoothly scrolls the requested
distance. By default, the various z relative scrolling, and ctrl-D,U,F,B are
mapped.



## Installation

If you don't have a preferred installation method, I recommend [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'matthsims/vim-yass'
```


## Configuration
By default, the **function** of the z and ctrl movements should not change:
```vim
nnoremap <Plug>YassDown :call yass#scroll(&scroll, 1)<CR>
nmap <C-d> <Plug>YassDown
```

To prevent the z mappings, `let g:yass_noz=1`
To prevent the ctrl mappings, `let g:yass_noc=1`
The ctrl or z mappings will be skipped if a conflict is detected. See `:help yass`

To control the speed of the sliding, there are two relevant options:
```vim
" default update interval in miliseconds
let g:yass_interval = 20

" default speed function
let g:Yass_speed = {y, speed -> 55 + 2*y + 50*tanh((y-10)/5)}
```
`g:Yass_speed` is called with two args, `g:Yass_speed(y, speed)` where y is the
approximate number of lines left to travel, and speed is the speed at last
calculation. The plugin handles the direction of travel by calling `yass#scroll`
with a positive or negative value, so `g:Yass_speed` must be a positive valued
function. The returned value of `g:Yass_speed` is treated as lines/second.

For more detail, see `:help yass`


## License

MIT License
