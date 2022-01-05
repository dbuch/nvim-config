local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  PackerBootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')
local packer_util = require('packer.util')

packer.startup({function(use)
  -- Packer can manage itself as an optional plugin
  use 'wbthomason/packer.nvim'

  -- Legacy Vim Plugins
  use 'rust-lang/rust.vim'
  use 'lambdalisue/suda.vim'
  use 'justinmk/vim-sneak'
  use 'cespare/vim-toml'

  -- Lua Plugins
  use 'windwp/nvim-autopairs'
  use 'rinx/nvim-minimap'
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
          WARN =  "",
          INFO =  "",
          DEBUG = "",
          TRACE = "✎",
        },
      })
      vim.notify = require("notify")
    end
  }

  use {
    'numToStr/FTerm.nvim',
    config = function ()
      require'FTerm'.setup({
          border = 'single',
          dimensions  = {
              height = 0.9,
              width = 0.9,
          },
      })
      vim.cmd('command! FloatermToggle lua require("FTerm").toggle()')
    end
  }

  --[[ use {
    'simrat39/rust-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap',
    }
  } ]]

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
        detection_methods = { "lsp", "pattern" },

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

  use 'tjdevries/astronauta.nvim'

  -- Utils
  use 'b3nj5m1n/kommentary'
  use 'gpanders/editorconfig.nvim'

  -- Colors
  use 'norcalli/nvim-colorizer.lua'
  use 'navarasu/onedark.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    event = "BufRead *",
    requires = {
      {"nvim-treesitter/nvim-treesitter-refactor",    after = "nvim-treesitter"},
      {"nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter"}
    },
    config = "require'tree-sitter-setup'.config()",
  }

  use {
    'NTBBloodbath/galaxyline.nvim',
    branch = 'main',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = "require'statusline'.config()",
  }

  -- Lsp Plugins
  use 'neovim/nvim-lspconfig'

  use {
    'tami5/lspsaga.nvim',
    -- commit = "373bc031b39730cbfe492533c3acfac36007899a",
  }
  use 'ray-x/lsp_signature.nvim'
  use 'onsails/lspkind-nvim'
  use 'nvim-lua/lsp-status.nvim'
  -- use 'nvim-lua/lsp_extensions.nvim'

  use {
    'L3MON4D3/LuaSnip',
    config = function ()
      require('luasnip').config.history = false
    end
  }

  -- Completion Plugins
  use { 'hrsh7th/nvim-cmp', requires = { 'L3MON4D3/LuaSnip' } }
  use { 'hrsh7th/cmp-nvim-lsp', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-buffer', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-path', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-calc', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-cmdline', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'saadparwaiz1/cmp_luasnip', requires = { 'hrsh7th/nvim-cmp' } }

  use {
      'saecki/crates.nvim',
      event = { "BufRead Cargo.toml" },
      requires = { { 'nvim-lua/plenary.nvim' } },
      config = function()
          require('crates').setup()
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
      'ahmedkhalf/project.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim', requires = {"tami5/sqlite.lua"}, config = function ()
        require"telescope".load_extension("frecency")
      end },

    },
    setup = "require'telescope-setup'.setup()",
    config = "require'telescope-setup'.config()"
  }

  -- Dap
  use {
    "mfussenegger/nvim-dap",
    opt = false,
    requires = {
      "mfussenegger/nvim-dap-python",
      {"theHamsta/nvim-dap-virtual-text", after = "nvim-treesitter"}
    },
    setup = function () require'dap-setup'.setup() end,
    config = function () require'dap-setup'.config() end,
  }

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = "require'gitsigns-setup'.config()"
  }

  -- Matchup
  use 'andymass/vim-matchup'

  -- bootstrap
  if PackerBootstrap then
    packer.sync()
  end

  end,
  config = {
    display = {
      open_fn = packer_util.float
    }
  }
})
