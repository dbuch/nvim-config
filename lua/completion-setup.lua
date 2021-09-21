local M = {}
local lspkind = require('lspkind')


function M.setup()
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  --[[ local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
   local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
  end ]]
  local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
      return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  vim.g.completion_customize_lsp_label = {
    Function      = "",
    Method        = "",
    Variable      = "",
    Constant      = "<U+F8FF>",
    Struct        = "פּ",
    Class         = "",
    Interface     = "禍",
    Text          = "",
    Enum          = "",
    EnumMember    = "",
    Module        = "",
    Color         = "",
    Property      = "襁",
    Field         = "綠",
    Unit          = "",
    File          = "",
    Value         = "",
    Event         = "鬒",
    Folder        = "",
    Keyword       = "",
    Snippet       = "",
    Operator      = "洛",
    Reference     = " ",
    TypeParameter = "",
    Default       = ""
  }

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },

    formatting = {
      format = function(entry, vim_item)
        vim_item.kind = lspkind.presets.default[vim_item.kind]
        return vim_item
      end
    },

    completion = {
      completeopt = 'menu,menuone,noinsert',
    },

    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          feedkey("<C-n>")
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          feedkey("<C-p>")
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },

    sources = {
      { name = 'nvim_lua' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
      { name = 'calc' },
      { name = 'crates' },
      { name = 'buffer' },
    },
  }
end

function M.config()
end

return M
