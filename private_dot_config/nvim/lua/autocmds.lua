--- Set working directory to the current file's directory on startup
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  group = vim.api.nvim_create_augroup("SetWorkingDir", { clear = true }),
  callback = function()
    --- Get the full path
    local file_dir = vim.fn.expand("%:p:h")

    --- Prevents function execution if executed without a path arg
    if string.sub(file_dir, 1, #"ministarter") == "ministarter" then
      return
    end

    --- Set vim root dir (mainly for find commands/file explorer)
    if file_dir ~= "" then
      --- Use the buffer-local 'lcd' equivalent
      vim.cmd("lcd " .. file_dir)
    end
  end,
})

--- Disable line numbers in Terminals
vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

--- Automatically close terminal Buffers when their Process is done
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete")
  end
})

--- Open mini map automatically when selecting using mini.starter
local opts = vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniStarterOpened',
    callback = function()
      local rhs = function()
        require("mini.starter").eval_current_item()
        require("mini.map").open()
      end
      vim.keymap.set('n', '<CR>', rhs, { buffer = true })
    end,
  }
)
