local plugins = {
  -- {
  --   "mfussenegger/nvim-lint",
  --   event = "VeryLazy",
  --   config = function()
  --     require "custom.configs.lint"
  --   end
  -- },
  {
    "christoomey/vim-tmux-navigator",
    lazy = false
  },
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.formatter"
    end
  },
  {
    "williamboman/mason.nvim",
    opts={
      ensure_installed={
        "prettier",
        "typescript-language-server",
        "html-lsp",
        "tailwindcss-language-server",
        "gopls",
        "ruby-lsp",
        "rubocop",
        "solargraph"
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
      -- Configure vim-fugitive as merge tool
      vim.cmd [[
        set diffopt+=vertical
        let g:fugitive_git_executable = 'git'
        autocmd FileType fugitive setlocal bufhidden=delete
      ]]
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    event = "BufReadPost",
    config = function()
      require "custom.configs.ufo"
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    dependencies = "nvim-treesitter",
    event = "BufWinEnter",
    config = function()
      require "custom.configs.accelerated-jk"
    end,
  },
  {
    "olexsmir/gopher.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      -- require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
return plugins
