-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

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
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/dbuch/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/dbuch/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/dbuch/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/dbuch/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/dbuch/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
    config = { "\27LJ\2\nä\2\0\0\4\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0B\1\2\0016\1\0\0'\3\5\0B\1\2\0029\1\6\1B\1\1\1K\0\1\0\14lazy_load luasnip.loaders.from_vscode\1\0\5\24delete_check_events\16TextChanged\17updateevents\29TextChanged,TextChangedI\24enable_autosnippets\2\24region_check_events\16InsertEnter\fhistory\1\15set_config\vconfig\fluasnip\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["crates.nvim"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  ["diffview.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\15statusline\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/galaxyline.nvim",
    url = "https://github.com/glepnir/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\19gitsigns-setup\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  kommentary = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/kommentary",
    url = "https://github.com/b3nj5m1n/kommentary"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lsp-status.nvim",
    url = "https://github.com/nvim-lua/lsp-status.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\nµ\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\tText\nÓ™ì  \vFolder\nÓ™É  \14Reference\nÓ™î  \15EnumMember\nÓ™ï  \tFile\nÓ©ª  \vStruct\nÓ™ë  \nColor\nÓ≠ú  \nEvent\nÓ™Ü  \fSnippet\nÓ≠¶  \18TypeParameter\nÓ™í  \fKeyword\nÓ≠¢  \tEnum\nÓ™ï  \nValue\nÓ™ï  \tUnit\nÓ™ñ  \rProperty\nÓ≠•  \vModule\nÓ™ã  \rOperator\nÓ≠§  \14Interface\nÓ≠°  \rFunction\nÓ™å  \nClass\nÓ≠õ  \rVariable\nÓ™à  \rConstant\nÓ≠ù  \nField\nÓ≠ü  \16Constructor\nÓ™å  \vMethod\nÓ™å  \1\0\1\tmode\ttext\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nﬂ\1\0\0\5\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\1K\0\1\0\26code_action_lightbulb\1\0\a\22cache_code_action\2\21enable_in_insert\2\tsign\2\16update_time\3ñ\1\17virtual_text\1\18sign_priority\3\20\venable\2\1\0\1\29code_action_num_shortcut\2\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lua-dev.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/lua-dev.nvim",
    url = "https://github.com/folke/lua-dev.nvim"
  },
  ["material.nvim"] = {
    config = { "\27LJ\2\n¶\24\0\0\6\0á\1\0œ\0016\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\b\0005\3\a\0=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\0025\3\22\0005\4\17\0006\5\18\0=\5\19\0046\5\20\0=\5\21\4=\4\23\0035\4\24\0006\5\18\0=\5\19\0046\5\20\0=\5\21\4=\4\25\0035\4\26\0006\5\18\0=\5\19\0046\5\20\0=\5\21\4=\4\27\0035\4\28\0006\5\29\0=\5\19\0046\5\20\0=\5\21\4=\4\30\0035\4\31\0006\5 \0=\5\19\0046\5\20\0=\5\21\4=\4!\0035\4\"\0006\5#\0=\5\19\0046\5\20\0=\5\21\4=\4$\0035\4%\0006\5&\0=\5\19\0046\5\20\0=\5\21\4=\4'\0035\4(\0006\5&\0=\5\19\0046\5\20\0=\5\21\4=\4)\0035\4*\0006\5+\0=\5\19\0046\5\20\0=\5\21\4=\4,\0035\4-\0006\5.\0=\5\19\0046\5\20\0=\5\21\4=\4/\0035\0040\0006\0051\0=\5\19\0046\5\20\0=\5\21\4=\0042\0035\0043\0006\0054\0=\5\19\0046\5\20\0=\5\21\4=\0045\0035\0046\0006\0054\0=\5\19\0046\5\20\0=\5\21\4=\0047\0035\0048\0006\5.\0=\5\19\0046\5\20\0=\5\21\4=\0049\0035\4:\0006\0051\0=\5\19\0046\5\20\0=\5\21\4=\4;\0035\4<\0006\0051\0=\5\19\0046\5\20\0=\5\21\4=\4=\0035\4>\0006\5?\0=\5\19\0046\5\20\0=\5\21\4=\4@\0035\4A\0006\0054\0=\5\19\0046\5\20\0=\5\21\4=\4B\0035\4C\0006\5D\0=\5\19\0046\5\20\0=\5\21\4=\4E\0035\4F\0006\5.\0=\5\19\0046\5\20\0=\5\21\4=\4G\0035\4H\0=\4I\0035\4J\0=\4K\0035\4L\0=\4M\0035\4N\0=\4O\0035\4P\0=\4Q\0035\4R\0=\4S\0035\4T\0=\4U\0035\4V\0=\4W\0035\4X\0=\4Y\0035\4Z\0=\4[\0035\4\\\0=\4]\0035\4^\0=\4_\0035\4`\0=\4a\0035\4b\0=\4c\0035\4d\0=\4e\0035\4f\0=\4g\0035\4h\0=\4i\0035\4j\0=\4k\0035\4l\0=\4m\0035\4n\0=\4o\0035\4p\0=\4q\0035\4r\0=\4s\0035\4t\0=\4u\0035\4v\0=\4w\0035\4x\0=\4y\0035\4z\0=\4{\0035\4|\0=\4}\0035\4~\0=\4\0035\4Ä\0=\4Å\3=\3Ç\0025\3É\0=\3Ñ\2B\0\2\0016\0\0\0009\0Ö\0'\2Ü\0B\0\2\1K\0\1\0\25colorscheme material\bcmd\fplugins\1\0\17\rlsp_saga\2\14telescope\2\14nvim_tree\2\15git_gutter\2\vneogit\1\rnvim_cmp\2\17sidebar_nvim\2\rgitsigns\2\ftrouble\2\tmini\1\20nvim_illuminate\1\21indent_blankline\1\bhop\1\nsneak\1\14which_key\1\15nvim_navic\1\rnvim_dap\2\22custom_highlights\29CmpItemKindTypeParameter\1\0\2\afg\f#D8EEEB\abg\f#58B5A8\21CmpItemKindColor\1\0\2\afg\f#D8EEEB\abg\f#58B5A8\25CmpItemKindInterface\1\0\2\afg\f#D8EEEB\abg\f#58B5A8\26CmpItemKindEnumMember\1\0\2\afg\f#DDE5F5\abg\f#6C8ED4\21CmpItemKindValue\1\0\2\afg\f#DDE5F5\abg\f#6C8ED4\22CmpItemKindMethod\1\0\2\afg\f#DDE5F5\abg\f#6C8ED4\22CmpItemKindFolder\1\0\2\afg\f#F5EBD9\abg\f#D4A959\23CmpItemKindSnippet\1\0\2\afg\f#F5EBD9\abg\f#D4A959\20CmpItemKindUnit\1\0\2\afg\f#F5EBD9\abg\f#D4A959\20CmpItemKindFile\1\0\2\afg\f#C5CDD9\abg\f#7E8294\24CmpItemKindVariable\1\0\2\afg\f#C5CDD9\abg\f#7E8294\24CmpItemKindOperator\1\0\2\afg\f#EADFF0\abg\f#A377BF\22CmpItemKindModule\1\0\2\afg\f#EADFF0\abg\f#A377BF\21CmpItemKindClass\1\0\2\afg\f#EADFF0\abg\f#A377BF\22CmpItemKindStruct\1\0\2\afg\f#EADFF0\abg\f#A377BF\24CmpItemKindFunction\1\0\2\afg\f#EADFF0\abg\f#A377BF\25CmpItemKindReference\1\0\2\afg\f#FFE082\abg\f#D4BB6C\27CmpItemKindConstructor\1\0\2\afg\f#FFE082\abg\f#D4BB6C\24CmpItemKindConstant\1\0\2\afg\f#FFE082\abg\f#D4BB6C\23CmpItemKindKeyword\1\0\2\afg\f#C3E88D\abg\f#9FBD73\20CmpItemKindEnum\1\0\2\afg\f#C3E88D\abg\f#9FBD73\20CmpItemKindText\1\0\2\afg\f#C3E88D\abg\f#9FBD73\21CmpItemKindEvent\1\0\2\afg\f#EED8DA\abg\f#B5585F\24CmpItemKindProperty\1\0\2\afg\f#EED8DA\abg\f#B5585F\21CmpItemKindField\1\0\2\afg\f#EED8DA\abg\f#B5585F\16CmpItemMenu\1\0\3\afg\f#C792EA\abg\tNONE\vitalic\2\26CmpItemAbbrMatchFuzzy\1\0\3\afg\f#82AAFF\abg\tNONE\tbold\2\21CmpItemAbbrMatch\1\0\3\afg\f#82AAFF\abg\tNONE\tbold\2\26CmpItemAbbrDeprecated\1\0\3\afg\f#7E8294\abg\tNONE\18strikethrough\2\15Underlined\1\0\0\fSpecial\17COLOR_VIOLET\1\0\0\14Structure\1\0\0\tType\17COLOR_YELLOW\1\0\0\nMacro\1\0\0\vDefine\1\0\0\fInclude\1\0\0\fPreProc\1\0\0\rOperator\15COLOR_CYAN\1\0\0\14Statement\17COLOR_PURPLE\1\0\0\rFunction\15COLOR_BLUE\1\0\0\15Identifier\14COLOR_RED\1\0\0\14Character\1\0\0\vString\16COLOR_GREEN\1\0\0\rConstant\17COLOR_ORANGE\1\0\0\fConceal\16COLOR_BROWN\1\0\0\fComment\19COLOR_COMMENTS\1\0\1\vitalic\2\16NormalFloat\1\0\0\rNormalNC\1\0\0\vNormal\1\0\0\abg\rCOLOR_BG\afg\rCOLOR_FG\1\0\0\fdisable\1\0\5\14eob_lines\1\15background\1\16term_colors\1\fborders\1\19colored_cursor\1\20high_visibility\1\0\2\vdarker\1\flighter\1\23contrast_filetypes\fitalics\1\0\5\14functions\1\14variables\1\fstrings\1\rcomments\2\rkeywords\1\rcontrast\1\0\0\1\0\a\15popup_menu\1\24non_current_windows\1\16cursor_line\1\16sign_column\1\17line_numbers\1\21floating_windows\1\rsidebars\1\nsetup\rmaterial\frequire\vdarker\19material_style\6g\bvim\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/material.nvim",
    url = "https://github.com/marko-cerovac/material.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n‹\1\0\0\n\0\f\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\1\18\4\2\0009\2\6\2'\5\a\0009\6\b\0005\b\n\0005\t\t\0=\t\v\bB\6\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\14dap-setup\frequire\0" },
    loaded = true,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-python"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-hlslens"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    config = { "\27LJ\2\n—\1\0\0\4\0\a\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\nicons\1\0\5\tWARN\bÔÅ™\nTRACE\b‚úé\tINFO\bÔÅö\nERROR\bÔÅó\nDEBUG\bÔÜà\1\0\3\vstages\22fade_in_slide_out\ftimeout\3÷\r\22background_colour\vNormal\nsetup\vnotify\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\np\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\23sync_root_with_cwd\2\18open_on_setup\1\18disable_netrw\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-treesitter-refactor", "nvim-dap-virtual-text", "nvim-treesitter-textobjects" },
    config = { "\27LJ\2\n@\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\22tree-sitter-setup\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-refactor",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    config = { "\27LJ\2\n˜\2\0\0\6\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\0025\3\t\0=\3\n\0026\3\v\0009\3\f\0039\3\r\3'\5\14\0B\3\2\2=\3\15\2B\0\2\1K\0\1\0\rdatapath\tdata\fstdpath\afn\bvim\17exclude_dirs\1\4\0\0\21~/.local/share/*\27~/.rustup/toolchains/*\15~/.cargo/*\15ignore_lsp\rpatterns\1\t\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\15Cargo.toml\22detection_methods\1\3\0\0\fpattern\blsp\1\0\3\16manual_mode\1\16show_hidden\1\17silent_chdir\2\nsetup\17project_nvim\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["rust-tools.nvim"] = {
    config = { "\27LJ\2\ní\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\bdap\1\0\0\fadapter\1\0\0\1\0\3\fcommand\16lldb-vscode\tname\frt_lldb\ttype\15executable\nsetup\15rust-tools\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/rust.vim",
    url = "https://github.com/rust-lang/rust.vim"
  },
  ["telescope-dap.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    config = { "\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17file_browser\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-project.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20telescope-setup\frequire\0" },
    loaded = true,
    needs_bufread = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\nü\3\0\1\b\0\21\0;6\1\0\0009\1\1\0019\3\1\0'\4\2\0B\1\3\2\15\0\1\0X\0023Ä5\1\4\0009\2\3\0=\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\n\0'\6\v\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\f\0'\6\v\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1K\0\1\0\22<Cmd>wincmd l<CR>\n<C-l>\22<Cmd>wincmd k<CR>\n<C-k>\22<Cmd>wincmd j<CR>\n<C-j>\22<Cmd>wincmd h<CR>\n<C-h>\ajk\15<C-\\><C-n>\n<esc>\6t\bset\vkeymap\bvim\vbuffer\1\0\0\bbuf\16#toggleterm\nmatch\vstring´\1\1\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0005\3\t\0003\4\b\0=\4\n\3B\0\3\1K\0\1\0\rcallback\1\0\0\0\rTermOpen\24nvim_create_autocmd\bapi\bvim\1\0\2\nshell\anu\20shade_terminals\1\nsetup\15toggleterm\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nﬁ\4\0\0\5\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\2B\0\2\1K\0\1\0\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\rprevious\6k\nclose\6q\tnext\6j\fpreview\6p\nhover\6K\19toggle_preview\6P\16toggle_mode\6m\frefresh\6r\vcancel\n<esc>\1\0\15\16fold_closed\bÔë†\vheight\3\n\14fold_open\bÔëº\nwidth\0032\nicons\2\ngroup\2\17indent_lines\2\rposition\vbottom\tmode\26workspace_diagnostics\14auto_fold\1\17auto_preview\2\15auto_close\2\14auto_open\1\fpadding\2\25use_diagnostic_signs\2\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-matchup"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-toml"] = {
    loaded = true,
    path = "/home/dbuch/.local/share/nvim/site/pack/packer/start/vim-toml",
    url = "https://github.com/cespare/vim-toml"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20telescope-setup\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
time([[packadd for telescope.nvim]], true)
vim.cmd [[packadd telescope.nvim]]
time([[packadd for telescope.nvim]], false)
-- Setup for: nvim-dap
time([[Setup for nvim-dap]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14dap-setup\frequire\0", "setup", "nvim-dap")
time([[Setup for nvim-dap]], false)
time([[packadd for nvim-dap]], true)
vim.cmd [[packadd nvim-dap]]
time([[packadd for nvim-dap]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\19gitsigns-setup\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\15statusline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n‹\1\0\0\n\0\f\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\2\5\1\18\4\2\0009\2\6\2'\5\a\0009\6\b\0005\b\n\0005\t\t\0=\t\v\bB\6\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\17confirm_done\aon\nevent\bcmp\"nvim-autopairs.completion.cmp\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\14dap-setup\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: rust-tools.nvim
time([[Config for rust-tools.nvim]], true)
try_loadstring("\27LJ\2\ní\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\bdap\1\0\0\fadapter\1\0\0\1\0\3\fcommand\16lldb-vscode\tname\frt_lldb\ttype\15executable\nsetup\15rust-tools\frequire\0", "config", "rust-tools.nvim")
time([[Config for rust-tools.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n˜\2\0\0\6\0\16\0\0216\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\0025\3\6\0=\3\a\0024\3\0\0=\3\b\0025\3\t\0=\3\n\0026\3\v\0009\3\f\0039\3\r\3'\5\14\0B\3\2\2=\3\15\2B\0\2\1K\0\1\0\rdatapath\tdata\fstdpath\afn\bvim\17exclude_dirs\1\4\0\0\21~/.local/share/*\27~/.rustup/toolchains/*\15~/.cargo/*\15ignore_lsp\rpatterns\1\t\0\0\t.git\v_darcs\b.hg\t.bzr\t.svn\rMakefile\17package.json\15Cargo.toml\22detection_methods\1\3\0\0\fpattern\blsp\1\0\3\16manual_mode\1\16show_hidden\1\17silent_chdir\2\nsetup\17project_nvim\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: material.nvim
time([[Config for material.nvim]], true)
try_loadstring("\27LJ\2\n¶\24\0\0\6\0á\1\0œ\0016\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0005\2\b\0005\3\a\0=\3\t\0025\3\n\0=\3\v\0024\3\0\0=\3\f\0025\3\r\0=\3\14\0025\3\15\0=\3\16\0025\3\22\0005\4\17\0006\5\18\0=\5\19\0046\5\20\0=\5\21\4=\4\23\0035\4\24\0006\5\18\0=\5\19\0046\5\20\0=\5\21\4=\4\25\0035\4\26\0006\5\18\0=\5\19\0046\5\20\0=\5\21\4=\4\27\0035\4\28\0006\5\29\0=\5\19\0046\5\20\0=\5\21\4=\4\30\0035\4\31\0006\5 \0=\5\19\0046\5\20\0=\5\21\4=\4!\0035\4\"\0006\5#\0=\5\19\0046\5\20\0=\5\21\4=\4$\0035\4%\0006\5&\0=\5\19\0046\5\20\0=\5\21\4=\4'\0035\4(\0006\5&\0=\5\19\0046\5\20\0=\5\21\4=\4)\0035\4*\0006\5+\0=\5\19\0046\5\20\0=\5\21\4=\4,\0035\4-\0006\5.\0=\5\19\0046\5\20\0=\5\21\4=\4/\0035\0040\0006\0051\0=\5\19\0046\5\20\0=\5\21\4=\0042\0035\0043\0006\0054\0=\5\19\0046\5\20\0=\5\21\4=\0045\0035\0046\0006\0054\0=\5\19\0046\5\20\0=\5\21\4=\0047\0035\0048\0006\5.\0=\5\19\0046\5\20\0=\5\21\4=\0049\0035\4:\0006\0051\0=\5\19\0046\5\20\0=\5\21\4=\4;\0035\4<\0006\0051\0=\5\19\0046\5\20\0=\5\21\4=\4=\0035\4>\0006\5?\0=\5\19\0046\5\20\0=\5\21\4=\4@\0035\4A\0006\0054\0=\5\19\0046\5\20\0=\5\21\4=\4B\0035\4C\0006\5D\0=\5\19\0046\5\20\0=\5\21\4=\4E\0035\4F\0006\5.\0=\5\19\0046\5\20\0=\5\21\4=\4G\0035\4H\0=\4I\0035\4J\0=\4K\0035\4L\0=\4M\0035\4N\0=\4O\0035\4P\0=\4Q\0035\4R\0=\4S\0035\4T\0=\4U\0035\4V\0=\4W\0035\4X\0=\4Y\0035\4Z\0=\4[\0035\4\\\0=\4]\0035\4^\0=\4_\0035\4`\0=\4a\0035\4b\0=\4c\0035\4d\0=\4e\0035\4f\0=\4g\0035\4h\0=\4i\0035\4j\0=\4k\0035\4l\0=\4m\0035\4n\0=\4o\0035\4p\0=\4q\0035\4r\0=\4s\0035\4t\0=\4u\0035\4v\0=\4w\0035\4x\0=\4y\0035\4z\0=\4{\0035\4|\0=\4}\0035\4~\0=\4\0035\4Ä\0=\4Å\3=\3Ç\0025\3É\0=\3Ñ\2B\0\2\0016\0\0\0009\0Ö\0'\2Ü\0B\0\2\1K\0\1\0\25colorscheme material\bcmd\fplugins\1\0\17\rlsp_saga\2\14telescope\2\14nvim_tree\2\15git_gutter\2\vneogit\1\rnvim_cmp\2\17sidebar_nvim\2\rgitsigns\2\ftrouble\2\tmini\1\20nvim_illuminate\1\21indent_blankline\1\bhop\1\nsneak\1\14which_key\1\15nvim_navic\1\rnvim_dap\2\22custom_highlights\29CmpItemKindTypeParameter\1\0\2\afg\f#D8EEEB\abg\f#58B5A8\21CmpItemKindColor\1\0\2\afg\f#D8EEEB\abg\f#58B5A8\25CmpItemKindInterface\1\0\2\afg\f#D8EEEB\abg\f#58B5A8\26CmpItemKindEnumMember\1\0\2\afg\f#DDE5F5\abg\f#6C8ED4\21CmpItemKindValue\1\0\2\afg\f#DDE5F5\abg\f#6C8ED4\22CmpItemKindMethod\1\0\2\afg\f#DDE5F5\abg\f#6C8ED4\22CmpItemKindFolder\1\0\2\afg\f#F5EBD9\abg\f#D4A959\23CmpItemKindSnippet\1\0\2\afg\f#F5EBD9\abg\f#D4A959\20CmpItemKindUnit\1\0\2\afg\f#F5EBD9\abg\f#D4A959\20CmpItemKindFile\1\0\2\afg\f#C5CDD9\abg\f#7E8294\24CmpItemKindVariable\1\0\2\afg\f#C5CDD9\abg\f#7E8294\24CmpItemKindOperator\1\0\2\afg\f#EADFF0\abg\f#A377BF\22CmpItemKindModule\1\0\2\afg\f#EADFF0\abg\f#A377BF\21CmpItemKindClass\1\0\2\afg\f#EADFF0\abg\f#A377BF\22CmpItemKindStruct\1\0\2\afg\f#EADFF0\abg\f#A377BF\24CmpItemKindFunction\1\0\2\afg\f#EADFF0\abg\f#A377BF\25CmpItemKindReference\1\0\2\afg\f#FFE082\abg\f#D4BB6C\27CmpItemKindConstructor\1\0\2\afg\f#FFE082\abg\f#D4BB6C\24CmpItemKindConstant\1\0\2\afg\f#FFE082\abg\f#D4BB6C\23CmpItemKindKeyword\1\0\2\afg\f#C3E88D\abg\f#9FBD73\20CmpItemKindEnum\1\0\2\afg\f#C3E88D\abg\f#9FBD73\20CmpItemKindText\1\0\2\afg\f#C3E88D\abg\f#9FBD73\21CmpItemKindEvent\1\0\2\afg\f#EED8DA\abg\f#B5585F\24CmpItemKindProperty\1\0\2\afg\f#EED8DA\abg\f#B5585F\21CmpItemKindField\1\0\2\afg\f#EED8DA\abg\f#B5585F\16CmpItemMenu\1\0\3\afg\f#C792EA\abg\tNONE\vitalic\2\26CmpItemAbbrMatchFuzzy\1\0\3\afg\f#82AAFF\abg\tNONE\tbold\2\21CmpItemAbbrMatch\1\0\3\afg\f#82AAFF\abg\tNONE\tbold\2\26CmpItemAbbrDeprecated\1\0\3\afg\f#7E8294\abg\tNONE\18strikethrough\2\15Underlined\1\0\0\fSpecial\17COLOR_VIOLET\1\0\0\14Structure\1\0\0\tType\17COLOR_YELLOW\1\0\0\nMacro\1\0\0\vDefine\1\0\0\fInclude\1\0\0\fPreProc\1\0\0\rOperator\15COLOR_CYAN\1\0\0\14Statement\17COLOR_PURPLE\1\0\0\rFunction\15COLOR_BLUE\1\0\0\15Identifier\14COLOR_RED\1\0\0\14Character\1\0\0\vString\16COLOR_GREEN\1\0\0\rConstant\17COLOR_ORANGE\1\0\0\fConceal\16COLOR_BROWN\1\0\0\fComment\19COLOR_COMMENTS\1\0\1\vitalic\2\16NormalFloat\1\0\0\rNormalNC\1\0\0\vNormal\1\0\0\abg\rCOLOR_BG\afg\rCOLOR_FG\1\0\0\fdisable\1\0\5\14eob_lines\1\15background\1\16term_colors\1\fborders\1\19colored_cursor\1\20high_visibility\1\0\2\vdarker\1\flighter\1\23contrast_filetypes\fitalics\1\0\5\14functions\1\14variables\1\fstrings\1\rcomments\2\rkeywords\1\rcontrast\1\0\0\1\0\a\15popup_menu\1\24non_current_windows\1\16cursor_line\1\16sign_column\1\17line_numbers\1\21floating_windows\1\rsidebars\1\nsetup\rmaterial\frequire\vdarker\19material_style\6g\bvim\0", "config", "material.nvim")
time([[Config for material.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nﬂ\1\0\0\5\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\3B\1\2\1K\0\1\0\26code_action_lightbulb\1\0\a\22cache_code_action\2\21enable_in_insert\2\tsign\2\16update_time\3ñ\1\17virtual_text\1\18sign_priority\3\20\venable\2\1\0\1\29code_action_num_shortcut\2\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\nµ\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\tText\nÓ™ì  \vFolder\nÓ™É  \14Reference\nÓ™î  \15EnumMember\nÓ™ï  \tFile\nÓ©ª  \vStruct\nÓ™ë  \nColor\nÓ≠ú  \nEvent\nÓ™Ü  \fSnippet\nÓ≠¶  \18TypeParameter\nÓ™í  \fKeyword\nÓ≠¢  \tEnum\nÓ™ï  \nValue\nÓ™ï  \tUnit\nÓ™ñ  \rProperty\nÓ≠•  \vModule\nÓ™ã  \rOperator\nÓ≠§  \14Interface\nÓ≠°  \rFunction\nÓ™å  \nClass\nÓ≠õ  \rVariable\nÓ™à  \rConstant\nÓ≠ù  \nField\nÓ≠ü  \16Constructor\nÓ™å  \vMethod\nÓ™å  \1\0\1\tmode\ttext\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nﬁ\4\0\0\5\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\2B\0\2\1K\0\1\0\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\rprevious\6k\nclose\6q\tnext\6j\fpreview\6p\nhover\6K\19toggle_preview\6P\16toggle_mode\6m\frefresh\6r\vcancel\n<esc>\1\0\15\16fold_closed\bÔë†\vheight\3\n\14fold_open\bÔëº\nwidth\0032\nicons\2\ngroup\2\17indent_lines\2\rposition\vbottom\tmode\26workspace_diagnostics\14auto_fold\1\17auto_preview\2\15auto_close\2\14auto_open\1\fpadding\2\25use_diagnostic_signs\2\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: toggleterm.nvim
time([[Config for toggleterm.nvim]], true)
try_loadstring("\27LJ\2\nü\3\0\1\b\0\21\0;6\1\0\0009\1\1\0019\3\1\0'\4\2\0B\1\3\2\15\0\1\0X\0023Ä5\1\4\0009\2\3\0=\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\n\0'\6\v\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\f\0'\6\v\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\0016\2\6\0009\2\a\0029\2\b\2'\4\t\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1K\0\1\0\22<Cmd>wincmd l<CR>\n<C-l>\22<Cmd>wincmd k<CR>\n<C-k>\22<Cmd>wincmd j<CR>\n<C-j>\22<Cmd>wincmd h<CR>\n<C-h>\ajk\15<C-\\><C-n>\n<esc>\6t\bset\vkeymap\bvim\vbuffer\1\0\0\bbuf\16#toggleterm\nmatch\vstring´\1\1\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\4\0009\0\5\0009\0\6\0'\2\a\0005\3\t\0003\4\b\0=\4\n\3B\0\3\1K\0\1\0\rcallback\1\0\0\0\rTermOpen\24nvim_create_autocmd\bapi\bvim\1\0\2\nshell\anu\20shade_terminals\1\nsetup\15toggleterm\frequire\0", "config", "toggleterm.nvim")
time([[Config for toggleterm.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n>\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\vconfig\20telescope-setup\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
try_loadstring("\27LJ\2\n—\1\0\0\4\0\a\0\0146\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\0016\0\6\0006\1\0\0'\3\1\0B\1\2\2=\1\1\0K\0\1\0\bvim\nicons\1\0\5\tWARN\bÔÅ™\nTRACE\b‚úé\tINFO\bÔÅö\nERROR\bÔÅó\nDEBUG\bÔÜà\1\0\3\vstages\22fade_in_slide_out\ftimeout\3÷\r\22background_colour\vNormal\nsetup\vnotify\frequire\0", "config", "nvim-notify")
time([[Config for nvim-notify]], false)
-- Config for: telescope-file-browser.nvim
time([[Config for telescope-file-browser.nvim]], true)
try_loadstring("\27LJ\2\nQ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\17file_browser\19load_extension\14telescope\frequire\0", "config", "telescope-file-browser.nvim")
time([[Config for telescope-file-browser.nvim]], false)
-- Config for: crates.nvim
time([[Config for crates.nvim]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vcrates\frequire\0", "config", "crates.nvim")
time([[Config for crates.nvim]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\nä\2\0\0\4\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\1\2\0009\1\3\0015\3\4\0B\1\2\0016\1\0\0'\3\5\0B\1\2\0029\1\6\1B\1\1\1K\0\1\0\14lazy_load luasnip.loaders.from_vscode\1\0\5\24delete_check_events\16TextChanged\17updateevents\29TextChanged,TextChangedI\24enable_autosnippets\2\24region_check_events\16InsertEnter\fhistory\1\15set_config\vconfig\fluasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\np\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\23sync_root_with_cwd\2\18open_on_setup\1\18disable_netrw\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
