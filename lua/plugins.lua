local fn = vim.fn

COLOR_BG =             '#212121'
COLOR_FG =             '#eeffff'
COLOR_INVISIBLES =     '#65738e'
COLOR_COMMENTS =       '#545454'
COLOR_CARET =          '#ffcc00'
COLOR_SELECTION =      '#2c2c2c'
COLOR_GUIDES =         '#37474f'
COLOR_LINE_NUMBERS =   '#37474f'
COLOR_LINE_HIGHLIGHT = '#171717'
COLOR_WHITE =          '#ffffff'
COLOR_BLACK =          '#000000'
COLOR_ORANGE =         '#f78c6c'
COLOR_RED =            '#ff5370'
COLOR_YELLOW =         '#ffcb6b'
COLOR_GREEN =          '#c3e88d'
COLOR_CYAN =           '#89ddff'
COLOR_BLUE =           '#82aaff'
COLOR_PALEBLUE =       '#b2ccd6'
COLOR_PURPLE =         '#c792ea'
COLOR_BROWN =          '#c17e70'
COLOR_PINK =           '#f07178'
COLOR_VIOLET =         '#bb80b3'

CUSTOM_HIGHLIGHTS = {
  Normal =      { fg = COLOR_FG, bg = COLOR_BG },
  NormalNC =    { fg = COLOR_FG, bg = COLOR_BG },
  NormalFloat = { fg = COLOR_FG, bg = COLOR_BG },

  Comment    = { fg = COLOR_COMMENTS, bg = COLOR_BG, italic = true },
  Conceal    = { fg = COLOR_BROWN,    bg = COLOR_BG },
  Constant   = { fg = COLOR_ORANGE,   bg = COLOR_BG },
  String     = { fg = COLOR_GREEN,    bg = COLOR_BG },
  Character  = { fg = COLOR_GREEN,    bg = COLOR_BG },
  Identifier = { fg = COLOR_RED,      bg = COLOR_BG },
  Function   = { fg = COLOR_BLUE,     bg = COLOR_BG },
  Statement  = { fg = COLOR_PURPLE,   bg = COLOR_BG },
  Operator   = { fg = COLOR_CYAN,     bg = COLOR_BG },
  PreProc    = { fg = COLOR_CYAN,     bg = COLOR_BG },
  Include    = { fg = COLOR_BLUE,     bg = COLOR_BG },
  Define     = { fg = COLOR_PURPLE,   bg = COLOR_BG },
  Macro      = { fg = COLOR_PURPLE,   bg = COLOR_BG },
  Type       = { fg = COLOR_YELLOW,   bg = COLOR_BG },
  Structure  = { fg = COLOR_CYAN,     bg = COLOR_BG },
  Special    = { fg = COLOR_VIOLET,   bg = COLOR_BG,},
  Underlined = { fg = COLOR_BLUE,     bg = COLOR_BG },

  CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
  CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
  CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
  CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = true },

  CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

  CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

  CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

  CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

  CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
  CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

  CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

  CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

  CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}

local packer_installed = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if not vim.loop.fs_stat(install_path) then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
  end
  return false
end

local should_bootstrap = packer_installed()

