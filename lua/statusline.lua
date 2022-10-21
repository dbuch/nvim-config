local M = {}

function M.config()
  local gl = require('galaxyline')
  local condition = require('galaxyline.condition')
  local fileinfo = require('galaxyline.provider_fileinfo')
  local lsp_msg = require('lsp-status/messaging')
  local constants = require('constants')

  local colors = constants.colors
  local icons = constants.icons
  local gls = gl.section

  local left = gls.left;
  local right = gls.right;


  local mode_color = function(mode)
    local mode_colors = {
      n = colors.green,
      i = colors.blue,
      c = colors.green,
      t = colors.green,
      V = colors.magenta,
      [''] = colors.magenta,
      v = colors.magenta,
      s = colors.magenta,
      S = colors.magenta,
      ['^S'] = colors.magenta,
      R = colors.red,
    }
    return mode_colors[mode]
  end

  local function trailing_whitespace()
      local trail = vim.fn.search("\\s$", "nw")
      if trail ~= 0 then
          return " "
      else
          return nil
      end
  end

  local position = 0
  local function insert(tbl, entry)
    tbl[position] = entry
    position = position + 1
  end

  -- Left side
  insert(left, {
    ViMode = {
      provider = function()
        local alias = {
          n =      'NORMAL',
          i =      'INSERT',
          c =      'COMAND',
          t =      'TERM  ',
          v =      'VISUAL',
          V =      'V-LINE',
          [''] = 'V-BLOCK',

          R = 'REPACE',

          s = 'S-CHAR',
          S = 'S-LINE',
          ['^S'] = 'S-BLOCK',
        }
        local mode = vim.fn.mode()
        local color = mode_color(mode)

        vim.api.nvim_command('hi GalaxyViMode gui=bold guifg='..color)

        return '  '..alias[mode].. '  '
      end,
      highlight = { colors.section_bg, colors.section_bg },
      separator_highlight = {colors.section_fg, colors.section_fg},
    },
  })

  insert(left, {
    FileIcon = {
      provider = 'FileIcon',
      condition = condition.buffer_not_empty,
      highlight = { fileinfo.get_file_icon_color, colors.section_bg },
      separator_highlight = {colors.section_fg, colors.section_bg},
    },
  })

  insert(left, {
    FileName = {
      provider = { 'FileName' },
      separator = " ",
      condition = condition.buffer_not_empty,
      highlight = { colors.fg, colors.section_bg },
      separator_highlight = {colors.section_bg, colors.bg},
    }
  })

  insert(left, {
    GitIcon = {
      provider = function() return '  ' end,
      condition = condition.check_git_workspace,
      highlight = {colors.red,colors.bg},
    }
  })

  insert(left, {
    GitBranch = {
      provider = 'GitBranch',
      separator = " ",
      condition = condition.check_git_workspace and condition.buffer_not_empty,
      highlight = {colors.fg,colors.bg},
      separator_highlight = {colors.bg, colors.section_bg},
    }
  })

  insert(left, {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.check_git_workspace,
      icon = ' ',
      highlight = { colors.green, colors.section_bg },
    }
  })

  insert(left, {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.check_git_workspace,
      icon = ' ',
      highlight = { colors.orange, colors.section_bg },
    }
  })

  insert(left, {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.check_git_workspace,
      icon = ' ',
      highlight = { colors.red,colors.section_bg },
    }
  })

  insert(left, {
    WsIndicator = {
      provider = trailing_whitespace,
      highlight = {colors.red,colors.section_bg}
    }
  })

  insert(left, {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.red,colors.section_bg}
    }
  })

  insert(left, {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.orange,colors.section_bg},
    }
  })

  insert(left, {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      separator = " ",
      separator_highlight = {colors.section_bg, colors.bg},
      highlight = {colors.fg,colors.section_bg},
    }
  })

  -- Right side

  insert(right, {
    LineInfo = {
      provider = 'LineColumn',
      highlight = { colors.fg, colors.section_bg },
      separator = " ",
      separator_highlight = { colors.bg, colors.section_bg },
    },
  })

  insert(right, {
    PerCent = {
      provider = 'LinePercent',
      separator = ' ',
      highlight = { colors.fg, colors.section_bg },
      separator_highlight = { colors.section_bg, colors.section_bg },
    }
  })

  insert(right, {
    ScrollBar = {
      provider = 'ScrollBar',
      highlight = { colors.red, colors.section_bg },
      separator_highlight = { colors.bg, colors.section_bg },
    }
  })

end

return M
