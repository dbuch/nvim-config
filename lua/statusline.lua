local M = {}

function M.config()
  local gl = require('galaxyline')
  local condition = require('galaxyline.condition')
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

  local function get_lsp_spinner()
    local messages = lsp_msg.messages()
    for _, msg in ipairs(messages) do
      if msg.spinner then
        return icons.spinner_frames[(msg.spinner % #icons.spinner_frames) + 1]
      end
    end
    return icons.indicator_ok
  end

  local function parse_lsp_messages()
    local msgs = {}
    local buf_messages = lsp_msg.messages()
    for _, msg in ipairs(buf_messages) do
      local contents = ''
      if msg.progress then
        contents = msg.title

        if msg.percentage then
          contents = contents .. ' (' .. msg.percentage .. '%' .. ')'
        end

        if msg.message then
          contents = contents .. ' ' .. msg.message
        end

      elseif msg.status then
        contents = msg.content
        if msg.uri then
          local filename = vim.uri_to_fname(msg.uri)
          filename = vim.fn.fnamemodify(filename, ':~:.')
          local space = math.min(60, math.floor(0.6 * vim.fn.winwidth(0)))
          if #filename > space then
            filename = vim.fn.pathshorten(filename)
          end

          contents = '(' .. filename .. ') ' .. contents
        end
      else
        contents = msg.content
      end

      table.insert(msgs, contents)
    end
    local base_status = table.concat(msgs, ' ')
    if base_status ~= '' then
      return base_status
    end

    return nil
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
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMAND',

          v = 'VISUAL',
          V = 'V-LINE',
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
      highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
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
      highlight = {colors.fg,colors.section_bg},
    }
  })

  insert(left, {
    LspSpinner = {
      provider = get_lsp_spinner,
      highlight = {colors.red, colors.section_bg},
    }
  })

  insert(left, {
    LspMessages = {
      provider = parse_lsp_messages,
      highlight = {colors.fg, colors.section_bg},
      separator = " ",
      separator_highlight = {colors.section_bg, colors.bg},
    }
  })

  -- TODO: fix rooter maybe use another autocmd to update in rooter.lua
  --table.insert(left, {
    --LuaRootIcon = {
      --provider = function() return " " end,
      --condition = rooter.IsRooted,
      --highlight = {colors.red,colors.bg},
    --}
  --})

  --table.insert(left, {
    --LuaRoot = {
      --provider = rooter.GetRoot,
      --condition = rooter.IsRooted,
      --highlight = {colors.fg, colors.section_bg},
      --separator = " ",
      --separator_highlight = {colors.section_bg, colors.bg},
    --}
  --})

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
