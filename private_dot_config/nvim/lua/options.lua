require "nvchad.options"

local o = vim.o

o.cursorlineopt = "both"
o.encoding = "utf-8"
o.showmatch = true

o.showmatch = true -- show matching
o.incsearch = true -- incremental search
o.ignorecase = true -- case insensitive
o.smartcase = true -- if search term has an uppercase letter, case sensitive

o.tabstop = 2 -- number of columns occupied by a tab
o.softtabstop = 2 -- see multiple spaces as tabstops so <BS> does the right thing
o.shiftwidth = 2 -- width for autoindents
o.expandtab = true -- converts tabs to white space
o.autoindent = true -- indent a new line the same amount as the line just typed

o.number = true -- add line numbers
o.relativenumber = true

o.wrap = true -- line wrap

-- split window default directions
o.splitbelow = true
o.splitright = true

o.scrolloff = 8 -- number of lines to display ahead of the cursor
o.signcolumn = "yes" -- always display symbols gutter (avoids jumping gutter when no symbols are displayed)
