-- n i v x ...
vim.keymap.set('v','<C-c>',' :!xclip -f -sel clip<CR>')
vim.keymap.set({'i','n'},'<C-S-v>', ' mz:-1r !xclip -o -sel clip<CR>`z')
vim.keymap.set('n','<C-s>',':w<CR>')
vim.keymap.set('n','<C-q>',':wq<CR>')
vim.keymap.set('i','jk','<ESC>:w<CR>')
