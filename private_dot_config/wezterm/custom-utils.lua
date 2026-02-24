local wezterm = require("wezterm")

local m = {}

-- https://github.com/wez/wezterm/discussions/4728
m.is_darwin = wezterm.target_triple:find("darwin") ~= nil
m.is_linux = wezterm.target_triple:find("linux") ~= nil
m.is_windows = wezterm.target_triple:find("windows") ~= nil

local function get_current_ui_mode()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return "Dark"
end

m.current_ui_mode = get_current_ui_mode()

m.ui = {
  is_dark = m.current_ui_mode:find("Dark"),
  is_light = not m.current_ui_mode:find("Dark"),
}

return m
