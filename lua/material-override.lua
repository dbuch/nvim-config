COLOR_BG =             '#212121'
COLOR_FG =             '#eeffff'
COLOR_INVISIBLES =     '#65738e'
COLOR_COMMENTS =       '#545454'
COLOR_CARET =          '#ffcc00'
COLOR_SELECTION =      '#2c2c2c'
COLOR_GUIDES =         '#37474f'
COLOR_LINE_NUMBERS =   '#37474f'
COLOR_LINE_HIGHLIGHT = '#171717'
COLOR_WHITE =          '#ffffff'
COLOR_BLACK =          '#000000'
COLOR_ORANGE =         '#f78c6c'
COLOR_RED =            '#ff5370'
COLOR_YELLOW =         '#ffcb6b'
COLOR_GREEN =          '#c3e88d'
COLOR_CYAN =           '#89ddff'
COLOR_BLUE =           '#82aaff'
COLOR_PALEBLUE =       '#b2ccd6'
COLOR_PURPLE =         '#c792ea'
COLOR_BROWN =          '#c17e70'
COLOR_PINK =           '#f07178'
COLOR_VIOLET =         '#bb80b3'

return {
  Normal =      { fg = COLOR_FG, bg = COLOR_BG },
  NormalNC =    { fg = COLOR_FG, bg = COLOR_BG },
  NormalFloat = { fg = COLOR_FG, bg = COLOR_BG },

  -- Comment    = { fg = COLOR_COMMENTS, bg = COLOR_BG, italic = true },
  Comment    = { fg = COLOR_COMMENTS, bg = "NONE", italic = true },
  Conceal    = { fg = COLOR_BROWN,    bg = COLOR_BG },
  Constant   = { fg = COLOR_ORANGE,   bg = COLOR_BG },
  String     = { fg = COLOR_GREEN,    bg = COLOR_BG },
  Character  = { fg = COLOR_GREEN,    bg = COLOR_BG },
  Identifier = { fg = COLOR_RED,      bg = COLOR_BG },
  Function   = { fg = COLOR_BLUE,     bg = COLOR_BG },
  Statement  = { fg = COLOR_PURPLE,   bg = COLOR_BG },
  Operator   = { fg = COLOR_CYAN,     bg = COLOR_BG },
  PreProc    = { fg = COLOR_CYAN,     bg = COLOR_BG },
  Include    = { fg = COLOR_BLUE,     bg = COLOR_BG },
  Define     = { fg = COLOR_PURPLE,   bg = COLOR_BG },
  Macro      = { fg = COLOR_PURPLE,   bg = COLOR_BG },
  Type       = { fg = COLOR_YELLOW,   bg = COLOR_BG },
  Structure  = { fg = COLOR_CYAN,     bg = COLOR_BG },
  Special    = { fg = COLOR_VIOLET,   bg = COLOR_BG,},
  Underlined = { fg = COLOR_BLUE,     bg = COLOR_BG },

  CmpItemAbbrDeprecated = { fg = COLOR_FG, bg = "NONE", bold = true, strikethrough = true },
  CmpItemAbbrMatch = { fg = COLOR_FG, bg = "NONE", bold = true },
  CmpItemAbbrMatchFuzzy = { fg = COLOR_FG, bg = "NONE", bold = true },
  CmpItemMenu = { fg = COLOR_FG, bg = "NONE", italic = true },

  CmpItemKindField = { fg = COLOR_FG, bg = "#B5585F", bold = true },
  CmpItemKindProperty = { fg = COLOR_FG, bg = "#B5585F", bold = true },
  CmpItemKindEvent = { fg = COLOR_FG, bg = "#B5585F", bold = true },

  CmpItemKindText = { fg = COLOR_FG, bg = "#9FBD73", bold = true },
  CmpItemKindEnum = { fg = COLOR_FG, bg = "#9FBD73", bold = true },
  CmpItemKindKeyword = { fg = COLOR_FG, bg = "#9FBD73", bold = true },

  CmpItemKindConstant = { fg = COLOR_FG, bg = "#D4BB6C", bold = true },
  CmpItemKindConstructor = { fg = COLOR_FG, bg = "#D4BB6C", bold = true },
  CmpItemKindReference = { fg = COLOR_FG, bg = "#D4BB6C", bold = true },

  CmpItemKindFunction = { fg = COLOR_FG, bg = "#A377BF", bold = true },
  CmpItemKindStruct = { fg = COLOR_FG, bg = "#A377BF", bold = true },
  CmpItemKindClass = { fg = COLOR_FG, bg = "#A377BF", bold = true },
  CmpItemKindModule = { fg = COLOR_FG, bg = "#A377BF", bold = true },
  CmpItemKindOperator = { fg = COLOR_FG, bg = "#A377BF", bold = true },

  CmpItemKindVariable = { fg = COLOR_FG, bg = "#7E8294", bold = true },
  CmpItemKindFile = { fg = COLOR_FG, bg = "#7E8294", bold = true },

  CmpItemKindUnit = { fg = COLOR_FG, bg = "#D4A959", bold = true },
  CmpItemKindSnippet = { fg = COLOR_FG, bg = "#D4A959", bold = true },
  CmpItemKindFolder = { fg = COLOR_FG, bg = "#D4A959", bold = true },

  CmpItemKindMethod = { fg = COLOR_FG, bg = "#6C8ED4", bold = true },
  CmpItemKindValue = { fg = COLOR_FG, bg = "#6C8ED4", bold = true },
  CmpItemKindEnumMember = { fg = COLOR_FG, bg = "#6C8ED4", bold = true },

  CmpItemKindInterface = { fg = COLOR_FG, bg = "#58B5A8", bold = true },
  CmpItemKindColor = { fg = COLOR_FG, bg = "#58B5A8", bold = true },
  CmpItemKindTypeParameter = { fg = COLOR_FG, bg = "#58B5A8", bold = true },
}
