-- Cheatsheet: Display a popup with all your keybindings and features
return {
  "sudormrfbin/cheatsheet.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local cheatsheet = require("cheatsheet")
    
    cheatsheet.setup({
      -- Whether to show bundled cheatsheets
      bundled_cheatsheets = true,
      
      -- For plugin specific cheatsheets
      bundled_plugin_cheatsheets = true,
      
      -- Include only the most popular plugin cheatsheets
      include_only_installed_plugins = true,
      
      -- Key mappings bound by default to telescope
      telescope_mappings = {
        ['<CR>'] = require('cheatsheet.telescope.actions').select_or_fill_commandline,
        ['<A-CR>'] = require('cheatsheet.telescope.actions').select_or_execute,
        ['<C-Y>'] = require('cheatsheet.telescope.actions').copy_cheat_value,
        ['<C-E>'] = require('cheatsheet.telescope.actions').edit_user_cheatsheet,
      },
    })
    
    -- Create a custom cheatsheet for your own configs
    -- Add individual cheats for different sections

    -- File Navigation
    cheatsheet.add_cheat("Find file by name (Telescope)", "<leader>ff", "File Navigation")
    cheatsheet.add_cheat("Find content in files (Live Grep)", "<leader>fg", "File Navigation")
    cheatsheet.add_cheat("Browse open buffers", "<leader>fb", "File Navigation")
    cheatsheet.add_cheat("Recent files", "<leader>fr", "File Navigation")
    cheatsheet.add_cheat("Find word under cursor", "<leader>fw", "File Navigation")
    cheatsheet.add_cheat("Open Netrw file explorer", "<leader>pv", "File Navigation")
    cheatsheet.add_cheat("Open undo history (Telescope)", "<leader>u", "File Navigation")

    -- Git Commands
    cheatsheet.add_cheat("Open LazyGit", "<leader>lg", "Git Commands")
    cheatsheet.add_cheat("Toggle Git blame", "<leader>gb", "Git Commands")
    cheatsheet.add_cheat("Git status (Telescope)", "<leader>gs", "Git Commands")
    cheatsheet.add_cheat("Next hunk (GitSigns)", "]c", "Git Commands")
    cheatsheet.add_cheat("Previous hunk (GitSigns)", "[c", "Git Commands")
    cheatsheet.add_cheat("Stage hunk (GitSigns)", "<leader>hs", "Git Commands")
    cheatsheet.add_cheat("Reset hunk (GitSigns)", "<leader>hr", "Git Commands")
    cheatsheet.add_cheat("Stage buffer (GitSigns)", "<leader>hS", "Git Commands")
    cheatsheet.add_cheat("Preview hunk (GitSigns)", "<leader>hp", "Git Commands")

    -- LSP Commands
    cheatsheet.add_cheat("Go to definition", "<leader>gd", "LSP Commands")
    cheatsheet.add_cheat("Find references", "<leader>gr", "LSP Commands")
    cheatsheet.add_cheat("Show hover documentation", "K", "LSP Commands")
    cheatsheet.add_cheat("Code action", "<leader>ca", "LSP Commands")
    cheatsheet.add_cheat("Rename symbol", "<leader>rn", "LSP Commands")
    cheatsheet.add_cheat("Show diagnostics at cursor", "<leader>e", "LSP Commands")
    cheatsheet.add_cheat("Previous diagnostic", "[d", "LSP Commands")
    cheatsheet.add_cheat("Next diagnostic", "]d", "LSP Commands")

    -- Editing
    cheatsheet.add_cheat("Copy to system clipboard", "<leader>y", "Editing")
    cheatsheet.add_cheat("Copy line to system clipboard", "<leader>Y", "Editing")
    cheatsheet.add_cheat("Exit insert mode (like Escape)", ",,", "Editing")
    cheatsheet.add_cheat("Clear search highlighting", "<leader>h", "Editing")
    cheatsheet.add_cheat("Comment/uncomment current line", "gcc", "Editing")
    cheatsheet.add_cheat("Comment/uncomment selection (visual mode)", "gc", "Editing")
    cheatsheet.add_cheat("Add surrounding", "sa", "Editing")
    cheatsheet.add_cheat("Delete surrounding", "sd", "Editing")
    cheatsheet.add_cheat("Replace surrounding", "sr", "Editing")

    -- Terminal
    cheatsheet.add_cheat("Toggle terminal", "<C-\\>", "Terminal")
    cheatsheet.add_cheat("Toggle terminal", "<leader>tt", "Terminal")
    cheatsheet.add_cheat("Toggle floating terminal", "<leader>tf", "Terminal")
    cheatsheet.add_cheat("Toggle horizontal terminal", "<leader>th", "Terminal")
    cheatsheet.add_cheat("Toggle vertical terminal", "<leader>tv", "Terminal")
    cheatsheet.add_cheat("Toggle LazyGit terminal", "<leader>tg", "Terminal")
    cheatsheet.add_cheat("Toggle Node terminal", "<leader>tn", "Terminal")
    cheatsheet.add_cheat("Toggle PHP terminal", "<leader>tp", "Terminal")

    -- Navigation
    cheatsheet.add_cheat("Flash jump (enhanced f/t motion)", "s", "Navigation")
    cheatsheet.add_cheat("Flash treesitter jump", "S", "Navigation")
    cheatsheet.add_cheat("Previous buffer", "<S-h>", "Navigation")
    cheatsheet.add_cheat("Next buffer", "<S-l>", "Navigation")
    cheatsheet.add_cheat("Jump to buffer 1-5", "<leader>1-5", "Navigation")
    cheatsheet.add_cheat("Pick buffer", "<leader>bp", "Navigation")

    -- Diagnostics
    cheatsheet.add_cheat("Document diagnostics", "<leader>xx", "Diagnostics & Trouble")
    cheatsheet.add_cheat("Workspace diagnostics", "<leader>xX", "Diagnostics & Trouble")
    cheatsheet.add_cheat("Location list", "<leader>xL", "Diagnostics & Trouble")
    cheatsheet.add_cheat("Quickfix list", "<leader>xQ", "Diagnostics & Trouble")
    cheatsheet.add_cheat("LSP references", "gR", "Diagnostics & Trouble")

    -- Themes
    cheatsheet.add_cheat("Open theme selector", ":Theme", "Themes and UI")

    -- Cheatsheet
    cheatsheet.add_cheat("Open this cheatsheet", "<leader>cs", "Help")
    
    -- Keymap to open the cheatsheet (using <leader>cs to avoid conflict with which-key)
    vim.keymap.set('n', '<leader>cs', ':Cheatsheet<CR>', { noremap = true, silent = true, desc = 'Open cheatsheet' })
  end
}