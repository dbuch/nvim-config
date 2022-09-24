local M = {}
local lspkind = require('lspkind')


function M.setup()
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
      format = lspkind.cmp_format()
    },

    completion = {
      completeopt = 'menu,menuone,noinsert',
    },

    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<A-j>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<A-k>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
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
      { name = 'nvim_lsp_signature_help' }
    },

    compare = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },

    experimental = {
      ghost_text = true,
    }
  }

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  for _,v in pairs({ '/', '?' }) do
    cmp.setup.cmdline(v, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })
  end


end

function M.config()
end

return M
