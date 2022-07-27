local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('fzf')
telescope.load_extension("live_grep_args")

telescope.setup {
	defaults = {
		previewer = false,
		layout_strategy = "bottom_pane", -- Puts the window at the bottom
		layout_config = {
			prompt_position = "bottom", -- Puts the cursor at the bottom of the window
			height = 0.3
		},
		mappings = {
			i = { ["<esc>"] = actions.close } -- Close on escape
		}
	},
	pickers = {
		find_files = {
			previewer = false,
		},
		buffers = {
			sort_lastused = true,
			mappings = {
				i = { ["<c-d>"] = require("telescope.actions").delete_buffer },
				n = { ["<c-d>"] = require("telescope.actions").delete_buffer }
			}
		}
	}
}
