local fn = vim.fn
local lastplace = {
  options = {},
}

lastplace.set_default_option = function(option, default)
  -- Coalesce boolean options to integer 0 or 1
  if type(lastplace.options[option]) == 'boolean' then
    lastplace.options[option] = lastplace.options[option] and 1 or 0
  end

  -- Set option to either the option value or the default
  lastplace.options[option] = lastplace.options[option]
    or (vim.g.nvim_lastplace and vim.g.nvim_lastplace[option])
    or default
end

local set_cursor_position = function()
  local last_line = fn.line([['"]])
  local buff_last_line = fn.line('$')
  local window_last_line = fn.line('w$')
  local window_first_line = fn.line('w0')
  -- If the last line is set and the less than the last line in the buffer
  if last_line > 0 and last_line <= buff_last_line then
    -- Check if the last line of the buffer is the same as the window
    if window_last_line == buff_last_line then
      -- Set line to last line edited
      vim.api.nvim_command([[keepjumps normal! g`"]])
      -- Try to center
    elseif buff_last_line - last_line > ((window_last_line - window_first_line) / 2) - 1 then
      vim.api.nvim_command([[keepjumps normal! g`"zz]])
    else
      vim.api.nvim_command([[keepjumps normal! G'"<c-e>]])
    end
  end
  ---@diagnostic disable-next-line: param-type-mismatch
  if fn.foldclosed('.') ~= -1 and lastplace.options.lastplace_open_folds == 1 then
    vim.api.nvim_command([[normal! zvzz]])
  end
end

function lastplace.lastplace_ft(buffer)
  -- Check if the buffer should be ignored
  if vim.tbl_contains(lastplace.options.lastplace_ignore_buftype, vim.api.nvim_buf_get_option(buffer, 'buftype')) then
    return
  end

  -- Check if the filetype should be ignored
  if vim.tbl_contains(lastplace.options.lastplace_ignore_filetype, vim.api.nvim_buf_get_option(buffer, 'filetype')) then
    -- reset cursor to first line
    vim.api.nvim_command([[normal! gg]])
    return
  end

  -- If a line has already been set by the BufReadPost event or on the command
  -- line, we are done.
  if fn.line('.') > 1 then
    return
  end

  -- This shouldn't be reached but, better have it ;-)
  set_cursor_position()
end

return lastplace
