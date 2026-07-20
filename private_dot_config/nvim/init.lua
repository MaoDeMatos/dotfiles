---
--- ˚ʚ♡ɞ˚ NeoVim config ˚ʚ♡ɞ˚
---

---
--- Dependencies
---

vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context', name = 'treesitter-context' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',         version = 'master' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/stevearc/conform.nvim' },
})

vim.api.nvim_create_user_command('UpdateDeps', function()
  vim.pack.update()
end, {})

---
--- Custom options
---

vim.g.mapleader = " "
require("options")


---
--- Core features
---

require("mini.basics").setup({
  options = {
    basic = true,
    extra_ui = true,
    win_borders = "bold",
  },
})
require("mini.completion").setup({
  window = {
    info = { border = "solid" },
    signature = { border = "solid" },
  },
})
require("mini.files").setup({
  mappings = {
    close = "<esc>",
  },
  windows = {
    preview = true,
    border = "rounded",
    width_preview = 80,
  },
})
-- require("mini.clue").setup() -- which-key

---
--- UI
---

require("mini.starter").setup({
  autoopen = true,
  items = {
    {
      {
        name = "Recent files",
        action = function() require("mini.extra").pickers.oldfiles() end,
        section = "Search"
      },
      {
        name = "Sessions",
        action = function() require("mini.sessions").select() end,
        section = "Search"
      }
    },
    require("mini.starter").sections.sessions(8, true),
    require("mini.starter").sections.recent_files(8, false, false),
    -- require("mini.starter").sections.recent_files(5, true, false),
  },
  header = function()
    local v = vim.version()
    local versionstring = string.format("\n v%d.%d.%d", v.major, v.minor, v.patch)
    --- Every "image" is an array with lines of chars
    local imageData = require("ascii/neovim").delta_corps_priest1
    -- local imageData = require("ascii/neovim").ansi_shadow
    return table.concat(imageData, "\n") .. versionstring
  end
})

require("mini.icons").setup()
require("mini.map").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.indentscope").setup({
  draw = {
    delay = 0,
    animation = require("mini.indentscope").gen_animation.none(),
  },
  symbol = "│"
})
-- require("mini.trailspace").setup()
require("mini.notify").setup()

--- Context aware sticky headers
vim.schedule(function()
  require("treesitter-context").setup({
    multiline_threshold = 1,
    mode = "topline",
    on_attach = function(buf)
      -- List of filetypes to disable
      local disabled_filetypes = { "markdown", "text", "csv" }
      local filetype = vim.bo[buf].filetype

      if vim.tbl_contains(disabled_filetypes, filetype) then
        return false
      end
      return true
    end,
  })
end)

---
--- New features
---

require("mini.pick").setup({
  mappings = {
    paste = '<C-S-v>',
  },
  window = {
    prompt_prefix = '   ',
  },
})
require("mini.extra").setup() --- extra pickers for mini.pick and some other additionnal features
require("mini.sessions").setup({
  autowrite = true,
  file = '', --- disable local session storage.
})
require("mini.snippets").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.jump").setup()
require("mini.git").setup()
require("mini.diff").setup()

---
--- Init configs after loading plugins
---

require("mappings")
require("autocmds")
require("theme")

---
--- Treesitter
---

vim.schedule(function()
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      'lua',
      'vim',
      'vimdoc',
      'html',
      'css',
      'javascript',
      'typescript',
      'python',
      'go',
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
  })
end)

---
--- LSP
---

-- Load LSP configs
vim.schedule(function()
  local servers = {
    "lua_ls",
    "html",
    "cssls",
    "ts_ls",
    "bashls",
    -- "pyright",
    "ty",
    "ruff",
  }

  vim.lsp.enable(servers)
end)

---
--- Formatter
---

vim.schedule(function()
  -- 'prettier' first so it uses the project's local dependency if present
  -- 'prettierd' is installed system-wide as fallback
  local prettier_config = { "prettier", "prettierd", stop_after_first = true }

  local options = {
    formatters_by_ft = {
      lua = { "stylua" },
      css = prettier_config,
      scss = prettier_config,
      less = prettier_config,
      html = prettier_config,
      markdown = prettier_config,
      yaml = prettier_config,
      json = prettier_config,
      jsonc = prettier_config,
      javascript = prettier_config,
      javascriptreact = prettier_config,
      typescript = prettier_config,
      typescriptreact = prettier_config,
      python = {
        -- Fix lint errors
        "ruff_fix",              -- Ruff linter (flake8)
        "ruff_format",           -- Ruff formatter (black)
        "ruff_organize_imports", -- Ruff import sorter (isort)
      },
    },

    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  }

  require('conform').setup(options)
end)

-- --- Test
--
-- later(function()
--   add({
--     source = "adelarsq/image_preview.nvim"
--   })
--
--   require("image_preview").setup({})
-- end)
