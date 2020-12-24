local dev = os.getenv('DEBUG')
if dev and dev == "1" then
  require('luadev').start()
  vim.api.nvim_command('wincmd H')
end
