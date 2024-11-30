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
    ---@module "crates.config"
    ---@type crates.UserConfig
    opts = {
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
      completion = {
        coq = {
          enabled = false,
        },
        cmp = {
          enabled = false,
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    lazy = false,
    -- version = 'v0.*',
    build = 'cargo build --release --target-dir=target',
    dependencies = {
      'echasnovski/mini.icons',
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          treesitter_highlighting = true,
        },
        list = {
          max_items = 20,
          selection = 'preselect',
        },
        menu = {
          draw = {
            treesitter = { 'lsp' },
            columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 } },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  --- @type string, string, boolean
                  local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                  return kind_icon
                end,
                highlight = function(ctx)
                  --- @type string, string, boolean
                  local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },

      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },

        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },

      fuzzy = {
        use_typo_resistance = true,
        use_frecency = true,
        use_proximity = true,
        sorts = { 'score', 'sort_text' },
        prebuilt_binaries = {
          download = false,
          force_version = nil,
          force_system_triple = nil,
          extra_curl_args = {},
        },
      },

      keymap = {
        preset = 'enter',

        ['<A-j>'] = { 'select_next', 'fallback' },
        ['<A-k>'] = { 'select_prev', 'fallback' },

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },

        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

        cmdline = {
          preset = 'default',
        },
      },

      snippets = {
        expand = function(snippet)
          vim.snippet.expand(snippet)
        end,
        active = function(filter)
          return vim.snippet.active(filter)
        end,
        jump = function(direction)
          vim.snippet.jump(direction)
        end,
      },

      signature = {
        enabled = true,
      },
    },
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
