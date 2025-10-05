local map = vim.keymap.set

local split_sensibly = function()
  if vim.api.nvim_win_get_width(0) > math.floor(vim.api.nvim_win_get_height(0) * 2.3) then
    vim.cmd("vs")
  else
    vim.cmd("split")
  end
end

---------------
--- General ---
---------------

map("n", "<esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "<leader>e", require("mini.files").open, { desc = "Open file explorer" })

--- Center cursor after finding next/previous search term
map("n", "n", "nzzzv", { desc = "Next search term" })
map("n", "N", "Nzzzv", { desc = "Previous search term" })

--- Center cursor after moving up/down a page
map("n", "<C-d>", "<C-d>zz", { desc = "Move up a page" })
map("n", "<C-u>", "<C-u>zz", { desc = "Move down a page" })

map("n", "<leader>tm", require("mini.map").toggle, { desc = "Toggle minimap" })

map("n", "<leader>la", function()
  split_sensibly()
  vim.cmd('terminal lazygit')
end, { desc = 'Lazygit' })

---------------
--- Edition ---
---------------

--- Insert empty line above or below cursor
map("n", "<leader>O", "[<leader>", { remap = true }, { desc = "Insert empty line above cursor" })
map("n", "<leader>o", "]<leader>", { remap = true }, { desc = "Insert empty line below cursor" })

--- Same behavior as the default keybinding, but keeping the cursor in place
map("n", "J", "mzJ`z")

map("n",
  "<leader>rw",
  function()
    local word = vim.fn.expand("<cword>")
    local cmd = ":%s/" .. word .. "/"
    vim.api.nvim_feedkeys(cmd, "n", false)
  end,
  { desc = "Replace word under cursor" }
)

---------------
--- Buffers ---
---------------

map("n", "<tab>", "<cmd>bn<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>bp<cr>", { desc = "Previous buffer" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete current buffer" })

---------------
--- Pickers ---
---------------

local pick = require("mini.pick").builtin
local extra_pick = require("mini.extra").pickers

map("n", "<leader>ff", pick.files, { desc = "Find file" })
map("n", "<leader>fo", extra_pick.oldfiles, { desc = "Find recent file" })
map("n", "<leader>fw", pick.grep_live, { desc = "Find word" })
map("n", "<leader>fr", pick.resume, { desc = "Resume last find" })
--- TODO: Add "find current word" (word under the cursor) using <cword>

map("n", "<leader>fd", extra_pick.diagnostic, { desc = "Open diagnostics" })
map("n", "<leader>fb", pick.buffers, { desc = "Find buffer" })

map("n", "<leader>fh", pick.help, { desc = "Find help page" })
map("n", "<leader>wk", extra_pick.keymaps, { desc = "Find keybinding" })

----------------
--- Sessions ---
----------------

map("n", "<leader>fs", function()
  vim.cmd("wa")
  require("mini.sessions").select()
end, { desc = "Session load" })

map("n", "<leader>sw", function()
  local cwd = vim.fn.getcwd()
  require("mini.sessions").write(cwd:match("([^/]+)$"))
end, { desc = "Session save" })
