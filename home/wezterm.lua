local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.font_size = 16.0
config.adjust_window_size_when_changing_font_size = false
config.line_height = 1.1

-- Appearance
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_background_opacity = 0.90
config.window_padding = {
	left = 12,
	right = 12,
	top = 10,
	bottom = 8,
}

-- Color schemes
config.color_schemes = {
	-- Everforest Dark (default)
	["Everforest"] = {
		foreground = "#D3C6AA",
		background = "#272E33",
		cursor_bg = "#A7C080",
		cursor_border = "#A7C080",
		cursor_fg = "#272E33",
		selection_bg = "#3D484D",
		selection_fg = "#D3C6AA",

		ansi = {
			"#374145",
			"#E67E80",
			"#A7C080",
			"#DBBC7F",
			"#7FBBB3",
			"#D699B6",
			"#83C092",
			"#D3C6AA",
		},

		brights = {
			"#4F585E",
			"#E67E80",
			"#A7C080",
			"#DBBC7F",
			"#7FBBB3",
			"#D699B6",
			"#83C092",
			"#E4DCC8",
		},
	},

	-- Catppuccin Mocha
	["Catppuccin Mocha"] = {
		foreground = "#CDD6F4",
		background = "#1E1E2E",
		cursor_bg = "#F5E0DC",
		cursor_border = "#F5E0DC",
		cursor_fg = "#1E1E2E",
		selection_bg = "#45475A",
		selection_fg = "#CDD6F4",

		ansi = {
			"#45475A",
			"#F38BA8",
			"#A6E3A1",
			"#F9E2AF",
			"#89B4FA",
			"#F5C2E7",
			"#94E2D5",
			"#BAC2DE",
		},

		brights = {
			"#585B70",
			"#F38BA8",
			"#A6E3A1",
			"#F9E2AF",
			"#89B4FA",
			"#F5C2E7",
			"#94E2D5",
			"#A6ADC8",
		},
	},

	-- TokyoNight
	["TokyoNight"] = {
		foreground = "#C0CAF5",
		background = "#1A1B26",
		cursor_bg = "#C0CAF5",
		cursor_border = "#C0CAF5",
		cursor_fg = "#1A1B26",
		selection_bg = "#283457",
		selection_fg = "#C0CAF5",

		ansi = {
			"#15161E",
			"#F7768E",
			"#9ECE6A",
			"#E0AF68",
			"#7AA2F7",
			"#BB9AF7",
			"#7DCFFF",
			"#A9B1D6",
		},

		brights = {
			"#414868",
			"#F7768E",
			"#9ECE6A",
			"#E0AF68",
			"#7AA2F7",
			"#BB9AF7",
			"#7DCFFF",
			"#C0CAF5",
		},
	},
}

-- Default theme
config.color_scheme = "Everforest"

-- Keyboard shortcuts
config.keys = {
	{
		key = "q",
		mods = "CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "'",
		mods = "CTRL",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},

	-- Open color scheme picker
	{
		key = "p",
		mods = "CTRL|SHIFT",
		action = wezterm.action.InputSelector({
			title = "Color Scheme",
			choices = {
				{ label = "Everforest (default)", id = "Everforest" },
				{ label = "Catppuccin Mocha", id = "Catppuccin Mocha" },
				{ label = "TokyoNight", id = "TokyoNight" },
			},
			action = wezterm.action_callback(function(window, pane, id)
				if id then
					window:set_config_overrides({
						color_scheme = id,
					})
				end
			end),
		}),
	},
}

-- Ctrl-click to open links (WezTerm's default behavior)

return config
