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

  CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
  CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
  CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
  CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

  CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

  CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

  CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

  CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

  CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
  CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

  CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

  CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

  CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}
