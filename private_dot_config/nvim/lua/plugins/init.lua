return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      require "configs.none-ls"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        -- "prettier",
        "prettierd",
        "pyre", -- Python type checker
        "ruff",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "python",
      },
    },
  },

  -- {
  --   "kylechui/nvim-surround",
  --   event = "VeryLazy",
  --   opts = {},
  -- },

  {
    "echasnovski/mini.surround",
    version = "*",
    -- event = "BufReadPost", -- lazy-load on buffer read
    keys = {
      { "sa", mode = { "n", "v" }, desc = "Add surrounding" },
      { "sd", desc = "Delete surrounding" },
      { "sr", desc = "Replace surrounding" },
      { "sf", desc = "Find surrounding" },
      { "sF", desc = "Find surrounding left" },
      { "sh", desc = "Highlight surrounding" },
      { "sn", desc = "Update n_lines" },
    },
    config = function()
      require("mini.surround").setup()
    end,

    -- opts = {
    --   mappings = {
    --     add = "sa", -- Add surrounding in Normal and Visual modes
    --     delete = "sd", -- Delete surrounding
    --     replace = "sr", -- Replace surrounding
    --     find = "sf", -- Find surrounding (to the right)
    --     find_left = "sF", -- Find surrounding (to the left)
    --     highlight = "sh", -- Highlight surrounding
    --     update_n_lines = "sn", -- Update `n_lines`
    --     -- You can change or disable mappings by assigning different keys or <Nop>
    --   },
    -- },
  },
}
