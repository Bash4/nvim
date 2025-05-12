-- Flash: Fast navigation with search labels (enhanced f/t motions)
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- Label configuration
    label = {
      -- Whether to position the label at the beginning or end of the match
      position = "start", -- "start" or "end"
      -- Use uppercase labels for multi-character labels
      uppercase = true,
      -- Disable this to use pattern matching to place labels
      -- When false, labels are placed on the first character of each match
      before = true,
      -- By default, flash will search for the next character in the word
      -- If set to true, it will use the character after the cursor
      after = false,
      -- If `before = false`, the label matches only a pattern of characters.
      -- When increase_sequence is true, it will try to add more characters
      -- to that pattern to match more unique locations
      increase_sequence = false,
      -- Turns label rendering on or off 
      enabled = true,
      -- Style for the flash match locations
      style = "overlay", -- "eol", "overlay", "right_align", or "inline"
      -- Add a space before or after the label. Default is none
      space = { 0, 0 },
      -- Use the specified letter set for labels instead of the default
      rainbow = {
        enabled = false,
        -- number between 1 and 9
        shade = 5,
      },
      -- Enable operator-pending mappings
      -- Example: can use `srf` to surround with f motion
      -- or `drF` to delete to reverse F motion
      -- Useful with mini.surround, vim-surround, etc.
      operators = true,
      -- Highlight the searched text
      search = {
        -- Enabled by default
        enabled = true,
        -- Include the search in the match
        incremental = false,
      },
      -- Customize jump keys
      keys = {
        -- Use the default f/t/F/T jump labels
        jump = {
          "f",
          "F",
          "t",
          "T",
        },
        -- Different labels for remote jumps (normal search or treesitter)
        remote_jump = { "j", "k" },
        -- Remote operation (like yank)
        remote_op = { "J", "K" },
      },
    },
  },
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}