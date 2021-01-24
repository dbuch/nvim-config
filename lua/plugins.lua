local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup({function(use)
  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  -- Vim Plugins
  use 'scrooloose/nerdcommenter'
  use 'rust-lang/rust.vim'
  use 'lambdalisue/suda.vim'
  use 'markonm/traces.vim'
  use 'editorconfig/editorconfig-vim'
  use 'voldikss/vim-floaterm'
  use 'tpope/vim-sensible'
  use 'justinmk/vim-sneak'
  use 'Matt-Deacalion/vim-systemd-syntax'
  use 'cespare/vim-toml'

  -- Theme
  use {
    '~/dev/nvim/onedark.nvim',
    requires = 'tjdevries/colorbuddy.nvim'
  }

  use 'sainnhe/sonokai'

  use 'kyazdani42/nvim-web-devicons'

  -- Lua Plugins
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

  use 'norcalli/nvim-colorizer.lua'

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
      {
        "steelsojka/completion-buffers",
        after = { "completion-nvim" }
      },
      {
        "nvim-treesitter/completion-treesitter",
        after = { "completion-nvim", "nvim-treesitter" }
      }
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
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-dap.nvim',
      "nvim-telescope/telescope-fzy-native.nvim"
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

  -- Lua debug
  use 'bfredl/nvim-luadev'
  use 'rafcamlet/nvim-luapad'
  end,
  config = {
    display = {
      open_fn = require "packer.util".float
    }
  }
})

vim.api.nvim_command('autocmd BufWritePost plugins.lua PackerCompile')
