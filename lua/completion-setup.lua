local M = {}
local lspkind = require('lspkind')


function M.setup()
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local check_back_space = function()
    local col = vim.fn.col '.' - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
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
      ["<tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-n>"), "n")
        elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
        elseif check_back_space() then
          vim.fn.feedkeys(t("<tab>"), "n")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-tab>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(t("<C-p>"), "n")
        elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
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
