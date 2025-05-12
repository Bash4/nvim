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
  local width = 80  -- Increased width to accommodate descriptions
  local bufnr = vim.api.nvim_create_buf(false, true)
  
  -- Calculate centered position
  local ui = vim.api.nvim_list_uis()[1]
  local max_height = math.min(#theme_options + 6, 20)  -- Limit height
  local row = math.floor((ui.height - max_height) / 2)
  local col = math.floor((ui.width - width) / 2)
  
  -- Set buffer content
  local content = {
    "╭" .. string.rep("─", width - 2) .. "╮",
    "│" .. center_text("✨ Choose Your Theme ✨", width - 2) .. "│",
    "│" .. string.rep("─", width - 2) .. "│"
  }
  
  -- Add options in columns if we have many themes
  if #theme_options > 6 then
    local half = math.ceil(#theme_options / 2)
    for i = 1, half do
      local left_theme = theme_options[i]
      local right_theme = theme_options[i + half]
      local left_entry = string.format("  %2d. %-12s  %-30s", i, left_theme.name, left_theme.description:sub(1, 30))
      
      local line = left_entry
      if right_theme then
        local right_entry = string.format("  %2d. %-12s  %-30s", i + half, right_theme.name, right_theme.description:sub(1, 30))
        local padding = width - 2 - #left_entry - #right_entry
        if padding > 0 then
          line = left_entry .. string.rep(" ", padding) .. right_entry
        else
          line = left_entry
        end
      end
      
      -- Ensure the line fits within the width
      if #line > width - 4 then
        line = line:sub(1, width - 7) .. "..."
      end
      -- Pad the line to full width
      line = line .. string.rep(" ", width - 2 - #line)
      table.insert(content, "│" .. line .. "│")
    end
  else
    -- Original single column layout for fewer themes
    for i, theme in ipairs(theme_options) do
      local entry = string.format("  %2d. %-12s  %s", i, theme.name, theme.description)
      -- Ensure the line fits within the width
      if #entry > width - 4 then
        entry = entry:sub(1, width - 7) .. "..."
      end
      -- Pad the line to full width
      entry = entry .. string.rep(" ", width - 2 - #entry)
      table.insert(content, "│" .. entry .. "│")
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

-- Add transparency settings to the ColorMyPencils function
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

  -- Add transparency settings
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
end

-- Add command to change colorscheme
vim.api.nvim_create_user_command('Theme', function()
  create_theme_menu()
end, {})

-- Show menu on startup
vim.defer_fn(function()
  create_theme_menu()
end, 0)
