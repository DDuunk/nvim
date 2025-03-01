return {
  -- "ibhagwan/fzf-lua",
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- opts = {},
  -- config = function()
  --   local fzf = require("fzf-lua")
  --   local config = fzf.config
  --   local actions = fzf.actions
  --   local keymap = vim.keymap
  --
  --   -- Quickfix
  --   config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
  --   config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
  --   config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
  --   config.defaults.keymap.fzf["ctrl-x"] = "jump"
  --   config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
  --   config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
  --   config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
  --   config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
  --
  --   fzf.setup({
  --     "default-title",
  --     fzf_colors = true,
  --     fzf_opts = {
  --       ["--no-scrollbar"] = true,
  --       ["--layout"] = "default",
  --     },
  --     defaults = {
  --       formatter = "path.dirname_first",
  --     },
  --     files = {
  --       cwd_prompt = false,
  --       actions = {
  --         ["alt-i"] = { actions.toggle_ignore },
  --         ["alt-h"] = { actions.toggle_hidden },
  --       },
  --     },
  --     grep = {
  --       actions = {
  --         ["alt-i"] = { actions.toggle_ignore },
  --         ["alt-h"] = { actions.toggle_hidden },
  --       },
  --     },
  --     lsp = {
  --       symbols = {
  --         symbol_hl = function(s)
  --           return "TroubleIcon" .. s
  --         end,
  --         symbol_fmt = function(s)
  --           return s:lower() .. "\t"
  --         end,
  --         child_prefix = false,
  --       },
  --       code_actions = {
  --         previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
  --       },
  --     },
  --   })
  --
  --   keymap.set("n", "<leader>pf", fzf.files, { desc = "FZF Files" })
  --   keymap.set("n", "<C-p>", fzf.git_files, { desc = "FZF Git Files" })
  --   keymap.set("n", "<C-g>", fzf.git_status, { desc = "FZF Git Status" })
  --   keymap.set("n", "<C-b>", fzf.git_commits, { desc = "FZF Git Commits" })
  --   keymap.set("n", "<leader>ps", fzf.grep, { desc = "FZF Grep" })
  --   keymap.set("n", "<leader>pws", fzf.grep_cword, { desc = "FZF Grep CWord" })
  --   keymap.set("n", "<leader>pWs", fzf.grep_cWORD, { desc = "FZF Grep CWORD" })
  --   keymap.set("n", "<leader>vh", fzf.help_tags, { desc = "FZF Help Tags" })
  -- end,
}
