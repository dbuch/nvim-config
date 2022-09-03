local fn = vim.fn

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
NeedsBootstrap = not vim.loop.fs_stat(install_path)

if NeedsBootstrap then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  print("Reopen Nvim and dbuch is running..")
  return
end

local packer = require('packer')
local packer_util = require('packer.util')

packer.startup({ function(use)
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
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
      require 'nvim-autopairs'.setup {
      }
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
      }
    end
  }

  use {
    'numToStr/FTerm.nvim',
    config = function()
      require 'FTerm'.setup({
        border     = 'single',
        dimensions = {
          height = 0.9,
          width = 0.9,
        },
      })
      vim.cmd('command! FloatermToggle lua require("FTerm").toggle()')
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
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},

        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},

        -- Show hidden files in telescope
        show_hidden = false,
        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = false,

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
        --[[ signs = {
          -- icons / text used for a diagnostic
          error = "",
          warning = "",
          hint = "",
          information = "",
          other = "﫠"
        }, ]]
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
    'kaicataldo/material.vim',
    config = function()
      vim.g.material_theme_style = 'darker'
      vim.cmd [[colorscheme material]]
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
  use 'onsails/lspkind-nvim'
  use 'nvim-lua/lsp-status.nvim'

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
      require('crates').setup { }
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
  if NeedsBootstrap then
    packer.sync()
  end

end,
  config = {
    display = {
      open_fn = packer_util.float
    }
  } })
