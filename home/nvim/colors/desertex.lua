-- desertex.lua
-- Port of Kakoune's built-in colors/desertex.kak
-- Keeps the terminal's default background.

vim.opt.termguicolors = true
vim.g.colors_name = "desertex_kakoune"

local c = {
  salmon = "#fa8072",
  type = "#dfdfbf",
  sky = "#87ceeb",
  keyword = "#eedc82",
  green = "#7ccd7c",
  error = "#c3bf9f",
  pink = "#ee799f",
  menu = "#c2bfa5",
  menu_info = "#445599",
  line = "#605958",
  status = "#ffd75f",
  white = "#ffffff",
  black = "#000000",
  blue = "#0000ff",
  cyan = "#00ffff",
  yellow = "#ffff00",
  red = "#ff0000",
  magenta = "#ff00ff",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(group, target)
  hi(group, { link = target })
end

-- Editor UI: preserve the terminal's background.
hi("Normal", { fg = "NONE", bg = "NONE" })
hi("NormalNC", { fg = "NONE", bg = "NONE" })
hi("EndOfBuffer", { fg = c.blue, bg = "NONE" })
hi("Cursor", { fg = c.black, bg = c.white })
hi("CursorLine", { bg = "NONE" })
hi("LineNr", { fg = c.line, bg = "NONE" })
hi("CursorLineNr", { fg = c.yellow, bg = "NONE", bold = true })
hi("Visual", { fg = c.white, bg = c.blue })
hi("Search", { fg = c.black, bg = c.yellow })
hi("IncSearch", { fg = c.black, bg = c.yellow })
hi("MatchParen", { fg = c.cyan, bg = "NONE", bold = true })
hi("Whitespace", { fg = c.line })
hi("NonText", { fg = c.blue })
hi("VertSplit", { fg = c.line, bg = "NONE" })
hi("WinSeparator", { fg = c.line, bg = "NONE" })

-- Status line and command area.
hi("StatusLine", { fg = c.cyan, bg = "NONE" })
hi("StatusLineNC", { fg = c.cyan, bg = "NONE" })
hi("ModeMsg", { fg = c.status, bg = "NONE" })
hi("MoreMsg", { fg = c.green, bg = "NONE" })
hi("MsgArea", { fg = "NONE", bg = "NONE" })
hi("Question", { fg = c.blue, bg = "NONE" })
hi("ErrorMsg", { fg = c.white, bg = c.red })
hi("WarningMsg", { fg = c.yellow, bg = "NONE" })

-- Completion menu.
hi("Pmenu", { fg = c.pink, bg = c.menu })
hi("PmenuSel", { fg = c.white, bg = c.menu_info })
hi("PmenuSbar", { bg = c.menu })
hi("PmenuThumb", { bg = c.menu_info })
hi("PmenuMatch", { fg = c.keyword, bold = true })
hi("PmenuMatchSel", { fg = c.keyword, bg = c.menu_info, bold = true })

-- Core syntax groups, matching Kakoune's palette.
hi("Comment", { fg = c.green, italic = true })
hi("Constant", { fg = c.salmon })
hi("String", { fg = c.salmon })
hi("Character", { fg = c.salmon })
hi("Number", { fg = c.salmon })
hi("Boolean", { fg = c.salmon })
hi("Float", { fg = c.salmon })
hi("Identifier", { fg = c.sky })
hi("Function", { fg = c.sky })
hi("Statement", { fg = c.keyword })
hi("Keyword", { fg = c.keyword })
hi("Conditional", { fg = c.keyword })
hi("Repeat", { fg = c.keyword })
hi("Label", { fg = c.keyword })
hi("Operator", { fg = c.sky })
hi("PreProc", { fg = c.pink })
hi("Include", { fg = c.pink })
hi("Define", { fg = c.pink })
hi("Macro", { fg = c.pink })
hi("Type", { fg = c.type })
hi("StorageClass", { fg = c.keyword })
hi("Structure", { fg = c.type })
hi("Typedef", { fg = c.type })
hi("Special", { fg = c.sky })
hi("SpecialChar", { fg = c.salmon })
hi("Underlined", { fg = c.cyan, underline = true })
hi("Error", { fg = c.error, bold = true })
hi("Todo", { fg = c.black, bg = c.yellow, bold = true })

-- Diagnostics.
hi("DiagnosticError", { fg = c.salmon })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.sky })
hi("DiagnosticHint", { fg = c.green })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.salmon })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.sky })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.green })

-- Diff.
hi("DiffAdd", { fg = c.green })
hi("DiffChange", { fg = c.keyword })
hi("DiffDelete", { fg = c.salmon })
hi("DiffText", { fg = c.sky, bold = true })

-- Common Tree-sitter groups.
link("@comment", "Comment")
link("@string", "String")
link("@string.escape", "SpecialChar")
link("@constant", "Constant")
link("@constant.builtin", "Constant")
link("@number", "Number")
link("@boolean", "Boolean")
link("@variable", "Identifier")
link("@variable.builtin", "Special")
link("@function", "Function")
link("@function.call", "Function")
link("@method", "Function")
link("@keyword", "Keyword")
link("@keyword.function", "Keyword")
link("@keyword.return", "Keyword")
link("@operator", "Operator")
link("@type", "Type")
link("@type.builtin", "Type")
link("@attribute", "Keyword")
link("@module", "Identifier")
link("@constructor", "Type")
link("@tag", "Type")
link("@tag.attribute", "Identifier")
link("@markup.heading", "Title")
link("@markup.link", "Underlined")
link("@markup.raw", "String")

-- Markup faces used by Vim's built-in syntax.
hi("Title", { fg = c.blue })
hi("Directory", { fg = c.cyan })
hi("Underlined", { fg = c.cyan, underline = true })
hi("Todo", { fg = c.black, bg = c.yellow, bold = true })
