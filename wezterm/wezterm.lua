local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'Wez'
config.keys = {
    { key = "!", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(0) },
    { key = '"', mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(1) },
    { key = "£", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(2) },
    { key = "$", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(3) },
    { key = "%", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(4) },
    { key = "^", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(5) },
    { key = "&", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(6) },
    { key = "*", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(7) },
    { key = "(", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTab(8) },
    { key = "Enter", mods="ALT", action = wezterm.action.DisableDefaultAssignment },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Up" } },
    { key = "h", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Left" } },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Down" } },
    { key = "l", mods = "CTRL|SHIFT", action = wezterm.action { ActivatePaneDirection = "Right" } },
    { key = "q", mods = "CTRL|SHIFT", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
    { key = "Y", mods = "CTRL|SHIFT", action = wezterm.action { CopyTo = "ClipboardAndPrimarySelection" } },
    { key = "g", mods = "CTRL|SHIFT", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" })},
    { key = "S", mods = "CTRL|SHIFT", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
    { key = "V", mods = "CTRL|SHIFT", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
    {
        key = 'A',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        wezterm.action.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
}

return config
