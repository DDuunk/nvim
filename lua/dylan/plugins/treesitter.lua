return {
  -- Vimscript syntax/indent plugins
  { "mustache/vim-mustache-handlebars", ft = { "mustache", "handlebars" } },
  { "MTDL9/vim-log-highlighting", ft = "log" },
  { "reasonml-editor/vim-reason-plus", ft = "reason" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      -- "Wansmer/treesj",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      -- tell treesitter to use the markdown parser for mdx files
      vim.treesitter.language.register("markdown", "mdx")

      configs.setup({
        ensure_installed = {
          "bash",
          "comment",
          "csv",
          "diff",
          "zig",
          "http",
          "json",
          "javascript",
          "typescript",
          "tsx",
          "toml",
          "yaml",
          "html",
          "css",
          "scss",
          "markdown",
          "markdown_inline",
          "angular",
          "svelte",
          "vue",
          "graphql",
          "bash",
          "lua",
          "dockerfile",
          "gitignore",
          "http",
          "query",
          "vim",
          "vimdoc",
          "rust",
          "go",
          "python",
          "scala",
          "terraform",
        },

        -- Install parsers synchronously (only used to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        indent = {
          enable = true,
          disable = { "python" },
        },

        -- Enable synxtax highlighting
        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        -- Enable autotaggins (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",
            node_incremental = "<CR>",
            scope_incremental = "grc",
            node_decremental = "<BS>",
          },
        },

        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ii"] = "@conditional.inner",
              ["ai"] = "@conditional.outer",
              ["il"] = "@loop.inner",
              ["al"] = "@loop.outer",
              ["at"] = "@comment.outer",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          lsp_interop = {
            enable = true,
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        },
      })

      local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
      --      local treesj = require("treesj")

      --     treesj.setup({})

      local keymap = vim.keymap

      -- Repeat movement with ; and ,
      -- ensure ; goes forward and , goes backward regardless of the last direction
      keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

      -- vim way: ; goes to the direction you were moving.
      -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
      keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

      keymap.set({ "n", "v" }, "<C-_>", "gcc", { remap = true })
      -- keymap.set({ "n", "v" }, "<CR>", "gnn", { remap = true })
      -- keymap.set({ "n", "v" }, "<CR>", "grn", { noremap = true, silent = true })
      -- keymap.set({ "n", "v" }, "<BS>", "grm", { remap = true })

      -- Keybindings for whole document selection
      keymap.set("n", "yig", ":%y<CR>", { noremap = true, silent = true })
      keymap.set("n", "vig", "ggVG", { noremap = true, silent = true })
      keymap.set("n", "dig", ":%d<CR>i", { noremap = true, silent = true })
    end,
  },
}