require('packer').startup({ function(use)
  use 'lewis6991/impatient.nvim'

  -- Packer can manage itself as an optional plugin
  use 'wbthomason/packer.nvim'
  -- Legacy Vim Plugins
  use 'rust-lang/rust.vim'
  --  use 'lambdalisue/suda.vim'
  use 'justinmk/vim-sneak'
  use 'cespare/vim-toml'

  -- Lua Plugins
  use {
    'windwp/nvim-autopairs',
    config = function()
      require 'nvim-autopairs'.setup {}
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
    end,
    requires = {
      'hrsh7th/nvim-cmp',
    }
  }

  use 'folke/lua-dev.nvim'
  use { 'kevinhwang91/nvim-hlslens' }

  use {
    'rcarriga/nvim-notify',
    config = function()
      require("notify").setup({
        stages = "fade_in_slide_out",
        timeout = 1750,
        background_colour = "Normal",
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      vim.notify = require("notify")
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require 'nvim-tree'.setup {
        sync_root_with_cwd = true,
        disable_netrw = true,
        open_on_setup = false,
      }
    end
  }

  use { "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup {
        shade_terminals = false,
        shell = "nu"
      }
      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.api.nvim_create_autocmd("TermOpen", {
        callback = function(args)
          if string.match(args.match, "#toggleterm") then
            local opts = { buffer = args.buf }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
          end
        end
      })
    end
  }

  use {
    'simrat39/rust-tools.nvim',
    config = function()
      require("rust-tools").setup({
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      })
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
      'neovim/nvim-lspconfig',
    }
  }

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  -- Workspace/Projects

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,

        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "pattern", "lsp" },

        -- All the patterns used to detect root dir, when **"pattern"** is in
        -- detection_methods
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = { "~/.local/share/*", "~/.rustup/toolchains/*", "~/.cargo/*" },

        -- Show hidden files in telescope
        show_hidden = false,
        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,

        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),
      }
    end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- preview item
          next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = true, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation

        use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
      }
    end
  }

  -- Utils
  use 'b3nj5m1n/kommentary'
  use 'gpanders/editorconfig.nvim'

  -- Colors
  use 'norcalli/nvim-colorizer.lua'
  use 'folke/lsp-colors.nvim'
  use {
    'marko-cerovac/material.nvim',
    config = function()
      vim.g.material_style = "darker"
      require('material').setup({
        contrast = {
          sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
          floating_windows = false, -- Enable contrast for floating windows
          line_numbers = false, -- Enable contrast background for line numbers
          sign_column = false, -- Enable contrast background for the sign column
          cursor_line = false, -- Enable darker background for the cursor line
          non_current_windows = false, -- Enable darker background for non-current windows
          popup_menu = false, -- Enable lighter background for the popup menu
        },

        italics = {
          comments = true, -- Enable italic comments
          keywords = false, -- Enable italic keywords
          functions = false, -- Enable italic functions
          strings = false, -- Enable italic strings
          variables = false -- Enable italic variables
        },

        contrast_filetypes = { },

        high_visibility = {
          lighter = false, -- Enable higher contrast text for lighter style
          darker = false -- Enable higher contrast text for darker style
        },

        disable = {
          colored_cursor = false, -- Disable the colored cursor
          borders = false, -- Disable borders between verticaly split windows
          background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
          term_colors = false, -- Prevent the theme from setting terminal colors
          eob_lines = false -- Hide the end-of-buffer lines
        },

        custom_highlights = CUSTOM_HIGHLIGHTS,

        plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
          trouble = true,
          nvim_cmp = true,
          neogit = false,
          gitsigns = true,
          git_gutter = true,
          telescope = true,
          nvim_tree = true,
          sidebar_nvim = true,
          lsp_saga = true,
          nvim_dap = true,
          nvim_navic = false,
          which_key = false,
          sneak = false,
          hop = false,
          indent_blankline = false,
          nvim_illuminate = false,
          mini = false,
        }
      })
      vim.cmd 'colorscheme material'
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    event = "BufRead *",
    requires = {
      { "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" },
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }
    },
    config = function() require 'tree-sitter-setup'.config() end,
  }

  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require 'statusline'.config() end,
  }

  -- Lsp Plugins
  use 'neovim/nvim-lspconfig'
  use {
    'glepnir/lspsaga.nvim',
    branch = "main",
    config = function()
      local saga = require("lspsaga")
      saga.init_lsp_saga({
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        code_action_lightbulb = {
          enable = true,
          enable_in_insert = true,
          cache_code_action = true,
          sign = true,
          update_time = 150,
          sign_priority = 20,
          virtual_text = false,
        },
      })
    end,
  }
  use 'ray-x/lsp_signature.nvim'
  use {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind').init({
        mode = "text",
        symbol_map = {
          Text = '  ',
          Method = '  ',
          Function = '  ',
          Constructor = '  ',
          Field = '  ',
          Variable = '  ',
          Class = '  ',
          Interface = '  ',
          Module = '  ',
          Property = '  ',
          Unit = '  ',
          Value = '  ',
          Enum = '  ',
          Keyword = '  ',
          Snippet = '  ',
          Color = '  ',
          File = '  ',
          Reference = '  ',
          Folder = '  ',
          EnumMember = '  ',
          Constant = '  ',
          Struct = '  ',
          Event = '  ',
          Operator = '  ',
          TypeParameter = '  ',
        }
      })
    end

  }
  use 'nvim-lua/lsp-status.nvim'
  use "rafamadriz/friendly-snippets"

  use {
    'L3MON4D3/LuaSnip',
    config = function()
      local ls = require('luasnip')
      ls.config.set_config {
        history = false,
        updateevents = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        region_check_events = "InsertEnter",
        enable_autosnippets = true,
      }
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  }

  -- Completion Plugins
  use { 'hrsh7th/nvim-cmp', requires = { 'L3MON4D3/LuaSnip' } }
  use { 'hrsh7th/cmp-nvim-lsp', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-buffer', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-path', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-calc', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-cmdline', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'saadparwaiz1/cmp_luasnip', requires = { 'hrsh7th/nvim-cmp' } }
  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
    config = function()
      require('crates').setup {}
    end,
  }

  -- Fuzzy search
  use {
    'nvim-telescope/telescope.nvim',
    -- opt = false,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-dap.nvim',
      'nvim-telescope/telescope-project.nvim',
      { 'nvim-telescope/telescope-file-browser.nvim', config = function()
        require "telescope".load_extension "file_browser"
      end },
      'nvim-telescope/telescope-ui-select.nvim',
      'ahmedkhalf/project.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
    },
    setup = function() require 'telescope-setup'.setup() end,
    config = function() require 'telescope-setup'.config() end,
  }

  -- Dap
  use {
    "mfussenegger/nvim-dap",
    opt = false,
    requires = {
      "mfussenegger/nvim-dap-python",
      { "theHamsta/nvim-dap-virtual-text", after = "nvim-treesitter" }
    },
    setup = function() require 'dap-setup'.setup() end,
    config = function() require 'dap-setup'.config() end,
  }

  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function() require 'gitsigns-setup'.config() end
  }

  -- Matchup
  use 'andymass/vim-matchup'

  -- bootstrap
  if should_bootstrap then
    require('packer').sync()
  end

end,
  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
})
