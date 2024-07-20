if not vim.fn.has("nvim-0.10") then
  error("fatal: minimum required Neovim version is 0.10")
  vim.api.nvim_command("cq1")
  return
end

vim.g.mapleader = " "

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Plugin Manager
require("dylan.lazy")

require("dylan.core.options")
require("dylan.core.keymaps")
require("dylan.core.autocmd")
