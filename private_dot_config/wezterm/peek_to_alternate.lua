local wezterm = require("wezterm")

local m = {}

-- Flip between primary and alternate screen without disturbing the running app.
-- Uses ?47 (raw buffer swap) instead of ?1049 (which clears the alt buffer).
-- Activates peek_mode key table while peeking so any keypress returns to the app.
--
-- CAVEAT: Does not work reliably with apps that can rerender
-- WHILE you're peeking out of the alternate screen.
-- eg: htop will render on top (and might pollute) your primary buffer
-- (the alternate screen will rerender while you're peeking out)

local function toggle_alternate_screen(pane)
  if pane:is_alt_screen_active() then
    pane:inject_output("\x1b[?47l") -- Hide alt screen
  else
    pane:inject_output("\x1b[?47h") -- Show alt screen
  end
end

m.enable_peek_mode = wezterm.action_callback(function(window, pane)
  pane:inject_output("\x1b[?25l") -- Hide the cursor
  toggle_alternate_screen(pane)

  window:perform_action(
    wezterm.action.ActivateKeyTable({
      name = "peek_mode",
      one_shot = true,
    }),
    pane
  )
end)

m.disable_peek_mode = wezterm.action_callback(function(_, pane)
  pane:inject_output("\x1b[?25h") -- Show the cursor

  toggle_alternate_screen(pane)
end)

m.peek_map = {}

local function bind(keys_list, mods_list)
  for _, key in ipairs(keys_list) do
    for _, modifier in ipairs(mods_list) do
      local entry = {
        key = key,
        action = m.disable_peek_mode,
      }

      if modifier ~= "" then
        entry.mods = modifier
      end
      table.insert(m.peek_map, entry)
    end
  end
end

local letters = {}
for c in ("abcdefghijklmnopqrstuvwxyz"):gmatch(".") do
  table.insert(letters, c)
end

local arrows = { "UpArrow", "DownArrow", "LeftArrow", "RightArrow" }

-- stylua: ignore
local symbols = {
  "Enter", "Escape", "Backspace", "Delete", "Tab", "Space", "Home", "End", "PageUp", "PageDown", "Insert",
  "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
}

for c in ([=[0123456789`~!@#$%^&*()-_=+[{]}\|;:'",<./>?]=]):gmatch(".") do
  table.insert(symbols, c)
end

bind(letters, { "", "SHIFT", "CMD", "CMD|SHIFT", "CTRL", "CTRL|SHIFT", "ALT", "ALT|SHIFT" })
bind(arrows, { "", "CMD", "CMD|SHIFT", "CTRL", "CTRL|SHIFT", "ALT", "ALT|SHIFT" })
bind(symbols, { "" }) --- Bind symbols without generating modifier variants

return m
