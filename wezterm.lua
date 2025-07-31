-- This is needed for Wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

if os.getenv("OS") == "Windows_NT" then
	config.default_prog = { "wsl", "--cd", "~" }
else
	config.default_prog = { "/usr/bin/zsh" }
end

config.front_end = "WebGpu"

config.color_scheme = "Catppuccin Mocha (Gogh)"
config.font = wezterm.font_with_fallback({
	-- { family = "FiraCode Nerd Font Ret" },
	{ family = "Terminess Nerd Font Mono" },
	"D2Coding ligature",
	"Segoe UI Emoji",
})
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }
config.font_size = 14
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9

config.keys = {
	{
		key = "o",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local overrides = window:get_config_overrides() or {}
			if overrides.window_background_opacity == 1.0 then
				overrides.window_background_opacity = 0.9
			else
				overrides.window_background_opacity = 1.0
			end
			window:set_config_overrides(overrides)
		end),
	},
	{
		key = "i",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SpawnCommandInNewTab({
			args = { os.getenv("PROGRAMFILES") .. "\\Git\\bin\\bash.exe" },
		}),
	},
}

return config
