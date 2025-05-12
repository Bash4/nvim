-- Blame: Displays git blame information for the current line in a virtual text column
return {
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
      
      -- Add keybinding for BlameToggle
      vim.keymap.set('n', '<leader>gb', ':BlameToggle<CR>', { noremap = true, silent = true, desc = 'Toggle git blame' })
    end,
  },
}
