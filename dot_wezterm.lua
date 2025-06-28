local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.automatically_reload_config = false
config.window_close_confirmation = "NeverPrompt"

config.initial_cols = 128
config.initial_rows = 32

config.enable_tab_bar = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.font_size = 12
config.font = wezterm.font_with_fallback({
	{
		family = "Iosevka Term SS12",
		weight = "Medium",
	},
	{
		family = "FiraCode",
		-- weight = "Medium",
	},
})

config.color_scheme = "rose-pine"

-- Try to load local overrides from ~/.config/wezterm/local-overrides.lua
local ok, local_config = pcall(require, "local-overrides")
if ok and type(local_config) == "table" then
  for k, v in pairs(local_config) do
    config[k] = v
  end
end

return config
