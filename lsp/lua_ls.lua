local api = vim.api

--- @param x string
--- @return string?
local function match_require(x)
  return x:match 'require'
    and (
      x:match "require%s*%(%s*'([^.']+).*'%)"
      or x:match 'require%s*%(%s*"([^."]+).*"%)'
      or x:match "require%s*'([^.']+).*'%)"
      or x:match 'require%s*"([^."]+).*"%)'
    )
end
---
--- @param client vim.lsp.Client
--- @param bufnr integer
local function on_attach(client, bufnr)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
      -- Updates to settings are ingored if a .luarc.json is present
      return
    end
  end

  client.settings = vim.tbl_deep_extend('keep', client.settings, {
    Lua = { workspace = { library = {} } },
  })

  --- @param first? integer
  --- @param last? integer
  local function on_lines(first, last)
    local do_change = false

    local lines = api.nvim_buf_get_lines(bufnr, first or 0, last or -1, false)
    for _, line in ipairs(lines) do
      local m = match_require(line)
      if m then
        for _, mod in ipairs(vim.loader.find(m, { patterns = { '', '.lua' } })) do
          local lib = vim.fs.dirname(mod.modpath)
          local libs = client.settings.Lua.workspace.library
          if not vim.tbl_contains(libs, lib) then
            libs[#libs + 1] = lib
            do_change = true
          end
        end
      end
    end

    if do_change then
      client:notify('workspace/didChangeConfiguration', { settings = client.settings })
    end
  end

  api.nvim_buf_attach(bufnr, false, {
    on_lines = function(_, _, _, first, _, last)
      on_lines(first, last)
    end,
    on_reload = function()
      on_lines()
    end,
  })

  -- Initial scan
  on_lines()
end

---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
  },
  -- Note this is ignored if the project has a .luarc.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        pathStrict = true,
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/busted/library',
          '${3rd}/luv/library',
        },
      },
      diagnostics = {
        unusedLocalExclude = { '_*' },
        globals = {
          'it',
          'describe',
          'before_each',
          'after_each',
          'pending',
        },
      },
    },
  },
  on_attach = on_attach,
}
