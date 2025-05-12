-- Mini-surround: Fast and feature-rich surround actions for text objects
return {
  'echasnovski/mini.surround',
  version = '*',
  config = function()
    require('mini.surround').setup({
      -- Add custom surroundings to be used with standard mappings
      -- Example: surrounding with LaTeX commands like \textbf{text}
      custom_surroundings = {
        -- Custom surroundings for LaTeX
        L = {
          input = { '%[[\\](%a+){%s*(.-)%s*}%]', '%[\\(%a+){(.-)%s*}%]' },
          output = { left = '\\%s{', right = '}' },
        },
      },
      
      -- Duration (in ms) of highlight groups when creating, updating, deleting
      highlight_duration = 500,
      
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = 'sa', -- Add surrounding in Normal and Visual modes
        delete = 'sd', -- Delete surrounding
        find = 'sf', -- Find surrounding (to the right)
        find_left = 'sF', -- Find surrounding (to the left)
        highlight = 'sh', -- Highlight surrounding
        replace = 'sr', -- Replace surrounding
        update_n_lines = 'sn', -- Update `n_lines`
      },
      
      -- Number of lines within which surrounding is searched
      n_lines = 20,
      
      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). Each element of array should be 'cover', 'cover_or_next',
      -- 'cover_or_prev', 'cover_or_nearest', 'next', 'prev', 'nearest'.
      search_method = 'cover_or_next',
      
      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,
    })
    
    -- Remap keybinding for adding surroundings to visual selection to make it closer
    -- to how other surround plugins work
    vim.api.nvim_set_keymap('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
  end,
}