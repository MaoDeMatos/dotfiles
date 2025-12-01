local wezterm = require("wezterm")

local m = {}

-- https://github.com/wez/wezterm/discussions/4728
m.is_darwin = wezterm.target_triple:find("darwin") ~= nil
m.is_linux = wezterm.target_triple:find("linux") ~= nil
m.is_windows = wezterm.target_triple:find("windows") ~= nil

return m
