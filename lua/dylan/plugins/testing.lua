return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- 	"folke/trouble.nvim",
    -- Testing adapter dependencies
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
  },
  -- opts = {
  --   -- Can be a list of adapters like what neotest expects
  --   -- or a list of adapter names, or a tabble of adapter names,
  --   -- mapped to adapter configs. The adapter will then be automatically
  --   -- loaded with the config.
  --   adapters = {
  --     ['neotest-plenary'] = {},
  --     ['neotest-jest'] = {
  --       jestConfigFile = function()
  --         local file = vim.fn.expand '%:p'
  --         if string.find(file, '/packages/') then
  --           return string.match(file, '(.-/[^/]+/)src') .. 'jest.config.ts'
  --         end
  --         return vim.fn.getcwd() .. '/jest.config.ts'
  --       end,
  --       cwd = function()
  --         local file = vim.fn.expand '%:p'
  --         if string.find(file, '/packages/') then
  --           return string.match(file, '(.-/[^/]+/)src')
  --         end
  --         return vim.fn.getcwd()
  --       end,
  --     },
  --   },
  --   status = { virtual_text = true },
  --   output = { open_on_run = true },
  --   quickfix = {
  --     open = function()
  --       require('trouble').open { mode = 'quickfix', focus = false }
  --     end,
  --   },
  -- },
  config = function(_, opts)
    local neotest = require("neotest")

    -- register neotest virtual text
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    neotest.setup({
      adapters = {
        require("neotest-jest")({
          jestConfigFile = function(file)
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
            end

            return vim.fn.getcwd() .. "/jest.config.ts"
          end,
          -- jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")) .. " --watch",
          jest_test_discovery = false,
        }),
        require("neotest-vitest")({
          filter_dir = function(name, rel_path, root)
            return name ~= "node_modules"
          end,
        }),
        require("neotest-plenary").setup({
          -- this is my standard location for minimal vim rc
          -- in all my projects
          min_init = "./scripts/tests/minimal.vim",
        }),
      },
      discovery = {
        enabled = false,
      },
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>tt", function()
      neotest.run.run(vim.fn.expand("% "))
    end, { desc = "Run test file" })
    keymap.set("n", "<leader>tr", function()
      neotest.run.run(vim.loop.cwd())
    end, { desc = "Run nearest test" })
    keymap.set("n", "<leader>tT", function()
      neotest.run.run(vim.loop.cwd())
    end, { desc = "Run all test files" })
    keymap.set("n", "<leader>tl", function()
      neotest.run.run_last()
    end, { desc = "Run last test" })
    keymap.set("n", "<leader>tw", function()
      neotest.watch.toggle()
    end, { desc = "Toggle test watching" })
    keymap.set("n", "<leader>ts", function()
      neotest.summary.toggle()
    end, { desc = "Toggle test summary" })
    keymap.set("n", "<leader>to", function()
      neotest.output.open({ enter = true, auto_close = true })
    end, { desc = "Show test output" })
    keymap.set("n", "<leader>tO", function()
      neotest.output_panel.toggle()
    end, { desc = "Toggle test output Panel" })
    keymap.set("n", "<leader>tS", function()
      neotest.run.stop()
    end, { desc = "Stop testing" })

    --
    --   opts.consumers = opts.consumers or {}
    --   -- Refresh and auto close trouble after running tests
    --   ---@type neotest.Consumer
    --   opts.consumers.trouble = function(client)
    --     client.listeners.results = function(adapter_id, results, partial)
    --       if partial then
    --         return
    --       end
    --       local tree = assert(client:get_position(nil, { adapter = adapter_id }))
    --
    --       local failed = 0
    --       for pos_id, result in pairs(results) do
    --         if result.status == 'failed' and tree:get_key(pos_id) then
    --           failed = failed + 1
    --         end
    --       end
    --       vim.schedule(function()
    --         local trouble = require 'trouble'
    --         if trouble.is_open() then
    --           trouble.refresh()
    --           if failed == 0 then
    --             trouble.close()
    --           end
    --         end
    --       end)
    --       return {}
    --     end
    --   end
    --
    --   if opts.adapters then
    --     local adapters = {}
    --     for name, config in pairs(opts.adapters or {}) do
    --       if type(name) == 'number' then
    --         if type(config) == 'string' then
    --           config = require(config)
    --         end
    --         adapters[#adapters + 1] = config
    --       elseif config ~= false then
    --         local adapter = require(name)
    --         if type(config) == 'table' and not vim.tbl_isempty(config) then
    --           local meta = getmetatable(adapter)
    --           if adapter.setup then
    --             adapter.setup(config)
    --           elseif meta and meta.__call then
    --             adapter(config)
    --           else
    --             error('Adapter ' .. name .. ' does not support setup')
    --           end
    --         end
    --         adapters[#adapters + 1] = adapter
    --       end
    --     end
    --     opts.adapters = adapters
    --   end
    --
    --   neotest.setup(opts)
  end,
}
