# vim-yass: yet another smooth scroller

yass simply provides a scroll function that smoothly scrolls the requested
distance. By default, the various z relative scrolling, and ctrl-D,U,F,B are
mapped.


## Configuration
By default, the **function** of the z and ctrl movements should not change, but 
they will do it smoothly.
See `:help yass` for information on changing the function, and more detail

To control the speed of the sliding, there are two relevant options:
```vim
" default update interval in miliseconds
let g:yass_interval = 16

" default speed function
" must accept 1 argument, which is the distance remaining to travel
function g:Yass_speed(y)
  return 58 + 2*a:y + 50*tanh((a:y-10)/5)
endfunction
```
`g:Yass_speed` is called with two args, `g:Yass_speed(y, speed)` where y is the
approximate number of lines left to travel, and speed is the speed at last
calculation. The plugin handles the direction of travel by calling `yass#scroll`
with a positive or negative value, so `g:Yass_speed` must be a positive valued
function. The returned value of `g:Yass_speed` is treated as lines/second.

For more detail, see `:help yass`


## License

MIT License
