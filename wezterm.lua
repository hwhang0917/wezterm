-- This is needed for Wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

if os.getenv("OS") == "Windows_NT" then
    config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }
    -- config.default_prog = { "wsl", "--cd", "~" }
else
    config.default_prog = { "/usr/bin/zsh" }
end

config.color_scheme = "Catppuccin Mocha (Gogh)"

config.font = wezterm.font_with_fallback {
    { family = "FiraCode Nerd Font", weight = "DemiBold" },
    "D2Coding ligature",
    "Segoe UI Emoji",
}
config.font_size = 12
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.9

return config
