local execute = vim.api.nvim_command
local fn = vim.fn
local api = vim.api

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

api.nvim_command('packadd packer.nvim')

require('packer').startup({function(use)
  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  -- Vim Plugins
  use 'rust-lang/rust.vim'
  use 'lambdalisue/suda.vim'
  use 'markonm/traces.vim'
  use 'voldikss/vim-floaterm'
  use 'tpope/vim-sensible'
  use 'justinmk/vim-sneak'
  use 'cespare/vim-toml'
  use 'b3nj5m1n/kommentary'
  use 'gpanders/editorconfig.nvim'

  -- Theme
  --[[ use {
    '~/dev/nvim/onedark.nvim',
    requires = 'tjdevries/colorbuddy.nvim'
  } ]]

  use 'navarasu/onedark.nvim'

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- TODO: Maybe configure this abit?
      }
    end
  }

  -- Lua Plugins
  use 'nvim-lua/plenary.nvim'

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
    'glepnir/galaxyline.nvim',
    branch = 'main',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = "require'statusline'.config()",
  }

  use 'glepnir/lspsaga.nvim'
  use 'norcalli/nvim-colorizer.lua'

  use 'ray-x/lsp_signature.nvim'
  use 'onsails/lspkind-nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'

  use 'L3MON4D3/LuaSnip'
  -- use 'hrsh7th/nvim-compe'

  use 'hrsh7th/nvim-cmp'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-calc'
  use 'saadparwaiz1/cmp_luasnip'
  use { 'Saecki/crates.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use {
    'nvim-telescope/telescope.nvim',
    opt = false,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-dap.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', run = 'make' },
      { 'nvim-telescope/telescope-frecency.nvim', requires = {"tami5/sqlite.lua"}, config = function ()
        require"telescope".load_extension("frecency")
      end }
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
    setup = "require'dap-setup'.setup()",
    config = "require'dap-setup'.config()",
  }

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

  -- lsp-utils
  use 'nvim-lua/lsp_extensions.nvim'

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


  end,
  config = {
    display = {
      open_fn = require "packer.util".float
    }
  }
})
