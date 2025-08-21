return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { 
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim"
	},
	config = function()
		-- Require telescope and builtin at the start
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")
		
		-- Setup telescope with custom configuration
		telescope.setup {
			defaults = {
				theme = "center",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.3,
					},
				},
			},
		}
		
		-- Load telescope-file-browser extension
		telescope.load_extension("file_browser")
		-- The actual keymaps
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
		vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find Word" })
		vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Marks" })
		vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
		vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
		vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
		vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git Status" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
		
		-- Telescope file browser keymaps
		vim.keymap.set("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "File Explorer" })
		vim.keymap.set("n", "<leader>fE", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "File Explorer (current buffer dir)" })

		-- I removed the projects mapping as it requires additional setup
	end,
}