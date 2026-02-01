--- Color scheme
local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add({
    source = 'rose-pine/neovim',
    name = 'rose-pine',
  })

  require("rose-pine").setup({
    variant = "auto",
    dark_variant = "moon",
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
      terminal = true,
      legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
      migrations = true,         -- Handle deprecated options automatically
    },

    styles = {
      bold = true,
      italic = true,
      transparency = true,
    },
  })

  vim.cmd("colorscheme rose-pine")
end)
