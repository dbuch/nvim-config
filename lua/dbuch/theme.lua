local set_hl = vim.api.nvim_set_hl

---@param def table<string,any>
local function hi(def)
  for name, v in pairs(def) do
    set_hl(0, name, v)
  end
end

local gray = {
  [0] = '#0d1117',
  [1] = '#161b22',
  [2] = '#21262d',
  [3] = '#30363d',
  [4] = '#484f58',
  [5] = '#6e7681',
  [6] = '#8b949e',
  [7] = '#b1bac4',
  [8] = '#c9d1d9',
  [9] = '#f0f6fc',
}

local blue = {
  [0] = '#051d4d',
  [1] = '#0c2d6b',
  [2] = '#0d419d',
  [3] = '#1158c7',
  [4] = '#1f6feb',
  [5] = '#388bfd',
  [6] = '#58a6ff',
  [7] = '#79c0ff',
  [8] = '#a5d6ff',
  [9] = '#cae8ff',
}

local green = {
  [0] = '#04260f',
  [1] = '#033a16',
  [2] = '#0f5323',
  [3] = '#196c2e',
  [4] = '#238636',
  [5] = '#2ea043',
  [6] = '#3fb950',
  [7] = '#56d364',
  [8] = '#7ee787',
  [9] = '#aff5b4',
}

local yellow = {
  [0] = '#341a00',
  [1] = '#4b2900',
  [2] = '#693e00',
  [3] = '#845306',
  [4] = '#9e6a03',
  [5] = '#bb8009',
  [6] = '#d29922',
  [7] = '#e3b341',
  [8] = '#f2cc60',
  [9] = '#f8e3a1',
}

local orange = {
  [0] = '#3d1300',
  [1] = '#5a1e02',
  [2] = '#762d0a',
  [3] = '#9b4215',
  [4] = '#bd561d',
  [5] = '#db6d28',
  [6] = '#f0883e',
  [7] = '#ffa657',
  [8] = '#ffc680',
  [9] = '#ffdfb6',
}

local red = {
  [0] = '#490202',
  [1] = '#67060c',
  [2] = '#8e1519',
  [3] = '#b62324',
  [4] = '#da3633',
  [5] = '#f85149',
  [6] = '#ff7b72',
  [7] = '#ffa198',
  [8] = '#ffc1ba',
  [9] = '#ffdcd7',
}

local purple = {
  [0] = '#271052',
  [1] = '#3c1e70',
  [2] = '#553098',
  [3] = '#6e40c9',
  [4] = '#8957e5',
  [5] = '#a371f7',
  [6] = '#bc8cff',
  [7] = '#d2a8ff',
  [8] = '#e2c5ff',
  [9] = '#eddeff',
}

local white = gray[9]
local selection_bg = '#29384B'

vim.cmd 'highlight clear'
vim.cmd 'syntax reset'

vim.g.colors_name = 'github_dark'

-- stylua: ignore
hi {
  StorageClass = { fg = red[6] },
  LineNr       = { fg = gray[5] },
  SignColumn   = { fg = gray[5] },
  FoldColumn   = { fg = gray[3] },
  CursorLineNr = { bg = gray[1] },
  Visual       = { bg = selection_bg },
  Cursor       = { fg = white },
  Normal       = { fg = gray[8], bg = gray[0] },
  NormalFloat  = { fg = gray[8], bg = gray[1] },
  FloatBorder  = { fg = gray[4], bg = gray[1] },
}

-- stylua: ignore
hi {
  CursorLine   = { bg = gray[1] },
  Todo         = { fg = yellow[6] },
  Directory    = { fg = purple[7] },
  Preproc      = { fg = purple[7] },
  StatusLine   = { fg = gray[8], bg = gray[2] },
  StatusLineNC = { fg = gray[4], bg = gray[1] },
  Folded       = { fg = gray[6], bg = gray[1] },
  PMenu        = { fg = gray[8], bg = gray[1] },
  PMenuSel     = { fg = gray[8], bg = gray[3] },
  NonText      = { fg = gray[3] },
  Search       = { fg = white, bg = yellow[0] },
  IncSearch    = { fg = white, bg = yellow[0] },
  CurSearch    = { fg = white, bg = yellow[4] },
  VertSplit    = { fg = gray[3] },
  ErrorMsg     = { fg = red[6] },
  WarningMsg   = { fg = yellow[6] },
  MoreMsg      = { fg = green[6] },
  Question     = { fg = green[6] },
  SpecialKey   = { fg = gray[6] },
  SpellBad     = { undercurl = true, sp = red[3] },
  TabLine      = { bg = gray[2] },
  TabLineFill  = { fg = gray[6], bg = gray[1] },
  TabLineSel   = { bg = gray[3], bold = true },
}

-- stylua: ignore
hi {
  DiffAdd     = { bg = green[0] },
  DiffDelete  = { bg = red[0] },
  DiffChange  = { bg = purple[0] },
  DiffText    = { bg = purple[1] },
  diffAdded   = { bg = green[0] },
  diffRemoved = { bg = red[0] },
}

-- nvim-cmp
-- stylua: ignore
hi {
  CmpItemAbbr      = { fg = gray[5] },
  CmpItemAbbrMatch = { fg = gray[8] },
  CmpItemMenu      = { fg = purple[6] },
  CmpItemKind      = { fg = blue[7] },
}

