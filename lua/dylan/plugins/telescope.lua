return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    -- "folke/todo-comments.nvim",
    -- "someone-stole-my-name/yaml-companion.nvim",
  },
  config = function()
    local actions = require("telescope.actions")
    local trouble_telescope = require("trouble.sources.telescope")

    local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

    -- I want to search hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search inside `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    require("telescope").setup({
      defaults = {
        path_display = { "truncate" },
        vimgrep_arguments = vimgrep_arguments,
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-t>"] = trouble_telescope.open,
          },
          n = {
            ["<C-t>"] = trouble_telescope.open,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--no-config", "--files", "--hidden", "--glob", "!**/.git/*", "--sortr=modified" },
        },
      },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("advanced_git_search")

    local keymap = vim.keymap
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>pf", builtin.find_files, {})
    keymap.set("n", "<C-p>", builtin.git_files, {})
    keymap.set("n", "<C-g>", function()
      builtin.git_status()
    end)
    keymap.set("n", "<C-b>", builtin.git_commits, {})
    keymap.set("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)
    keymap.set("n", "<leader>pws", function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
    keymap.set("n", "<leader>pWs", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)
    keymap.set("n", "<leader>vh", builtin.help_tags, {})
    keymap.set("n", "<leader>pi", "<cmd>AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
    keymap.set("n", "<leader>ep", function()
      builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
    end)
  end,
}
