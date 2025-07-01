require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- map('n', '<leader>w', ':w<CR>')
-- map('n', '<C-s>', ':w<CR>')
-- map('i', '<C-s>', '<ESC>:w<CR>')

-- -- Buffer navigation
-- map("n", "<leader>j", ":bnext<CR>")
-- map("n", "<leader>k", ":bprevious<CR>")
-- map("n", "<leader>bd", ":bd<CR>")

-- Same behavior as the default keybinding, but keeping the cursor in place
map("n", "J", "mzJ`z")

-- Center cursor after finding next/previous search term
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Center cursor after moving up/down a page
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Move the current selection up/down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep selection when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Insert empty line above or below cursor
map("n", "<leader>O", "[<leader>", { remap = true })
map("n", "<leader>o", "]<leader>", { remap = true })

-- Remove unused mappings
-- Increment/decrement number under cursor
map("n", "<C-a>", "<nop>")
map("n", "<C-x>", "<nop>")
