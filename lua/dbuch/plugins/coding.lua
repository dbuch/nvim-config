return {
  {
    'echasnovski/mini.pairs',
    version = false,
    event = 'LazyFile',
    opts = {},
  },
  {
    'echasnovski/mini.comment',
    version = false,
    event = 'LazyFile',
    opts = {},
  },
  {
    'echasnovski/mini.align',
    version = false,
    keys = function(_, keys)
      local plugin = require('lazy.core.config').spec.plugins['mini.align']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        { opts.mappings.start, desc = 'Start align', mode = { 'n', 'v' } },
        { opts.mappings.start_with_preview, desc = 'Start align with Preview', mode = { 'n', 'v' } },
      }
      return vim.list_extend(
        vim
          .iter(mappings)
          :filter(function(m)
            return m[1] and #m[1] > 0
          end)
          :totable(),
        keys
      )
    end,
    opts = {
      mappings = {
        start = 'ga',
        start_with_preview = 'gA',
      },
    },
  },
  {
    'echasnovski/mini.surround',
    version = false,
    keys = function(_, keys)
      local plugin = require('lazy.core.config').spec.plugins['mini.surround']
      local opts = require('lazy.core.plugin').values(plugin, 'opts', false)
      local mappings = {
        { opts.mappings.add, desc = 'Add surrounding', mode = { 'n', 'v' } },
        { opts.mappings.delete, desc = 'Delete surrounding' },
        { opts.mappings.find, desc = 'Find right surrounding' },
        { opts.mappings.find_left, desc = 'Find left surrounding' },
        { opts.mappings.highlight, desc = 'Highlight surrounding' },
        { opts.mappings.replace, desc = 'Replace surrounding' },
        { opts.mappings.update_n_lines, desc = 'Update `MiniSurround.config.n_lines`' },
      }
      return vim.list_extend(
        vim
          .iter(mappings)
          :filter(function(m)
            return m[1] and #m[1] > 0
          end)
          :totable(),
        keys
      )
    end,
    opts = {
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
    },
  },
  -- Autocomplete
  {
    'saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        over = true,
      },
      src = {
        cmp = {
          enabled = true,
        },
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      'garymjr/nvim-snippets',
    },
    opts = function()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local has_words_before = require('dbuch.traits.nvim').has_words_before
      return {
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
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
            local strOrEmpty = function(str)
              if str == nil then
                return ''
              end
              return str
            end
            ---@type table
            local kind = lspkind.cmp_format {
              mode = 'symbol_text',
              maxwidth = 50,
              ellipsis_char = '…',
              before = function(_entry, vim_item)
                vim_item.menu = ({
                  nvim_lsp = '󰞵',
                  nvim_lua = '',
                  treesitter = '',
                  path = '󰝰',
                  buffer = '󱈛',
                  zsh = '',
                  vsnip = '',
                  spell = '󰓆',
                })[entry.source.name]
                return vim_item
              end,
            }(entry, item)

            local tokens = {}
            for token in vim.gsplit(kind.kind, '%s') do
              if token ~= '' then
                table.insert(tokens, token)
              end
            end

            local menu = kind.menu
            if menu ~= nil then
              menu = ('%s %s'):format(menu, strOrEmpty(tokens[2]))
            else
              if tokens[2] ~= nil then
                menu = ('%s'):format(tokens[2])
              end
            end

            kind.kind = (' %s '):format(tokens[1])
            kind.menu = (' (%s)'):format(menu)

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
            elseif not vim.snippet and vim.snippet.jumpable(1) then
              vim.snippet.jump(1)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.jumpable(-1) then
              vim.snippet.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<A-j>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<A-k>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        sources = cmp.config.sources({
          { name = 'lazydev', priority = 10, group_index = 0 },
          { name = 'nvim_lsp', priority = 9 },
          { name = 'snippets', priority = 8 },
          { name = 'path', priority = 6 },
          { name = 'calc', priority = 5 },
          { name = 'crates', priority = 4 },
          {
            name = 'spell',
            priority = 3,
            option = {
              enable_in_context = function()
                return require('cmp.config.context').in_treesitter_capture 'spell'
              end,
            },
          },
        }, {
          { name = 'buffer', priority = 2, keyword_length = 3, max_item_count = 2 },
        }),
        sorting = {
          priority_weight = 1,
          comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.order,
          },
        },
        experimental = {
          ghost_text = true,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require 'cmp'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })
      cmp.setup(opts)
    end,
  },
  {
    'andymass/vim-matchup',
    event = 'LazyFile',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 100
    end,
  },
}
