-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/dbuch/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/dbuch/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/dbuch/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/dbuch/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dbuch/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/astronauta.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-calc"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["crates.nvim"] = {
    after_files = { "/home/dbuch/.local/share/nvim/site/pack/packer/opt/crates.nvim/after/plugin/cmp_crates.lua" },
    config = { "\27LJ\1\0024\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/crates.nvim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/editorconfig.nvim"
  },
  ["galaxyline.nvim"] = {
    config = { "require'statusline'.config()" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "require'gitsigns-setup'.config()" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lua-dev.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\1\0028\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vconfig\14dap-setup\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-minimap"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-minimap"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\1\2�\1\0\0\3\0\a\0\0144\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\0014\0\6\0004\1\0\0%\2\1\0>\1\2\2:\1\1\0G\0\1\0\bvim\nicons\1\0\5\nTRACE\b✎\nDEBUG\b\tWARN\b\tINFO\b\nERROR\b\1\0\3\22background_colour\vNormal\ftimeout\3�\r\vstages\22fade_in_slide_out\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-notify"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-refactor", "nvim-dap-virtual-text", "nvim-treesitter-textobjects" },
    config = { "require'tree-sitter-setup'.config()" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\1\2�\2\0\0\4\0\15\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\0012\2\0\0:\2\b\0012\2\0\0:\2\t\0014\2\n\0007\2\v\0027\2\f\2%\3\r\0>\2\2\2:\2\14\1>\0\2\1G\0\1\0\rdatapath\tdata\fstdpath\afn\bvim\17exclude_dirs\15ignore_lsp\rpatterns\1\b\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16manual_mode\1\17silent_chdir\1\16show_hidden\1\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/project.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/sqlite.lua"
  },
  ["suda.vim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim"
  },
  ["telescope-frecency.nvim"] = {
    config = { "\27LJ\1\2M\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\rfrecency\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-project.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require'telescope-setup'.config()" },
    loaded = true,
    needs_bufread = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  ["traces.vim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/traces.vim"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-matchup"
  },
  ["vim-sensible"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-sensible"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-toml"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nvim-dap
time([[Setup for nvim-dap]], true)
try_loadstring("\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14dap-setup\frequire\0", "setup", "nvim-dap")
time([[Setup for nvim-dap]], false)
time([[packadd for nvim-dap]], true)
vim.cmd [[packadd nvim-dap]]
time([[packadd for nvim-dap]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
require'telescope-setup'.setup()
time([[Setup for telescope.nvim]], false)
time([[packadd for telescope.nvim]], true)
vim.cmd [[packadd telescope.nvim]]
time([[packadd for telescope.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require'telescope-setup'.config()
time([[Config for telescope.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require'gitsigns-setup'.config()
time([[Config for gitsigns.nvim]], false)
-- Config for: telescope-frecency.nvim
time([[Config for telescope-frecency.nvim]], true)
try_loadstring("\27LJ\1\2M\0\0\2\0\4\0\a4\0\0\0%\1\1\0>\0\2\0027\0\2\0%\1\3\0>\0\2\1G\0\1\0\rfrecency\19load_extension\14telescope\frequire\0", "config", "telescope-frecency.nvim")
time([[Config for telescope-frecency.nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
require'statusline'.config()
time([[Config for galaxyline.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\1\2�\1\0\0\3\0\a\0\0144\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\1>\0\2\0014\0\6\0004\1\0\0%\2\1\0>\1\2\2:\1\1\0G\0\1\0\bvim\nicons\1\0\5\nTRACE\b✎\nDEBUG\b\tWARN\b\tINFO\b\nERROR\b\1\0\3\22background_colour\vNormal\ftimeout\3�\r\vstages\22fade_in_slide_out\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\1\0028\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\vconfig\14dap-setup\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\1\2�\2\0\0\4\0\15\0\0214\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\3\0003\2\4\0:\2\5\0013\2\6\0:\2\a\0012\2\0\0:\2\b\0012\2\0\0:\2\t\0014\2\n\0007\2\v\0027\2\f\2%\3\r\0>\2\2\2:\2\14\1>\0\2\1G\0\1\0\rdatapath\tdata\fstdpath\afn\bvim\17exclude_dirs\15ignore_lsp\rpatterns\1\b\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\22detection_methods\1\3\0\0\blsp\fpattern\1\0\3\16manual_mode\1\17silent_chdir\1\16show_hidden\1\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead Cargo.toml ++once lua require("packer.load")({'crates.nvim'}, { event = "BufRead Cargo.toml" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end