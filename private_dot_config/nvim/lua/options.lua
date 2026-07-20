vim.o.encoding = "utf-8"
vim.o.showmatch = true

-- vim.o.incsearch = true     --- incremental search
-- vim.o.ignorecase = true    --- case insensitive
-- vim.o.smartcase = true     --- if search term has an uppercase letter, case sensitive

vim.o.tabstop = 2      --- number of columns occupied by a tab
vim.o.softtabstop = 2  --- see multiple spaces as tabstops so <BS> does the right thing
vim.o.shiftwidth = 2   --- width for autoindents
vim.o.expandtab = true --- converts tabs to white space
-- vim.o.autoindent = true      --- indent a new line the same amount as the line just typed

vim.o.relativenumber = true

vim.o.wrap = true      --- line wrap
vim.o.linebreak = true --- wrap on whitespace

-- split window default directions
vim.o.splitbelow = true
vim.o.splitright = true

vim.o.foldmethod = "expr"
vim.o.foldlevel = 99
vim.o.foldlevelstart= 99
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.o.foldcolumn = "0"

vim.o.scrolloff = 4      --- number of lines to display ahead of the cursor
vim.o.signcolumn = "yes" --- always display symbols gutter (avoids jumping gutter when no symbols are displayed)

--- use system clipboard by default
vim.o.clipboard = "unnamedplus"
--- sync buffers automatically
vim.o.autoread = true
--- disable neovim generating a swapfile and showing the error
vim.o.swapfile = false

vim.opt.sessionoptions:remove('blank')
vim.o.listchars = table.concat({
  "extends:…",
  "nbsp:␣",
  "multispace:·",
  "trail:·",
  "precedes:…",
  "tab:> ",
}, ",")

--- Set window name to current dir
-- vim.cmd[[set titlestring=%(%{expand(\"%:~:h\")}%)]]
vim.opt.title = true
vim.opt.titlestring = vim.fs.basename(vim.fn.getcwd())
