-- File: after/plugin/colorscheme.lua

-- Define available colorschemes and their descriptions
local theme_options = {
  { name = "cyberdream", description = "A dark, cyberpunk-inspired theme with neon accents" },
  { name = "ashen", description = "A clean, minimalist dark theme with muted colors" },
  { name = "tokyonight", description = "A clean, dark theme inspired by Tokyo city lights" },
  { name = "catppuccin", description = "Soothing pastel theme for high contrast and readability" },
  { name = "kanagawa", description = "Dark theme inspired by traditional Japanese aesthetics" },
  { name = "gruvbox", description = "Retro groove color scheme with warm, earthy tones" },
  { name = "nord", description = "Arctic, north-bluish clean and elegant theme" },
  { name = "nightfox", description = "Cool-toned, clean and elegant dark theme" },
  { name = "dracula", description = "Dark theme with vibrant, high-contrast colors" },
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
  -- Use a single-column layout with plenty of width for full descriptions
  local width = 120
  local bufnr = vim.api.nvim_create_buf(false, true)
  
  -- Calculate centered position
  local ui = vim.api.nvim_list_uis()[1]
  local max_height = math.min((#theme_options * 2) + 6, 25)  -- Increased height for spacing
  local row = math.floor((ui.height - max_height) / 2)
  local col = math.floor((ui.width - width) / 2)
  
  -- Set buffer content
  local content = {
    "╭" .. string.rep("─", width - 2) .. "╮",
    "│" .. center_text("✨ Choose Your Theme ✨", width - 2) .. "│",
    "│" .. string.rep("─", width - 2) .. "│"
  }
  
  -- Simple single-column layout with full descriptions
  for i, theme in ipairs(theme_options) do
    -- Format with adequate spacing between number, name, and description
    local entry = string.format("  %2d.  %-15s  %s", i, theme.name, theme.description)
    
    -- Ensure the entry fits within width
    if #entry > width - 4 then
      entry = entry:sub(1, width - 7) .. "..."
    end
    
    -- Pad the line to full width for consistent display
    entry = entry .. string.rep(" ", width - 2 - #entry)
    table.insert(content, "│" .. entry .. "│")
    
    -- Add a small separator between themes for better readability
    if i < #theme_options then
      table.insert(content, "│" .. string.rep(" ", width - 2) .. "│")
    end
  end
  
  -- Add footer
  table.insert(content, "│" .. string.rep("─", width - 2) .. "│")
  local footer = "Press 1-" .. #theme_options .. " to select, or <Esc> to cancel"
  table.insert(content, "│" .. center_text(footer, width - 2) .. "│")
  table.insert(content, "╰" .. string.rep("─", width - 2) .. "╯")
  
  -- Set content and options
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
  vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
  vim.api.nvim_buf_set_option(bufnr, 'bufhidden', 'wipe')
  vim.api.nvim_buf_set_option(bufnr, 'buftype', 'nofile')
  
  -- Create floating window with border
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
  
  -- Add keymaps for numbers > 9
  if #theme_options > 9 then
    -- Create two-digit keymaps (10-99)
    for i = 10, #theme_options do
      local first_digit = math.floor(i / 10)
      local second_digit = i % 10
      
      -- Create key sequence for two-digit number
      vim.api.nvim_buf_set_keymap(bufnr, 'n', tostring(first_digit) .. tostring(second_digit),
        string.format([[<cmd>lua ColorMyPencils('%s')<CR>]], theme_options[i].name) ..
        '<cmd>close<CR>', opts)
    end
  end
  
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Esc>', '<cmd>close<CR>', opts)
end

-- Enhanced ColorMyPencils function with improved theme switching
function ColorMyPencils(theme)
  -- Tell Neovim to use true colors
  vim.opt.termguicolors = true
  
  local chosen_scheme = theme
  
  -- Handle random selection
  if theme == "random" or not theme then
    math.randomseed(os.time()) -- Ensure true randomness
    -- Only select from actual themes, not "random"
    local valid_themes = {}
    for i, t in ipairs(theme_options) do
      if t.name ~= "random" then
        table.insert(valid_themes, t.name)
      end
    end
    chosen_scheme = valid_themes[math.random(#valid_themes)]
    vim.notify("Random theme selected: " .. chosen_scheme, vim.log.levels.INFO)
  end
  
  -- Reset any previously applied highlights before changing theme
  vim.cmd("hi clear")
  
  -- Set the colorscheme
  local ok, err = pcall(vim.cmd.colorscheme, chosen_scheme)
  
  if not ok then
    -- Provide more detailed error message when theme fails to load
    vim.notify(
      "Couldn't load theme '" .. chosen_scheme .. "': " .. (err or "Unknown error") ..
      "\nFalling back to default theme.",
      vim.log.levels.WARN
    )
    pcall(vim.cmd.colorscheme, "habamax")
  else
    -- Save the chosen theme in a global variable for persistence
    vim.g.last_colorscheme = chosen_scheme
    
    -- Success notification with nice formatting
    vim.defer_fn(function()
      local theme_info = ""
      for _, t in ipairs(theme_options) do
        if t.name == chosen_scheme then
          theme_info = t.description
          break
        end
      end
      
      vim.notify(
        "Theme: " .. chosen_scheme ..
        (theme_info ~= "" and "\n" .. theme_info or ""),
        vim.log.levels.INFO
      )
    end, 100) -- Slight delay for better UX
  end

  -- Apply transparency settings if enabled
  if vim.g.enable_transparency then
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  end
end

-- Add command to change colorscheme
vim.api.nvim_create_user_command('Theme', function()
  create_theme_menu()
end, {})

-- Initialize transparency setting (default: enabled)
vim.g.enable_transparency = true

-- Add commands for transparency control
vim.api.nvim_create_user_command('TransparencyOn', function()
  vim.g.enable_transparency = true
  -- Reapply current theme to update transparency
  ColorMyPencils(vim.g.last_colorscheme or "random")
  vim.notify("Transparency enabled", vim.log.levels.INFO)
end, {})

vim.api.nvim_create_user_command('TransparencyOff', function()
  vim.g.enable_transparency = false
  -- Reapply current theme to update transparency
  ColorMyPencils(vim.g.last_colorscheme or "random")
  vim.notify("Transparency disabled", vim.log.levels.INFO)
end, {})

-- Add command to restore last theme
vim.api.nvim_create_user_command('ThemeRestore', function()
  if vim.g.last_colorscheme then
    ColorMyPencils(vim.g.last_colorscheme)
  else
    vim.notify("No previous theme found", vim.log.levels.WARN)
  end
end, {})

-- Show menu on startup
vim.defer_fn(function()
  create_theme_menu()
end, 100) -- Small delay for better startup experience