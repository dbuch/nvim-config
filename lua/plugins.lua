local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  -- Vim Plugins
  use 'scrooloose/nerdcommenter'
  use 'rust-lang/rust.vim'
  use 'lotabout/skim.vim'
  use 'lambdalisue/suda.vim'
  use 'markonm/traces.vim'
  use 'editorconfig/editorconfig-vim'
  use 'justinmk/vim-dirvish'
  use 'voldikss/vim-floaterm'
  use 'airblade/vim-rooter'
  use 'tpope/vim-sensible'
  use 'justinmk/vim-sneak'
  use 'Matt-Deacalion/vim-systemd-syntax'
  use 'dhruvasagar/vim-table-mode'
  use 'cespare/vim-toml'
  use 'terryma/vim-multiple-cursors'

  -- Lua Plugins
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function () vim.cmd [[:TSUpdate]] end,
    requires = {
      {"nvim-treesitter/nvim-treesitter-refactor",    after = "nvim-treesitter"},
      {"nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter"},
    }
  }

  use 'kyazdani42/nvim-web-devicons'
  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      config = "require('statusline')",
      requires = {'kyazdani42/nvim-web-devicons' }
  }

  use 'norcalli/nvim-colorizer.lua'

  use {
    '~/dev/nvim/onedark.nvim',
    requires = 'tjdevries/colorbuddy.nvim'
  }

  use {
    'neovim/nvim-lspconfig',
    opt = false,
    event = { "BufNewFile *", "BufRead *" },
    requires = {
      'nvim-lua/lsp-status.nvim',
    },
    setup = "require'lsp-setup'.setup()",
    config = "require'lsp-setup'.config()",
  }

  use {
    "norcalli/snippets.nvim",
    config = "require'snippet-setup'.config()",
  }

  use {
    "nvim-lua/completion-nvim",
    event = "InsertEnter *",
    requires = {
      "norcalli/snippets.nvim",
    },
    setup = "require'completion-setup'.setup()",
    config = "require'completion-setup'.config()"
  }

  use {
    'nvim-telescope/telescope.nvim',
    opt = false,
    requires = {
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-lua/nvim-web-devicons',
      'nvim-telescope/telescope-dap.nvim',
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
    config = "require'dap-setup'.config()"
  }

  -- lsp-utils
  use 'nvim-lua/lsp_extensions.nvim'
  use {
    'RishabhRD/nvim-lsputils',
    requires = {
      'RishabhRD/popfix'
    }
  }

  -- Lua debug
  use 'bfredl/nvim-luadev'
end)

vim.api.nvim_command('autocmd BufWritePost plugins.lua PackerCompile')
