# Wezterm setup

## Windows

```ps1
echo 'require("wsl-config")' > $HOME\.wezterm.lua
<!-- Create a SymbolicLink to access the configuration stored in WSL, as I'm using Wezterm only for this -->
New-Item -ItemType SymbolicLink -Path "C:\Users\<WIN-Username>\.config\wezterm" -Target "\\wsl$\Ubuntu\home\<WSL-Username>\.config\wezterm"
```

> [!TIP]
>
> To edit the config from WSL, the path is `/mnt/c/Users/<username>/.config/wezterm`

## Example `local-overrides.lua` file

```lua
local wezterm = require("wezterm")

local config = {}

config.initial_cols = 110
config.initial_rows = 24

config.font_size = 11
config.font = wezterm.font_with_fallback({
	{
		family = "FiraCode",
		-- weight = "Medium",
	},
})

return config
```
