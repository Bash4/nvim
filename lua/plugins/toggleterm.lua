-- Toggleterm: Persistent, floating terminal integration inside Neovim
return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
    
    -- Custom terminal functions - create specific terminals
    local Terminal = require('toggleterm.terminal').Terminal
    
    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })
    
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    
    -- Node terminal for JavaScript/TypeScript
    local node = Terminal:new({
      cmd = "node",
      hidden = true,
      direction = "horizontal",
    })
    
    function _NODE_TOGGLE()
      node:toggle()
    end
    
    -- PHP terminal for Laravel/PHP development
    local php = Terminal:new({
      cmd = "php -a",
      hidden = true,
      direction = "horizontal",
    })
    
    function _PHP_TOGGLE()
      php:toggle()
    end
    
    -- Key mappings for terminal toggles
    vim.keymap.set('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = 'Toggle LazyGit terminal' })
    vim.keymap.set('n', '<leader>tn', '<cmd>lua _NODE_TOGGLE()<CR>', { desc = 'Toggle Node terminal' })
    vim.keymap.set('n', '<leader>tp', '<cmd>lua _PHP_TOGGLE()<CR>', { desc = 'Toggle PHP terminal' })
    vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle terminal' })
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
    vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Toggle horizontal terminal' })
    vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal' })
  end,
}