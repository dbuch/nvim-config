return {
  {
    -- TODO: Maybe
    --   'garymjr/nvim-snippets',
    --   keys = {
    --     {
    --       '<Tab>',
    --       function()
    --         if vim.snippet.jumpable(1) then
    --           vim.schedule(function()
    --             vim.snippet.jump(1)
    --           end)
    --           return
    --         end
    --         return '<Tab>'
    --       end,
    --       expr = true,
    --       silent = true,
    --       mode = 'i',
    --     },
    --     {
    --       '<Tab>',
    --       function()
    --         vim.schedule(function()
    --           vim.snippet.jump(1)
    --         end)
    --       end,
    --       expr = true,
    --       silent = true,
    --       mode = 's',
    --     },
    --     {
    --       '<S-Tab>',
    --       function()
    --         if vim.snippet.jumpable(-1) then
    --           vim.schedule(function()
    --             vim.snippet.jump(-1)
    --           end)
    --           return
    --         end
    --         return '<S-Tab>'
    --       end,
    --       expr = true,
    --       silent = true,
    --       mode = { 'i', 's' },
    --     },
    --   },
    -- },
    -- {
    'dcampos/nvim-snippy',
    event = 'InsertEnter',
    config = function()
      require('snippy').setup {
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      }
    end,
  },
  -- Autocomplete
  {
    'saecki/crates.nvim',
    event = 'BufRead Cargo.toml',
    config = true,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'dcampos/cmp-snippy',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
    },
    opts = function()
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local snippy = require 'snippy'
      local has_words_before = require('dbuch.traits.nvim').has_words_before
      return {
        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body) -- For `snippy` users.
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
            elseif snippy.can_expand_or_advance() then
              snippy.expand_or_advance()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif snippy.can_jump(-1) then
              snippy.previous()
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
          { name = 'nvim_lsp', priority = 9 },
          { name = 'snippy', priority = 8 },
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
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
    end,
  },
}
