local gitsigns = require('gitsigns')

gitsigns.setup {
  debug_mode = false,
  max_file_length = 1000000000,
  signs = {
    add          = { show_count = false },
    change       = { show_count = false },
    delete       = { show_count = true },
    topdelete    = { show_count = true },
    changedelete = { show_count = true },
  },
  preview_config = {
    border = 'rounded',
  },
  count_chars = {
    '⒈', '⒉', '⒊', '⒋', '⒌', '⒍', '⒎', '⒏', '⒐',
    '⒑', '⒒', '⒓', '⒔', '⒕', '⒖', '⒗', '⒘', '⒙', '⒚', '⒛',
  },
  update_debounce = 50,
  _extmark_signs = true,
  _threaded_diff = true,
  word_diff = true,
}
