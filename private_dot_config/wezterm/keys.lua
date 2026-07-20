local wezterm = require("wezterm")
local utils = require("custom-utils")
local pre_peek_callback = require("peek_to_alternate").pre_peek_callback

--- Must respect wezterm's 'config.keys' format
return {
  {
    -- Flip between primary and alternate screen without disturbing the running app.
    -- Uses ?47 (raw buffer swap) instead of ?1049 (which clears the alt buffer).
    -- Activates peek_mode key table while peeking so any keypress returns to the app.
    key = 'F12',
    action = pre_peek_callback,
  },

  --- Manage panes & tabs
  {
    mods = "SHIFT|ALT",
    key = "d",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = utils.is_darwin and "CMD|SHIFT" or "CTRL|SHIFT",
    key = "d",
    action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    mods = utils.is_darwin and "CMD|SHIFT" or "CTRL|SHIFT",
    key = "w",
    action = wezterm.action.CloseCurrentPane({ confirm = true }), -- Also closes the tab if only one pane
  },
  {
    mods = utils.is_darwin and "CMD|SHIFT" or "CTRL|SHIFT",
    key = "t",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  --- Move between panes
  {
    mods = "SHIFT|ALT",
    key = "DownArrow",
    action = wezterm.action.ActivatePaneDirection("Down"),
  },
  {
    mods = "SHIFT|ALT",
    key = "UpArrow",
    action = wezterm.action.ActivatePaneDirection("Up"),
  },
  {
    mods = "SHIFT|ALT",
    key = "LeftArrow",
    action = wezterm.action.ActivatePaneDirection("Left"),
  },
  {
    mods = "SHIFT|ALT",
    key = "RightArrow",
    action = wezterm.action.ActivatePaneDirection("Right"),
  },

  --- Test: Macos Natural Text editing mode
  { mods = "ALT", key = "LeftArrow",  action = wezterm.action.SendKey({ mods = "ALT", key = "b" }) },
  { mods = "ALT", key = "RightArrow", action = wezterm.action.SendKey({ mods = "ALT", key = "f" }) },
  { mods = "CMD", key = "LeftArrow",  action = wezterm.action.SendKey({ mods = "CTRL", key = "a" }) },
  { mods = "CMD", key = "RightArrow", action = wezterm.action.SendKey({ mods = "CTRL", key = "e" }) },
  { mods = "CMD", key = "Backspace",  action = wezterm.action.SendKey({ mods = "CTRL", key = "u" }) },
}
