-- Laravel: Framework-specific tools for navigating and working with Laravel PHP projects
-- In ~/.config/nvim/lua/plugins/laravel.lua
return {
  "noahfrederick/vim-laravel",
  -- Laravel framework integration for Vim/Neovim
  -- Provides commands for navigating and working with Laravel projects
  lazy = false,
  dependencies = {
    "tpope/vim-dispatch",
    "tpope/vim-projectionist",
    "noahfrederick/vim-composer",
  },
  config = function()
    -- Set up projectionist for Laravel projects
    vim.g.projectionist_heuristics = {
      artisan = {
        ["app/*.php"] = {type = "source"},
        ["app/Http/Controllers/*.php"] = {type = "controller"},
        ["app/Models/*.php"] = {type = "model"},
        ["database/migrations/*.php"] = {type = "migration"},
        ["resources/views/*.blade.php"] = {type = "view"},
      }
    }
    
    -- Laravel-specific keybindings
    vim.keymap.set('n', '<leader>la', ':Artisan<Space>', { noremap = true, desc = 'Run Artisan command' })
    vim.keymap.set('n', '<leader>lr', ':Artisan route:list<CR>', { noremap = true, desc = 'Show routes' })
    vim.keymap.set('n', '<leader>lm', ':Artisan migrate<CR>', { noremap = true, desc = 'Run migrations' })
  end,
}
