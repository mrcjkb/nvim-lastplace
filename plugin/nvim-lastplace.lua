local lastplace = require('nvim-lastplace')

-- Set defaults
lastplace.set_default_option('ignore_buftype', { 'quickfix', 'nofile', 'help' })
lastplace.set_default_option('ignore_filetype', { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' })
lastplace.set_default_option('open_folds', 1)

local group_name = 'NvimLastplace'
vim.api.nvim_create_augroup(group_name, { clear = true })
vim.api.nvim_create_autocmd('BufRead', {
  group = group_name,
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      group = group_name,
      buffer = opts.buf,
      callback = function()
        lastplace.lastplace_ft(opts.buf)
      end,
    })
  end,
})
