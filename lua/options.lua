require "nvchad.options"

local o = vim.o
local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- o.cursorlineopt ='both' -- to enable cursorline!
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
