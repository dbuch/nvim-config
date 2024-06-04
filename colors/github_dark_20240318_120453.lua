-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "github_dark"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@conditional", { link = "Conditional" })
hi(0, "@define", { link = "Define" })
hi(0, "@include", { link = "Include" })
hi(0, "@lsp.mod.documentation", { link = "SpecialComment" })
hi(0, "@lsp.type.keyword", { link = "Keyword" })
hi(0, "@lsp.type.macro", { bg = "#161b22", bold = true })
hi(0, "@lsp.typemod.defaultLibrary", { italic = true })
hi(0, "@lsp.typemod.deprecated", { bg = "#3d1300" })
hi(0, "@lsp.typemod.modification", { bg = "#490202" })
hi(0, "@lsp.typemod.parameter", { italic = true })
hi(0, "@lsp.typemod.readonly", { bg = "#051d4d" })
hi(0, "@lsp.typemod.static", { sp = "#693e00", underdotted = true })
hi(0, "@lsp.typemod.variable.globalScope", { bg = "#241844" })
hi(0, "@preproc", { link = "PreProc" })
hi(0, "@repeat", { link = "Repeat" })
hi(0, "@storageclass", { link = "StorageClass" })
hi(0, "@type.builtin", { link = "Type" })
hi(0, "@variable", { link = "Identifier" })
hi(0, "CmpItemAbbr", { fg = "#6e7681" })
hi(0, "CmpItemAbbrDefault", { fg = "#c9d1d9" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#484f58" })
hi(0, "CmpItemAbbrMatch", { fg = "#c9d1d9" })
hi(0, "CmpItemAbbrMatchDefault", { fg = "#c9d1d9" })
hi(0, "CmpItemAbbrMatchFuzzyDefault", { fg = "#c9d1d9" })
hi(0, "CmpItemKind", { fg = "#79c0ff" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#79c0ff" })
hi(0, "CmpItemKindEnumDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEnumMemberDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindEventDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFieldDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFileDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFolderDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindFunctionDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindInterfaceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindKeywordDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindMethodDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindModuleDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindOperatorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindPropertyDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindReferenceDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindSnippetDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindStructDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTextDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindTypeParameterDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindUnitDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindValueDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindVariableDefault", { link = "CmpItemKind" })
hi(0, "CmpItemMenu", { fg = "#bc8cff" })
hi(0, "CmpItemMenuDefault", { fg = "#c9d1d9" })
hi(0, "Comment", { fg = "#484f58", italic = true })
hi(0, "Conditional", { fg = "#ff7b72" })
hi(0, "Constant", { fg = "#79c0ff" })
hi(0, "CurSearch", { bg = "#9e6a03", fg = "#f0f6fc" })
hi(0, "Cursor", { fg = "#f0f6fc" })
hi(0, "CursorLine", { bg = "#161b22" })
hi(0, "CursorLineNr", { bg = "#161b22" })
hi(0, "Delimiter", { fg = "#ffa198" })
hi(0, "DiagnosticError", { fg = "#f85149" })
hi(0, "DiagnosticErrorStatus", { bg = "#21262d", fg = "#f85149" })
hi(0, "DiagnosticHint", { fg = "#6e7681" })
hi(0, "DiagnosticHintStatus", { bg = "#21262d", fg = "#6e7681" })
hi(0, "DiagnosticInfo", { fg = "#b1bac4" })
hi(0, "DiagnosticInfoStatus", { bg = "#21262d", fg = "#b1bac4" })
hi(0, "DiagnosticUnderlineError", { sp = "#f85149", undercurl = true })
hi(0, "DiagnosticUnderlineHint", { sp = "#6e7681", undercurl = true })
hi(0, "DiagnosticUnderlineInfo", { sp = "#b1bac4", undercurl = true })
hi(0, "DiagnosticUnderlineWarn", { sp = "#bb8009", undercurl = true })
hi(0, "DiagnosticVirtualTextError", { bg = "#490202", fg = "#f85149" })
hi(0, "DiagnosticVirtualTextHint", { bg = "#161b22", fg = "#6e7681" })
hi(0, "DiagnosticVirtualTextInfo", { bg = "#21262d", fg = "#b1bac4" })
hi(0, "DiagnosticVirtualTextWarn", { bg = "#341a00", fg = "#bb8009" })
hi(0, "DiagnosticWarn", { fg = "#bb8009" })
hi(0, "DiagnosticWarnStatus", { bg = "#21262d", fg = "#bb8009" })
hi(0, "DiffAdd", { bg = "#081c13" })
hi(0, "DiffChange", { bg = "#1a1034" })
hi(0, "DiffDelete", { bg = "#2b0a0c" })
hi(0, "DiffText", { bg = "#241844" })
hi(0, "Directory", { fg = "#d2a8ff" })
hi(0, "DressingSelectIdx", { link = "Special" })
hi(0, "ErrorMsg", { fg = "#ff7b72" })
hi(0, "FloatBorder", { bg = "#161b22", fg = "#484f58" })
hi(0, "FoldColumn", { fg = "#30363d" })
hi(0, "Folded", { bg = "#161b22", fg = "#8b949e" })
hi(0, "Function", { fg = "#d2a8ff" })
hi(0, "GitGutterAdd", { link = "GitSignsAdd" })
hi(0, "GitGutterChange", { link = "GitSignsChange" })
hi(0, "GitGutterChangeDelete", { link = "GitSignsChange" })
hi(0, "GitGutterDelete", { link = "GitSignsDelete" })
hi(0, "GitSignsAdd", { fg = "#238636" })
hi(0, "GitSignsAddInline", { bg = "#033a16" })
hi(0, "GitSignsAddLn", { bg = "#04260f" })
hi(0, "GitSignsAddLnInline", { bg = "#062211" })
hi(0, "GitSignsAddSec", { fg = "#033a16" })
hi(0, "GitSignsChange", { fg = "#6e40c9" })
hi(0, "GitSignsChangeInline", { bg = "#3c1e70" })
hi(0, "GitSignsChangeLn", { bg = "#271052" })
hi(0, "GitSignsChangeLnInline", { bg = "#221046" })
hi(0, "GitSignsChangeSec", { fg = "#6e40c9" })
hi(0, "GitSignsDelete", { fg = "#da3633" })
hi(0, "GitSignsDeleteInline", { bg = "#67060c" })
hi(0, "GitSignsDeleteLn", { bg = "#490202" })
hi(0, "GitSignsDeleteLnInline", { bg = "#3d0506" })
hi(0, "GitSignsDeleteSec", { fg = "#67060c" })
hi(0, "GitSignsVirtLnum", { bg = "#490202", fg = "#8e1519" })
hi(0, "Identifier", { fg = "#cae8ff" })
hi(0, "IncSearch", { bg = "#341a00", fg = "#f0f6fc" })
hi(0, "Keyword", { fg = "#ff7b72" })
hi(0, "LineNr", { fg = "#6e7681" })
hi(0, "LspInlayHint", { bg = "#161b22", fg = "#6e7681", italic = true })
hi(0, "LspName", { bg = "#21262d" })
hi(0, "LspReferenceRead", { bg = "#0c1f41" })
hi(0, "LspReferenceText", { bg = "#161b22" })
hi(0, "LspReferenceWrite", { bg = "#36102a" })
hi(0, "MatchParen", { bg = "#21262d", bold = true })
hi(0, "MoreMsg", { fg = "#3fb950" })
hi(0, "NonText", { fg = "#30363d" })
hi(0, "Normal", { bg = "#0d1117", fg = "#c9d1d9" })
hi(0, "NormalFloat", { bg = "#161b22", fg = "#c9d1d9" })
hi(0, "Operator", { fg = "#ffa198" })
hi(0, "Pmenu", { bg = "#161b22", fg = "#c9d1d9" })
hi(0, "PmenuSel", { bg = "#30363d", fg = "#c9d1d9" })
hi(0, "PreProc", { fg = "#d2a8ff" })
hi(0, "Question", { fg = "#3fb950" })
hi(0, "Search", { bg = "#341a00", fg = "#f0f6fc" })
hi(0, "SignColumn", { fg = "#6e7681" })
hi(0, "Special", { fg = "#79c0ff" })
hi(0, "SpecialKey", { fg = "#8b949e" })
hi(0, "SpellBad", { sp = "#5e103e", undercurl = true })
hi(0, "Statement", { fg = "#ff7b72" })
hi(0, "Status6d8086", { bg = "#21262d", fg = "#6d8086" })
hi(0, "StatusLine", { bg = "#21262d", fg = "#c9d1d9" })
hi(0, "StatusLineNC", { bg = "#161b22", fg = "#484f58" })
hi(0, "StatusTS", { bg = "#21262d", fg = "#3fb950" })
hi(0, "StorageClass", { fg = "#ff7b72" })
hi(0, "String", { fg = "#a5d6ff" })
hi(0, "Structure", { fg = "#a5d6ff" })
hi(0, "TabLine", { bg = "#21262d" })
hi(0, "TabLineFill", { bg = "#161b22", fg = "#8b949e" })
hi(0, "TabLineSel", { bg = "#30363d", bold = true })
hi(0, "Title", { fg = "#bc8cff" })
hi(0, "Todo", { fg = "#d29922" })
hi(0, "Type", { fg = "#7ee787" })
hi(0, "Typedef", { fg = "#7ee787" })
hi(0, "VertSplit", { fg = "#30363d" })
hi(0, "Visual", { bg = "#29384b" })
hi(0, "WarningMsg", { fg = "#d29922" })
hi(0, "WinSeparator", { fg = "#30363d" })
hi(0, "diffAdded", { bg = "#04260f" })
hi(0, "diffRemoved", { bg = "#490202" })
hi(0, "lCursor", { bg = "#c9d1d9", fg = "#0d1117" })

-- No terminal colors defined