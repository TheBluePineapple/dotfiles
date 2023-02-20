--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
-- local lvim = lvim
-- local vim = vim
vim.opt.guifont = "Hack Nerd Font Mono:h12"
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "dracula" --lunar
-- to disable icons and use a minimalist setup, change the following to false
lvim.use_icons = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorcolumn = true
vim.opt.colorcolumn = "80"

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here
	-- https://neovide.dev/configuration.html

	-- DISPLAY SETTINGS
	-- vim.opt.guifont = { "Source Code Pro", "h14" }
	-- vim.opt.linespace = 0
	-- vim.g.neovide_scale_factor = 1.0

	-- vim.g.neovide_floating_blur_amount_x = 2.0
	-- vim.g.neovide_floating_blur_amount_y = 2.0
	-- vim.g.neovide_transparency = 0.8
	vim.g.neovide_scroll_animation_length = 0.3
	--vim.g.neovide_hide_mouse_when_typing = false --already done with xbanish
	vim.g.neovide_underline_automatic_scaling = false --false or boolean
	vim.g.neovide_refresh_rate = 60 --limited by hardware(xrandr -q)
	vim.g.neovide_refresh_rate_idle = 5
	-- vim.g.neovide_no_idle = true --force neovide to redraw as much as possible
	vim.g.neovide_confirm_quit = true
	--vim.g.neovide_fullscreen = true
	--vim.g.neovide_remember_window_size = true
	vim.g.neovide_profiler = false --fps graph

	-- INPUT SETTINGS
	--vim.g.neovide_input_use_logo = false    -- true on macOS
	--vim.g.neovide_input_macos_alt_is_meta = false

	--CURSOR SETTINGS
	--vim.g.neovide_cursor_animation_length = 0.1 --time for anim in secA
	-- vim.g.neovide_cursor_trail_size = 0.8
	-- vim.g.neovide_cursor_antialiasing = true
	-- vim.g.neovide_cursor_animate_in_insert_mode = true
	-- vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_unfocused_outline_width = 0.125 -- cursor outline box when window unfocused
	-- vim.g.neovide_cursor_vfx_mode = "wireframe" -- railgun torpedo pixiedust sonicboom ripple wireframe ""(empty)
	-- vim.g.neovide_cursor_vfx_opacity = 200.0
	-- vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	-- vim.g.neovide_cursor_vfx_particle_density = 7.0
	-- vim.g.neovide_cursor_vfx_particle_speed = 10.0
	-- vim.g.neovide_cursor_vfx_particle_speed = 10.0 --railgun only
	-- vim.g.neovide_cursor_vfx_particle_curl = 1.0 --railgun only
end

require("lvim.lsp.manager").setup("emmet_ls")
require("colorizer").setup()
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- \ to :, Y to y$, for win create/resize splits,

-- switch to buf #(leader b f), del buf #(leader b e)
-- switch between tabs within vim, can also be done with <leader>bb and <leader>bn
lvim.keys.normal_mode["<Tab>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprev<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<leader>bgg"] = ":bfirst<cr>"
lvim.keys.normal_mode["<leader>b<S-g>"] = ":blast<cr>"
--attempt at closing all but active
-- lvim.keys.normal_mode["<leader>bdd"] = ":bufdo bd|e#|blast|bd<cr>"
-- lvim.keys.normal_mode["<leader>bdd"] = ":bufdo bd|e#|blast|BufferKill<cr>"
-- add your own keymapping
--lvim.keys.visual_mode["C-c"] = " :!xclip -f -sel clip<CR>"
--lvim.keys.normal_mode["C-S-v"] = " mz:-1r !xclip -o -sel clip<CR>`z"
--lvim.keys.insert_mode["C-S-v"] = " mz:-1r !xclip -o -sel clip<CR>`z"
vim.keymap.set("v", "<C-c>", " :!xclip -f -sel clip<CR>")
vim.keymap.set("i", "<C-S-v>", " mz:-1r !xclip -o -sel clip<CR>`z")
vim.keymap.set("n", "<C-S-v>", " mz:-1r !xclip -o -sel clip<CR>`z")

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":wq<cr>" --remapped from terminal control flow
lvim.keys.normal_mode["<C-S-q>"] = ":q!<cr>"
lvim.keys.insert_mode["jk"] = "<ESC>"
-- vim.cmd("set timeoutlen=300")
-- lvim.keys.insert_mode["kj"] = "<ESC>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"toml",
	"rust",
	"go",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
	"sumneko_lua",
	"jsonls",
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	--   { command = "gofmt", filetypes = {"go"}},
	{ command = "rustfmt", filetypes = { "rust" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "gofumpt", filetypes = { "go" } },
	{
		command = "prettier",
		filetypes = {
			"javascript",
			"typescript",
			"typescriptreact",
			"flow",
			"jsx",
			"json",
			"css",
			"scss",
			"less",
			"html",
			"vue",
			"angular",
			"graphql",
			"markdown",
			"yaml",
		},
	},

	--   { command = "black", filetypes = { "python" } },
	--   { command = "isort", filetypes = { "python" } },
	-- CONFIGURE PRETTIER
	--   {
	--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
	--     command = "prettier",
	--     ---@usage arguments to pass to the formatter
	--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
	--     extra_args = { "--print-with", "100" },
	--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
	--     filetypes = { "typescript", "typescriptreact" },
	--   },
})

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	--   { command = "flake8", filetypes = { "python" } },
	--   {
	--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
	--     command = "shellcheck",
	--     ---@usage arguments to pass to the formatter
	--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
	--     extra_args = { "--severity", "warning" },
	--   },
	{
		command = "eslint_d",
		filetypes = { "javascript" },
	},
	{
		command = "jsonlint",
		filetypes = { "json" },
	},
	{
		command = "selene",
		filetypes = { "lua" },
	},
	{
		command = "golangci-lint",
		filetypes = { "go" },
	},
	{
		command = "codespell",
		---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "javascript", "python", "lua", "rust", "go", "json", "toml", "yaml" },
	},
})

-- Additional Plugins
lvim.plugins = {
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"Mofiqul/dracula.nvim",
	},
	{
		"norcalli/nvim-colorizer.lua",
	},
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.json", "*.jsonc" },
	-- enable wrap mode for json files only
	command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "zsh",
	callback = function()
		-- let treesitter use bash highlight for zsh files as well
		require("nvim-treesitter.highlight").attach(0, "bash")
	end,
})
