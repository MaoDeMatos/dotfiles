require "nvchad.autocmds"

-- Set working directory to the current file's directory on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("SetWorkingDir", { clear = true }),
  callback = function()
    -- Get the full path
    local file_dir = vim.fn.expand "%:p:h"
    if file_dir ~= "" then
      -- Use the buffer-local 'lcd' equivalent
      vim.cmd("lcd " .. file_dir)
    end
  end,
})
