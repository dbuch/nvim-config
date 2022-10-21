local ok, impatient = pcall(require, 'impatient')
if ok then
  impatient.enable_profile()
else
  vim.notify("please boot strap impatient plugin")
end

require'dbuch'
