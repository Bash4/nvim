-- File: after/plugin/colorscheme.lua

-- Define available colorschemes and their descriptions
local theme_options = {
  { name = "cyberdream", description = "A dark, cyberpunk-inspired theme with neon accents" },
  { name = "ashen", description = "A clean, minimalist dark theme with muted colors" },
  { name = "random", description = "Let fate decide - randomly selects between themes" }
}

-- Helper function to center text
local function center_text(str, width)
  local padding = width - #str
  if padding <= 0 then return str end
  local left = math.floor(padding / 2)
  return string.rep(" ", left) .. str .. string.rep(" ", padding - left)
end

-- Function to create themed menu
local function create_theme_menu()
  local width = 70  -- Increased width to accommodate descriptions
  local bufnr = vim.api.nvim_create_buf(false, true)
  
  -- Calculate centered position
  local ui = vim.api.nvim_list_uis()[1]
  local row = math.floor((ui.height - 8) / 2)  -- Reduced height
  local col = math.floor((ui.width - width) / 2)
  
  -- Set buffer content
  local content = {
    "┌" .. string.rep("─", width - 2) .. "┐",
    "│" .. center_text("Choose Your Theme", width - 2) .. "│",
    "│" .. string.rep(" ", width - 2) .. "│"
  }
  
  -- Add options
  for i, theme in ipairs(theme_options) do
    local entry = string.format("  %d. %-12s  %s", i, theme.name, theme.description)
    -- Ensure the line fits within the width
    if #entry > width - 4 then
      entry = entry:sub(1, width - 7) .. "..."
    end
    -- Pad the line to full width
    entry = entry .. string.rep(" ", width - 2 - #entry)
    table.insert(content, "│" .. entry .. "│")
  end
  
  -- Add footer
  table.insert(content, "│" .. string.rep(" ", width - 2) .. "│")
  local footer = "Press 1-" .. #theme_options .. " to select, or <Esc> to cancel"
  table.insert(content, "│" .. center_text(footer, width - 2) .. "│")
  table.insert(content, "└" .. string.rep("─", width - 2) .. "┘")
  
  -- Set content and options
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
  
  -- Create window
  local winnr = vim.api.nvim_open_win(bufnr, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = #content,
    style = 'minimal',
    border = 'none'
  })
  
  vim.api.nvim_win_set_option(winnr, 'winblend', 0)
  
  -- Set keymaps
  local opts = { noremap = true, silent = true }
  for i, theme in ipairs(theme_options) do
    vim.api.nvim_buf_set_keymap(bufnr, 'n', tostring(i), 
      string.format([[<cmd>lua ColorMyPencils('%s')<CR>]], theme.name) .. 
      '<cmd>close<CR>', opts)
  end
  
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc>', '<cmd>close<CR>', opts)
end

function ColorMyPencils(theme)
  -- Tell Neovim to use true colors
  vim.opt.termguicolors = true
  
  local chosen_scheme = theme
  
  -- Handle random selection
  if theme == "random" or not theme then
    math.randomseed(os.time()) -- Ensure true randomness
    -- Only select from actual themes, not "random"
    chosen_scheme = theme_options[math.random(#theme_options - 1)].name
  end
  
  -- Set the colorscheme
  local ok, _ = pcall(vim.cmd.colorscheme, chosen_scheme)
  
  if not ok then
    -- Fallback to a default colorscheme if the chosen one isn't available
    vim.notify("Couldn't load " .. chosen_scheme .. ", falling back to habamax", vim.log.levels.WARN)
    vim.cmd.colorscheme("habamax")
  else
    vim.notify("Using colorscheme: " .. chosen_scheme)
  end
end

-- Add command to change colorscheme
vim.api.nvim_create_user_command('Theme', function()
  create_theme_menu()
end, {})

-- Show menu on startup
vim.defer_fn(function()
  create_theme_menu()
end, 0)
