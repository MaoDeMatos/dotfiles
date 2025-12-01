local wezterm = require("wezterm")
local utils = require("custom-utils")

--- Must respect wezterm's 'config.keys' format
return {
  --- Manage panes & tabs
  {
    key = "d",
    mods = utils.is_darwin and "CMD|SHIFT" or "CTRL|SHIFT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "d",
    mods = utils.is_darwin and "CMD" or "CTRL",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "w",
    mods = utils.is_darwin and "CMD|SHIFT" or "CTRL|SHIFT",
    action = wezterm.action.CloseCurrentPane({ confirm = true }), -- Also closes the tab if only one pane
  },
  {
    key = "t",
    mods = utils.is_darwin and "CMD|SHIFT" or "CTRL|SHIFT",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },
  --- Move between panes
  {
    key = "DownArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    key = "UpArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    key = "LeftArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    key = "RightArrow",
    mods = "ALT",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },
}
