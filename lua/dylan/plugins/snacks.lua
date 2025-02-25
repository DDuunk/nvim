return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    indent = {
      indent = { char = "┊" },
      scope = { enabled = false },
    },
    -- notifier = {
    --   enabled = true,
    --   timeout = 2000,
    --   style = "compact",
    --   width = { min = 35, max = 0.8 },
    --   height = { min = 1, max = 0.8 },
    -- },
    picker = {
      layout = { preset = "telescope" },
    },
  },
  keys = {
    -- {
    --   "<leader>pf",
    --   function()
    --     Snacks.picker.smart()
    --   end,
    --   desc = "Smart Find Files",
    -- },
    -- {
    --   "<C-p>",
    --   function()
    --     Snacks.picker.git_files()
    --   end,
    --   desc = "Find Git Files",
    -- },
    -- {
    --   "<C-g>",
    --   function()
    --     Snacks.picker.git_status()
    --   end,
    --   desc = "Git Status",
    -- },
    -- {
    --   "<C-b>",
    --   function()
    --     Snacks.picker.git_log()
    --   end,
    --   desc = "Git Log",
    -- },
    -- {
    --   "<leader>ps",
    --   function()
    --     Snacks.picker.grep()
    --   end,
    --   desc = "Grep",
    -- },
    -- {
    --   "<leader>pws",
    --   function()
    --     Snacks.picker.grep_word()
    --   end,
    --   desc = "Visual selection or word",
    --   mode = { "n", "x" },
    -- },
  },
  -- keys = {
  --   {
  --     "<leader>cz",
  --     function()
  --       Snacks.zen()
  --     end,
  --     desc = "Toggle Zen Mode",
  --   },
  -- },
  -- init = function()
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "VeryLazy",
  --     callback = function()
  --       -- Setup some globals for debugging (lazy-loaded)
  --       _G.dd = function(...)
  --         Snacks.debug.inspect(...)
  --       end
  --       _G.bt = function()
  --         Snacks.debug.backtrace()
  --       end
  --       vim.print = _G.dd -- Override print to use snacks for `:=` command
  --
  --       -- Create some toggle mappings
  --       Snacks.toggle.inlay_hints():map("<leader>uh")
  --       Snacks.toggle.indent():map("<leader>ug")
  --     end,
  --   })
  -- end,
}
