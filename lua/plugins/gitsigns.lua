-- Gitsigns: Shows git change indicators in the sign column and provides hunks operations
return {
	"lewis6991/gitsigns.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		-- Navigation
		{ "]c", function() require("gitsigns").next_hunk() end, desc = "Next hunk" },
		{ "[c", function() require("gitsigns").prev_hunk() end, desc = "Previous hunk" },
		
		-- Actions
		{ "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage hunk" },
		{ "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset hunk" },
		{ "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "Stage buffer" },
		{ "<leader>hu", function() require("gitsigns").undo_stage_hunk() end, desc = "Undo stage hunk" },
		{ "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Reset buffer" },
		{ "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
		{ "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame line" },
		{ "<leader>tb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle line blame" },
		{ "<leader>hd", function() require("gitsigns").diffthis() end, desc = "Diff this" },
		{ "<leader>hD", function() require("gitsigns").diffthis("~") end, desc = "Diff against ~" },
		{ "<leader>td", function() require("gitsigns").toggle_deleted() end, desc = "Toggle deleted" },
		
		-- Text object
		{ "ih", ":<C-U>Gitsigns select_hunk<CR>", mode = { "o", "x" }, desc = "Select hunk" },
	},
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000,
		preview_config = {
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		yadm = {
			enable = false,
		},
	},
}
