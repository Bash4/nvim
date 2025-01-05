-- Needed for lazy setup
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Open NetRW file explorer' })
vim.g.maplocalleader = "\\"

-- Copy to Clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = 'Copy selection to system clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Copy line to system clipboard' })

-- Double tap comma to ESC
vim.keymap.set('i', ',,', '<Esc>', { desc = 'Exit insert mode' })

-- Hide the highlights
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { desc = 'Clear search highlights' })


-- Indentation settings
vim.opt.expandtab = true      -- Convert tabs to spaces
vim.opt.tabstop = 2          -- Number of spaces tabs count for
vim.opt.shiftwidth = 2       -- Size of an indent
vim.opt.softtabstop = 2      -- Number of spaces that a <Tab> counts for
vim.opt.smartindent = true   -- Insert indents automatically
vim.opt.autoindent = true    -- Good auto indent

-- Optional but recommended
vim.opt.breakindent = true   -- Maintain indent when wrapping lines
