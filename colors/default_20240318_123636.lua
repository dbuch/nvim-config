-- Made with 'mini.colors' module of https://github.com/echasnovski/mini.nvim

if vim.g.colors_name ~= nil then vim.cmd('highlight clear') end
vim.g.colors_name = "default"

-- Highlight groups
local hi = vim.api.nvim_set_hl

hi(0, "@lsp.type.macro", { link = "@constant.macro" })
hi(0, "CmpItemAbbrDeprecatedDefault", { fg = "#9b9ea4" })
hi(0, "CmpItemKindClassDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindColorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstantDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindConstructorDefault", { link = "CmpItemKind" })
hi(0, "CmpItemKindDefault", { fg = "#8cf8f7" })
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
hi(0, "DiagnosticErrorStatus", { bg = "#c4c6cd", fg = "#ffc0b9" })
hi(0, "DiagnosticHintStatus", { bg = "#c4c6cd", fg = "#a6dbff" })
hi(0, "DiagnosticInfoStatus", { bg = "#c4c6cd", fg = "#8cf8f7" })
hi(0, "DiagnosticWarnStatus", { bg = "#c4c6cd", fg = "#fce094" })
hi(0, "GitSignsStagedAdd", { fg = "#597b60" })
hi(0, "GitSignsStagedAddLn", { bg = "#005523", fg = "#77787c" })
hi(0, "GitSignsStagedAddNr", { fg = "#597b60" })
hi(0, "GitSignsStagedChange", { fg = "#467c7b" })
hi(0, "GitSignsStagedChangeLn", { bg = "#4f5258", fg = "#77787c" })
hi(0, "GitSignsStagedChangeNr", { fg = "#467c7b" })
hi(0, "GitSignsStagedChangedelete", { fg = "#467c7b" })
hi(0, "GitSignsStagedChangedeleteLn", { bg = "#4f5258", fg = "#77787c" })
hi(0, "GitSignsStagedChangedeleteNr", { fg = "#467c7b" })
hi(0, "GitSignsStagedDelete", { fg = "#7f605c" })
hi(0, "GitSignsStagedDeleteNr", { fg = "#7f605c" })
hi(0, "GitSignsStagedTopdelete", { fg = "#7f605c" })
hi(0, "GitSignsStagedTopdeleteNr", { fg = "#7f605c" })
hi(0, "LspName", { bg = "#c4c6cd" })
hi(0, "MiniCursorword", { underline = true })
hi(0, "StatusTS", { bg = "#c4c6cd", fg = "#8cf8f7" })

-- No terminal colors defined