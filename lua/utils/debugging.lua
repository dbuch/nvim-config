local dev = os.getenv('DEBU')
if dev and dev == "1" then
  require('luadev').start()
  vim.api.nvim_command('wincmd H')
end
