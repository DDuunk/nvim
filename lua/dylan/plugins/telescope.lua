return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    'nvim-tree/nvim-web-devicons',
    "jonarrien/telescope-cmdline.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    -- "debugloop/telescope-undo.nvim",
    "axkirillov/easypick.nvim",
    "folke/todo-comments.nvim",
  },
  -- keys = {
  --   { ":", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
  -- },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.sources.telescope")

    local custom_actions = transform_mod({
      open_trouble_qflist = function(prompt_bufnr)
        trouble.toggle("quickfix")
      end,
    })

    telescope.setup({
      defaults = {
        path_display = { "truncate" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            ["<C-t>"] = trouble_telescope.open
          },
          n = {
            ["<C-t>"] = trouble_telescope.open
          }
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
      extensions = {
        -- ["cmdline"] = {
        --   picker = {
        --     layout_config = {
        --       width = 0.8,
        --       height = 25,
        --     },
        --   },
        -- },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      },
    })

    -- require("telescope").load_extension("cmdline")
    require("telescope").load_extension("ui-select")
    -- require("telescope").load_extension("undo")

    local keymap = vim.keymap

    keymap.set("n", "<leader>pf", builtin.find_files, {})
    keymap.set("n", "<C-p>", builtin.git_files, {})
    keymap.set("n", "<C-g>", function()
      builtin.git_status()
    end)
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
  end,
}
