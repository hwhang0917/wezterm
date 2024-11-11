-- This is needed for Wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local action = wezterm.action

config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "-i", "-l" }

config.color_scheme = "Catppuccin Mocha (Gogh)"

config.font = wezterm.font_with_fallback {
    { family = "FiraCode Nerd Font", weight = "DemiBold" },
    "D2Coding ligature",
    "Segoe UI Emoji",
}
config.font_size = 16
config.window_decorations = "RESIZE"

config.window_background_opacity = 0.8

wezterm.on("update-right-status", function(window, pane)
    local date = wezterm.strftime "%F %p %H:%M:%S "

    local bat = ""
    for _, b in ipairs(wezterm.battery_info()) do
        bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
    end

    window:set_right_status(wezterm.format {
        { Text = bat .. "   " .. date },
    })
end)
wezterm.on("update-status", function(window, pane)
    local name = window:active_key_table()
    if name then
        name = "✨"
    end
    window:set_left_status(name or "")
end)

-- Keybindings
config.keys = {
    {
        key = "a",
        mods = "CTRL",
        action = action.ActivateKeyTable {
            name = "prefix_actions",
            one_shot = false,
            timeout_milliseconds = 500,
        },
    },
}

config.key_tables = {
    prefix_actions = {
        { key = "-", action = action.SplitVertical { domain = "CurrentPaneDomain" }},
        { key = "_", mods="SHIFT", action = action.SplitHorizontal { domain = "CurrentPaneDomain" }},
        { key = "h", mods="SHIFT", action = action.AdjustPaneSize { "Left", 2 } },
        { key = "l", mods="SHIFT", action = action.AdjustPaneSize { "Right", 2 } },
        { key = "k", mods="SHIFT", action = action.AdjustPaneSize { "Up", 2 } },
        { key = "j", mods="SHIFT", action = action.AdjustPaneSize { "Down", 2 } },
        { key = "h", action = action.ActivatePaneDirection "Left" },
        { key = "l", action = action.ActivatePaneDirection "Right" },
        { key = "k", action = action.ActivatePaneDirection "Up" },
        { key = "j", action = action.ActivatePaneDirection "Down" },
        { key = "z", action = action.TogglePaneZoomState },

        -- Cancel the mode by pressing escape
        { key = "Escape", action = "PopKeyTable" },
        { key = "a", mods="CTRL", action = "PopKeyTable" },
    },
}

return config
