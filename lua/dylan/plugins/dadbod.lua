return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "pbogut/vim-dadbod-ssh", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_default_query = 'select * from "{table}" limit 10'

    vim.g.dbs = {
      {
        name = "powerd-platform-dev",
        url = "ssh://ec2-user@i-055a92c755162368e.powerd-platform-dev.ssm:postgres://smiling_oyster:W3N1SlCo9qZYuRtl@dev-powerd-shared.cluster-cnt00ldzzcs3.eu-central-1.rds.amazonaws.com/postgres",
      },
    }
  end,
}

-- "tpope/vim-dadbod",
-- dependencies = {
-- 	"pbogut/vim-dadbod-ssh",
-- 	"kristijanhusak/vim-dadbod-ui",
-- 	"kristijanhusak/vim-dadbod-completion",
-- },
-- config = function()
-- 	vim.g.db_ui_use_nerd_fonts = 1
--
-- 	-- vim.g.dbs = {
-- 	-- { name = "dev", url = "postgres://postgres:mypassword@localhost:5432/my-dev-db" },
-- 	-- { name = "staging", url = "postgres://postgres:mypassword@localhost:5432/my-staging-db" },
-- 	-- }
--
-- 	vim.g.dbs = {
-- 		dev = "postgres://postgres:mypassword@localhost:5432/my-dev-db",
-- 		staging = "postgres://postgres:mypassword@localhost:5432/my-staging-db",
-- 		wp = "mysql://root@localhost/wp_awesome",
-- 	}
-- end,
-- }
