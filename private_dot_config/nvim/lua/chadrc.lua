-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- TODO: Use a custom theme, generated from the wallpaper image
M.base46 = {
  transparency = true,
  theme = "rosepine",
  theme_toggle = { "rosepine", "rosepine-dawn" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }

-- Always load 'tabufline' to access the theme toggle
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

return M
