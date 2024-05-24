local M = {}

function M.setup()
  local autocmd = vim.api.nvim_create_autocmd

  autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      vim.lsp.buf.format({ async = false })
    end,
  })
end

return M
