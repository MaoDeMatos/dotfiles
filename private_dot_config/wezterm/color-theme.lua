local wezterm = require("wezterm")
local utils = require("custom-utils")

---
--- Import this in the overrides file to use "rose-pine" light and dark themes
---

local extract_colors_from_builtin_scheme = function(scheme_name)
  local wez_theme = wezterm.color.get_builtin_schemes()[scheme_name]

  return {
    window_frame_colors = {
      active_titlebar_bg = wez_theme.background,
      inactive_titlebar_bg = wezterm.color.parse(wez_theme.background):darken(0.8),
    },

    tab_bar_colors = {
      background = "none",
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
        bg_color = "none",
        fg_color = wez_theme.foreground,
      },
      new_tab_hover = {
        bg_color = wez_theme.background,
        fg_color = wez_theme.foreground,
      },
    },
  }
end

return function(config)
  local currentScheme = utils.ui.is_light and "rose-pine-dawn" or "rose-pine"
  config.color_scheme = currentScheme

  local current_colors = extract_colors_from_builtin_scheme(currentScheme)

  config.window_frame = utils.merge_fields(config.window_frame, current_colors.window_frame_colors)
  config.colors = {
    tab_bar = current_colors.tab_bar_colors,
  }
end
