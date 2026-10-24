local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13.0
config.adjust_window_size_when_changing_font_size = false

-- Appearance
config.enable_tab_bar = false
config.window_decorations = "NONE"
config.window_background_opacity = 0.90

-- Custom color palette
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",

	ansi = {
		"#214969",
		"#E52E2E",
		"#44FFB1",
		"#FFE073",
		"#0FC5ED",
		"#A277FF",
		"#24EAF7",
		"#CBE0F0",
	},

	brights = {
		"#416987",
		"#FF5555",
		"#50FA7B",
		"#F1FA8C",
		"#8BE9FD",
		"#BD93F9",
		"#24EAF7",
		"#FFFFFF",
	},
}

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
}

-- Ctrl-click to open a link
config.mouse_bindings = {
	{
		event = {
			Up = {
				streak = 1,
				button = "Left",
			},
		},
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

return config
