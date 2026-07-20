local wezterm = require("wezterm")

local m = {}

m.toggle_alternate_screen = function(pane)
  if pane:is_alt_screen_active() then
    pane:inject_output('\x1b[?47l')
  else
    pane:inject_output('\x1b[?47h')
  end
end

m.pre_peek_callback = wezterm.action_callback(function(window, pane)
  pane:inject_output('\x1b[?25l') -- Hide the cursor
  m.toggle_alternate_screen(pane)

  window:perform_action(wezterm.action.ActivateKeyTable {
    name = 'peek_mode',
    one_shot = true,
  }, pane)
end)

m.post_peek_callback = wezterm.action_callback(function(_, pane)
  pane:inject_output('\x1b[?25h') -- Show the cursor

  m.toggle_alternate_screen(pane)
end)

m.peek_map = {}

local function bind(keys_list, mods_list)
  for _, key in ipairs(keys_list) do
    for _, modifier in ipairs(mods_list) do
      local entry = {
        key = key,
        action = m.post_peek_callback
      }

      if modifier ~= '' then entry.mods = modifier end
      table.insert(m.peek_map, entry)
    end
  end
end

local letters = {}
for c in ('abcdefghijklmnopqrstuvwxyz'):gmatch('.') do
  table.insert(letters, c)
end

local arrows = { 'UpArrow', 'DownArrow', 'LeftArrow', 'RightArrow' }

local symbols = {
  'Enter', 'Escape', 'Backspace', 'Delete', 'Tab', 'Space',
  'Home', 'End', 'PageUp', 'PageDown', 'Insert',
  'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'F10', 'F11', 'F12',
}
for c in ([=[0123456789`~!@#$%^&*()-_=+[{]}\|;:'",<./>?]=]):gmatch('.') do
  table.insert(symbols, c)
end

bind(letters, { '', 'SHIFT', 'CMD', 'CMD|SHIFT', 'CTRL', 'CTRL|SHIFT', 'ALT', 'ALT|SHIFT' })
bind(arrows, { '', 'CMD', 'CMD|SHIFT', 'CTRL', 'CTRL|SHIFT', 'ALT', 'ALT|SHIFT' })
bind(symbols, { '' })

return m
