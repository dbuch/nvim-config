local gl = require('galaxyline')
local gls = gl.section
local lsp_msg = require('lsp-status/messaging')

local log = require('telescope.log')
log.use_file = false
log.level = 'debug'

local config = {
  indicator_errors = ' ',
  indicator_warnings = ' ',
  indicator_info = '🛈 ',
  indicator_hint = '❗',
  indicator_ok = ' ',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
}

local left = gls.left;
local right = gls.right;

-- Colors
local colors = {
  bg =         '#282a36',
  fg =         '#f8f8f2',
  section_bg = '#38393f',
  yellow =     '#f1fa8c',
  cyan =       '#8be9fd',
  green =      '#98c379',
  orange =     '#ffb86c',
  magenta =    '#ff79c6',
  blue =       '#8be9fd',
  red =        '#ff5555'
}

local mode_color = function(mode)
  local mode_colors = {
    n = colors.green,
    i = colors.blue,
    c = colors.green,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red,
  }
  return mode_colors[mode]
end

local function get_lsp_spinner()
  local messages = lsp_msg.messages()
  for _, msg in ipairs(messages) do
    if msg.spinner then
      return config.spinner_frames[(msg.spinner % #config.spinner_frames) + 1]
    end
  end
  return config.indicator_ok
end

local function parse_lsp_messages()
  local msgs = {}
  local buf_messages = lsp_msg.messages()
  for _, msg in ipairs(buf_messages) do
    local contents = ''
    if msg.progress then
      contents = msg.title
      if msg.message then
        contents = contents .. ' ' .. msg.message
      end

      if msg.percentage then
        contents = contents .. ' (' .. msg.percentage .. ')'
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

local function is_buffer_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

local function has_width_gt(cols)
  -- Check if the windows width is greater than a given number of columns
  return vim.fn.winwidth(0) / 2 > cols
end

-- Local helper functions
local buffer_not_empty = function()
  return not is_buffer_empty()
end

local checkwidth = function()
  return has_width_gt(40) and buffer_not_empty()
end

local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return " "
    else
        return nil
    end
end

-- Left side
table.insert(left, {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMAND',
        V = 'V-LINE',
        [''] = 'V-BLOCK',
        v = 'VISUAL',
        R = 'REPACE',
      }
      local mode = vim.fn.mode()
      vim.api.nvim_command('hi GalaxyViMode gui=bold guifg='..mode_color(mode))
      return '  '..alias[mode].. '  '
    end,
    highlight = { colors.section_bg, colors.section_bg },
    separator_highlight = {colors.section_fg, colors.section_fg},
  },
})

table.insert(left, {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.section_bg },
    separator_highlight = {colors.section_fg, colors.section_bg},
  },
})

table.insert(left, {
  FileName = {
    provider = { 'FileName' },
    separator = " ",
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator_highlight = {colors.section_bg, colors.bg},
  }
})

table.insert(left, {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.red,colors.bg},
  }
})

table.insert(left, {
  GitBranch = {
    provider = 'GitBranch',
    separator = " ",
    condition = buffer_not_empty,
    highlight = {colors.fg,colors.bg},
    separator_highlight = {colors.bg, colors.section_bg},
  }
})

table.insert(left, {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = { colors.green, colors.bg },
  }
})

table.insert(left, {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = { colors.orange, colors.bg },
  }
})

table.insert(left, {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = { colors.red,colors.bg },
  }
})

table.insert(left, {
  WsIndicator = {
    provider = trailing_whitespace,
    highlight = {colors.red,colors.section_bg}
  }
})

table.insert(left, {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.section_bg}
  }
})

table.insert(left, {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.orange,colors.section_bg},
  }
})

table.insert(left, {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = {colors.fg,colors.section_bg},
  }
})

table.insert(left, {
  LspSpinner = {
    provider = get_lsp_spinner,
    highlight = {colors.red, colors.section_bg},
  }
})

table.insert(left, {
  LspMessages = {
    provider = parse_lsp_messages,
    highlight = {colors.fg, colors.section_bg},
    separator = " ",
    separator_highlight = {colors.section_bg, colors.bg},
  }
})

-- Right side

table.insert(right, {
  LineInfo = {
    provider = 'LineColumn',
    highlight = { colors.fg, colors.section_bg },
    separator = " ",
    separator_highlight = { colors.bg, colors.section_bg },
  },
})

table.insert(right, {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    highlight = { colors.fg, colors.section_bg },
    separator_highlight = { colors.section_bg, colors.section_bg },
  }
})

table.insert(right, {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = { colors.red, colors.section_bg },
    separator_highlight = { colors.bg, colors.section_bg },
  }
})
