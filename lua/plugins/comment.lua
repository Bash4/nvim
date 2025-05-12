-- Comment: Smart and efficient commenting for multiple languages
return {
  'numToStr/Comment.nvim',
  lazy = false,
  config = function()
    require('Comment').setup({
      -- Add support for various language commenting styles automatically
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      
      -- Toggle mappings
      -- Line comment: gcc (current line), gc (with motion)
      -- Block comment: gbc (current line), gb (with motion)
    })
    
    -- You can also add custom mappings if preferred
    -- vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'Comment line' })
    -- vim.keymap.set('v', '<leader>/', 'gc', { desc = 'Comment selection' })
  end,
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
}