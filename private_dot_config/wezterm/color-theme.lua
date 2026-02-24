local wezterm = require("wezterm")
local utils = require("custom-utils")

---
--- Import this in the overrides file to use "rose-pine" themes
---

local extract_tab_bar_colors_from_theme = function(theme_name)
  local wez_theme = wezterm.color.get_builtin_schemes()[theme_name]

  return {
    window_frame_colors = {
      active_titlebar_bg = wez_theme.background,
      inactive_titlebar_bg = wezterm.color.parse(wez_theme.background):darken(0.8),
    },
    tab_bar_colors = {
      background = wezterm.color.parse(wez_theme.background):darken(0.05),
      -- background = wez_theme.background,
      inactive_tab_edge = wezterm.color.parse(wez_theme.background):darken(0.8),
      active_tab = {
        bg_color = wez_theme.brights[3],
        fg_color = wez_theme.background,
      },
      inactive_tab = {
        bg_color = wez_theme.background,
        fg_color = wez_theme.foreground,
      },
      inactive_tab_hover = {
        bg_color = wezterm.color.parse(wez_theme.background):lighten(0.1),
        fg_color = wezterm.color.parse(wez_theme.foreground):lighten(0.2),
      },
      new_tab = {
        bg_color = wez_theme.background,
        fg_color = wez_theme.foreground,
      },
      new_tab_hover = {
        bg_color = wez_theme.brights[3],
        fg_color = wez_theme.background,
      },
    },
  }
end

return function(config)
  local currentScheme = utils.ui.is_dark and "rose-pine-moon" or "rose-pine-dawn"
  config.color_scheme = currentScheme

  local tab_bar_theme = extract_tab_bar_colors_from_theme(currentScheme)

  config.colors = {
    tab_bar = tab_bar_theme.tab_bar_colors,
  }
end
