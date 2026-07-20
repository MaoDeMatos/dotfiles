-- Drop-in WezTerm config with MinTTY-style "Flip Screen" (peek) feature.
-- Rename to wezterm.lua to use as a standalone config.
--
-- F12: peek at primary screen while a full-screen app (vim, less, etc.) is on the alternate screen.
-- Any keypress while peeking returns to the app. The app is never notified.
--
-- Uses ?47 (raw buffer swap) instead of ?1049 (smcup/rmcup), to avoid clearing the alt buffer.

local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function toggle_alternate_screen(pane)
  if pane:is_alt_screen_active() then
    pane:inject_output('\x1b[?47l')
  else
    pane:inject_output('\x1b[?47h')
  end
end

local post_peek = wezterm.action_callback(function(_, pane)
  pane:inject_output('\x1b[?25h') -- Show the cursor

  toggle_alternate_screen(pane)
end)

local peek_map = {}

local function bind(keys_list, mods_list)
  for _, key in ipairs(keys_list) do
    for _, modifier in ipairs(mods_list) do
      local entry = { key = key, action = post_peek }
      if modifier ~= '' then entry.mods = modifier end
      table.insert(peek_map, entry)
    end
  end
end

local letters = {}
for c in ('abcdefghijklmnopqrstuvwxyz'):gmatch('.') do
  table.insert(letters, c)
end

local arrows = { 'UpArrow', 'DownArrow', 'LeftArrow', 'RightArrow' }

-- Special keys and printable symbols combined; both base and shifted forms listed
-- explicitly to avoid SHIFT+key vs shifted-character ambiguity in WezTerm's key dispatch.
local all_keys = {
  'Enter', 'Escape', 'Backspace', 'Delete', 'Tab', 'Space',
  'Home', 'End', 'PageUp', 'PageDown', 'Insert',
  'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12',
}
for c in ([=[0123456789`~!@#$%^&*()-_=+[{]}\|;:'",<./>?]=]):gmatch('.') do
  table.insert(all_keys, c)
end

bind(letters, { '', 'SHIFT', 'CMD', 'CMD|SHIFT', 'CTRL', 'CTRL|SHIFT', 'ALT', 'ALT|SHIFT' })
bind(arrows, { '', 'CMD', 'CMD|SHIFT', 'CTRL', 'CTRL|SHIFT', 'ALT', 'ALT|SHIFT' })
bind(all_keys, { '' })

config.keys = {
  {
    key = 'F12',
    action = wezterm.action_callback(function(window, pane)
      pane:inject_output('\x1b[?25l') -- Hide the cursor
      toggle_alternate_screen(pane)
      window:perform_action(wezterm.action.ActivateKeyTable {
        name = 'peek_mode',
        one_shot = true,
      }, pane)
    end),
  },
}

config.key_tables = {
  peek_mode = peek_map,
}

return config
