local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

luasnip.config.set_config {
  history = false,
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged',
  region_check_events = 'InsertEnter',
  enable_autosnippets = true,
}
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:Visual,Search:None',
      col_offset = -3,
      side_padding = 0,
    },
  },

  view = {
    -- entries = { name = 'custom', selection_order = 'near_cursor' },
    entries = { name = 'custom' },
  },

  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, item)
      local kind = lspkind.cmp_format {
        mode = 'symbol_text',
        maxwidth = 50,
        ellipsis_char = '…',
      }(entry, item)

      local tokens = {}
      for token in vim.gsplit(kind.kind, '%s') do
        if token ~= '' then
          table.insert(tokens, token)
        end
      end

      kind.kind = (' %s '):format(tokens[1])
      kind.menu = ('    (%s)'):format(tokens[2])

      return kind
    end,
  },

  completion = {
    completeopt = 'menu,menuone,noinsert',
  },

  mapping = cmp.mapping.preset.insert {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<A-j>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<A-k>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },

  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'crates' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
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
  },
}

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

for _, v in pairs { '/', '?' } do
  cmp.setup.cmdline(v, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' },
    },
  })
end
