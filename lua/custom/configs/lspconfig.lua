local config = require("plugins.configs.lspconfig")
local on_attach = config.on_attach
local capabilities = config.capabilities
local gofmt = require("custom.configs.goformat")

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  },
}

lspconfig.gopls.setup {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    gofmt.setup()
  end,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go","gomod","gowork","gotmpl"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      gofumpt = true,
      analyses = {
        unusedparams = true,
        unusedvariable = true,
        unreachable = true
      }
    },
  },
}

lspconfig.ruby_ls.setup({
  on_attach = function(client, buffer)
    Setup_ruby_diagnostics(client, buffer)
  end,
})

-- lspconfig.rubocop.setup({
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr)
--     vim.opt.signcolumn = "yes"
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = "ruby",
--       callback = function()
--         vim.lsp.start {
--           name = "rubocop",
--           cmd = { "bundle", "exec", "rubocop", "--lsp" },
--         }
--       end,
--     })
--
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       pattern = "*.rb",
--       callback = function()
--         vim.lsp.buf.format()
--       end,
--     })
--   end,
--   capabilities = capabilities,
--   filetypes = { "ruby" },
--   init_options = {
--     command = { "rubocop" },
--     formatCommand = { "rubocop", "--auto-correct", "--stdin", "%" },
--     lintCommand = { "rubocop", "--format", "emacs", "--stdin", "%" },
--   },
--   root_dir = lspconfig.util.root_pattern(".rubocop.yml",".git")
-- })
--

lspconfig.solargraph.setup({
  on_attach = function (client,bufnr)
    on_attach(client,bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rb",
      callback = function()
        vim.lsp.buf.format()
      end,
    })

  end,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern('.solargraph.yml')
})

lspconfig.tailwindcss.setup {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
  root_dir = lspconfig.util.root_pattern("tailwind.config.js", "package.json"),
  settings = {},
}