-- stylua: ignore
hi {
  GitSignsAdd    = { fg = green[4] },
  GitSignsChange = { fg = purple[3] },
  GitSignsDelete = { fg = red[4] },

  GitSignsAddInline    = { bg = green[2] },
  GitSignsChangeInline = { bg = purple[2] },
  GitSignsDeleteInline = { bg = red[2] },

  GitSignsAddLnInline    = { bg = green[1] },
  GitSignsChangeLnInline = { bg = purple[1] },
  GitSignsDeleteLnInline = { bg = red[1] },

  GitSignsAddLn    = { bg = green[0] },
  GitSignsChangeLn = { bg = purple[0] },
  GitSignsDeleteLn = { bg = red[0] },

  GitSignsAddSec    = { fg = green[1] },
  GitSignsChangeSec = { fg = purple[3] },
  GitSignsDeleteSec = { fg = red[1] },

  GitSignsVirtLnum = { bg = red[0], fg = red[2] },
}

-- stylua: ignore
hi {
  Operator    = { fg = red[7] },
  Keyword     = { fg = red[6] },
  Statement   = { fg = red[6] },
  Conditional = { fg = red[6] },
  Comment     = { fg = gray[4], italic = true },
  Function    = { fg = purple[7] },
  Structure   = { fg = blue[8] },
  String      = { fg = blue[8] },
  Constant    = { fg = blue[7] },
  Special     = { fg = blue[7] },
  Delimiter   = { fg = red[7] },
  Identifier  = { fg = blue[9] },
  Typedef     = { fg = green[8] },
  Type        = { fg = green[8] },
  Title       = { fg = purple[6] },
}

-- stylua: ignore
hi {
  TSVariable = { fg = gray[8] },
  TSAnnotation         = { link = 'PreProc' },
  TSAttribute          = { link = 'PreProc' },
  TSBoolean            = { link = 'Boolean' },
  TSCharacter          = { link = 'Character' },
  TSComment            = { link = 'Comment' },
  TSConditional        = { link = 'Conditional' },
  TSConstBuiltin       = { link = 'Special' },
  TSConstMacro         = { link = 'Define' },
  TSConstant           = { link = 'Constant' },
  TSConstructor        = { link = 'Special' },
  TSDanger             = { link = 'WarningMsg' },
  TSEnvironment        = { link = 'Macro' },
  TSEnvironmentName    = { link = 'Type' },
  TSException          = { link = 'Exception' },
  TSField              = { link = 'Identifier' },
  TSFloat              = { link = 'Float' },
  TSFuncBuiltin        = { link = 'Special' },
  TSFuncMacro          = { link = 'Macro' },
  TSFunction           = { link = 'Function' },
  TSInclude            = { link = 'Include' },
  TSKeyword            = { link = 'Keyword' },
  TSKeywordFunction    = { link = 'Keyword' },
  TSKeywordOperator    = { link = 'Operator' },
  TSKeywordReturn      = { link = 'Keyword' },
  TSLabel              = { link = 'Label' },
  TSLiteral            = { link = 'String' },
  TSMath               = { link = 'Special' },
  TSMethod             = { link = 'Function' },
  TSNamespace          = { link = 'Include' },
  TSNote               = { link = 'SpecialComment' },
  TSNumber             = { link = 'Number' },
  TSOperator           = { link = 'Operator' },
  TSParameter          = { link = 'Identifier' },
  TSParameterReference = { fg = orange[7] },
  TSPlaygroundFocus    = { link = 'Visual' },
  TSPlaygroundLang     = { link = 'String' },
  TSProperty           = { link = 'Identifier' },
  TSPunctBracket       = { link = 'Delimiter' },
  TSPunctDelimiter     = { link = 'Delimiter' },
  TSPunctSpecial       = { link = 'Delimiter' },
  TSQueryLinterError   = { link = 'Error' },
  TSRepeat             = { link = 'Repeat' },
  TSString             = { link = 'String' },
  TSStringEscape       = { link = 'SpecialChar' },
  TSStringRegex        = { link = 'String' },
  TSStringSpecial      = { link = 'SpecialChar' },
  TSSymbol             = { link = 'Identifier' },
  TSTag                = { link = 'Label' },
  TSTagAttribute       = { link = 'Identifier' },
  TSTagDelimiter       = { link = 'Delimiter' },
  TSText               = { link = 'TSNone' },
  TSTextReference      = { link = 'Constant' },
  TSTitle              = { link = 'Title' },
  TSType               = { link = 'Type' },
  TSTypeBuiltin        = { link = 'Type' },
  TSURI                = { link = 'Underlined' },
  TSVariableBuiltin    = { link = 'Special' },
  TSWarning            = { link = 'Todo' },
}

-- Semtantic tokens
-- stylua: ignore
hi {
  LspDefaultLibrary = { italic = true },
  LspDeprecated     = { bg = orange[0] },
  LspMacro          = { bg = gray[1], bold = true },
  LspModification   = { bg = red[0] },
  LspParameter      = { italic = true },
  LspReadonly       = { bg = blue[0] },
  LspStatic         = { underdotted = true, sp = yellow[2] },
}

-- hi {
--   ['@defaultLibrary'] = { italic = true },
--   ['@deprecated'] = { bg = orange[0] },
--   ['@macro'] = { bg = gray[1], bold = true },
--   ['@modification'] = { bg = red[0] },
--   ['@parameter'] = { italic = true },
--   ['@readonly'] = { bg = blue[0] },
--   ['@static'] = { underdotted = true, sp = yellow[2] },
-- }

-- stylua: ignore
for kind, colors in pairs {
  Error = { fg = red[5], bg = red[0] },
  Warn  = { fg = yellow[5], bg = yellow[0] },
  Hint  = { fg = gray[5], bg = gray[1] },
  Info  = { fg = gray[7], bg = gray[2] },
} do
  -- stylua: ignore
  hi {
    ['Diagnostic' .. kind]            = { fg = colors.fg },
    ['DiagnosticVirtualText' .. kind] = { fg = colors.fg, bg = colors.bg },
    ['DiagnosticUnderline' .. kind]   = { sp = colors.fg, undercurl = true },
  }
end
