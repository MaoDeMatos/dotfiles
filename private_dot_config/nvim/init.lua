--- 'mini.nvim' setup
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    --- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

--- 'Custom options'
vim.g.mapleader = " "
require("options")

--- Start 'mini.deps'
require('mini.deps').setup({ path = { package = path_package } })

--- Core features
require("mini.basics").setup({
  options = {
    basic = true,
    extra_ui = true,
    win_borders = "bold",
  },
})
require("mini.completion").setup({
  window = {
    info = { border = "solid" },
    signature = { border = "solid" },
  },
})
require("mini.files").setup({
  mappings = {
    close = "<esc>",
  },
  windows = {
    preview = true,
    border = "rounded",
    width_preview = 80,
  },
})
-- require("mini.clue").setup() -- which-key

--- UI
require("mini.starter").setup({
  autoopen = true,
  items = {
    {
      {
        name = "Recent files",
        action = function() require("mini.extra").pickers.oldfiles() end,
        section = "Search"
      },
      {
        name = "Sessions",
        action = function() require("mini.sessions").select() end,
        section = "Search"
      }
    },
    require("mini.starter").sections.sessions(5, true),
    require("mini.starter").sections.recent_files(5, false, false),
    -- require("mini.starter").sections.recent_files(5, true, false),
  },
  header = function()
      local v = vim.version()
      local versionstring = string.format("\n v%d.%d.%d", v.major, v.minor, v.patch)
      --- Every "image" is an array with lines of chars
      local imageData = require("ascii/neovim").delta_corps_priest1
      -- local imageData = require("ascii/neovim").ansi_shadow
      return table.concat(imageData, "\n" ) .. versionstring
  end
})

require('mini.hues').setup({ background = '#19213a', foreground = '#c4c6cd' })
require("mini.icons").setup()
require("mini.map").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.indentscope").setup({
  draw = {
    delay = 0,
    animation = require("mini.indentscope").gen_animation.none(),
  },
  symbol = "│"
})
-- require("mini.trailspace").setup()
require("mini.notify").setup()

--- New features
require("mini.pick").setup({
  window = {
    prompt_prefix = '   ',
  },
})
require("mini.extra").setup() --- extra pickers for mini.pick and some other additionnal features
require("mini.sessions").setup({
  autowrite = true,
  file = '', --- disable local session storage.
})
require("mini.snippets").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.git").setup()
require("mini.diff").setup()

--- Init configs after loading plugins
require("mappings")
require("autocmds")
