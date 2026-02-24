-- local wezterm = require("wezterm")
-- local utils = require("custom-utils")

return function(config)
  config.automatically_reload_config = true

  --- Enable resizing by cell increments only to avoid gaps around TUIs
  -- config.use_resize_increments = true

  -- config.font_size = 14
  require("color-theme")(config)
end
