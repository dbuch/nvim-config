local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

return packer.startup(function()
  local use = packer.use
  -- Vim Plugins
  --  use 'itchyny/lightline.vim'
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
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'kyazdani42/nvim-web-devicons'

--  local_use 'express_line.nvim'

  --use {
    --'tjdevries/express_line.nvim',
    --requires = {
      --{'nvim-lua/plenary.nvim'},
    --}
  --}

  use {
    'glepnir/galaxyline.nvim',
      branch = 'main',
      config = function() require'statusline' end,
      requires = {'kyazdani42/nvim-web-devicons' }
  }

  use 'norcalli/nvim-colorizer.lua'

  -- Theme
  use {
    '~/.config/nvim/themes/onedark.nvim',
    requires = 'tjdevries/colorbuddy.nvim'
  }

  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'nvim-lua/completion-nvim'
  use 'nvim-lua/lsp-status.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    }
  }

  -- Dap
  use {
    'theHamsta/nvim-dap-virtual-text',
    requires = {
      'mfussenegger/nvim-dap',
      'nvim-telescope/telescope.nvim',
    }
  }

  use {
    'nvim-telescope/telescope-dap.nvim',
    requires = {
      'mfussenegger/nvim-dap',
      'nvim-telescope/telescope.nvim',
    }
  }

  -- TreeSitter

  use 'nvim-treesitter/nvim-treesitter'

  -- should be lagacy at some point
  use 'antoinemadec/FixCursorHold.nvim'

end)
