-- Tokyonight: A clean, dark theme inspired by Tokyo city lights
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins
  opts = {
    style = "storm", -- The theme comes in four styles: storm, moon, night, day
    transparent = false, -- Disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal`
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark", -- style for sidebars
      floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style
    hide_inactive_statusline = false, -- Enabling this option will hide inactive statuslines
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When true, section headers in the lualine theme will be bold
  },
}