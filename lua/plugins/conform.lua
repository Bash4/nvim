return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      -- PHP
      php = { 
        { "pint", condition = function(self, ctx)
          return vim.fn.filereadable(vim.fn.getcwd() .. "/vendor/bin/pint") == 1
        end },
      },
      
      -- JavaScript/TypeScript
      javascript = { 
        { "eslint_d", condition = function(self, ctx)
          return vim.fn.filereadable(ctx.dirname .. "/.eslintrc.js") == 1 
              or vim.fn.filereadable(ctx.dirname .. "/.eslintrc.json") == 1
        end },
        "prettier" -- fallback formatter
      },
      typescript = { "eslint_d", "prettier" },
      javascriptreact = { "eslint_d", "prettier" },
      typescriptreact = { "eslint_d", "prettier" },

      -- Other languages...
      lua = { "stylua" },
      python = { "black" },
      go = { "gofmt" },
    },
    formatters = {
      pint = {
        command = "vendor/bin/pint",
        args = { "--test" },
      },
      eslint_d = {
        command = "eslint_d",
        args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
      },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  },
}
