local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "L", "o<ESC>")

keymap.set("x", "<leader>p", [["_dP]])

keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Telescope
local builtin = require("telescope.builtin")

keymap.set("n", "<leader>pf", builtin.find_files, {})
keymap.set("n", "<C-p>", builtin.git_files, {})
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
keymap.set("n", "<leader>u", ":Telescope undo<CR>", {})

-- Nvim Tree
-- keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", {
--   noremap = true,
-- })

-- Lspconfig
keymap.set("n", "gd", vim.lsp.buf.definition, {})
keymap.set("n", "K", vim.lsp.buf.hover, {})
keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, {})
keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
keymap.set("n", "[d", vim.diagnostic.goto_next, {})
keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, {})
keymap.set("n", "<leader>vrr", vim.lsp.buf.references, {})
keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, {})
keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})

-- None-ls
keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

-- Comment
keymap.set({ "n", "v" }, "<C-_>", "gcc", { remap = true })

-- Harpoon
local harpoon = require("harpoon")

keymap.set("n", "<leader>a", function()
  harpoon:list():append()
end)

-- keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
-- keymap.set("n", "<C-S-P>", function()
-- harpoon:list():prev()
-- end)
-- keymap.set("n", "<C-S-N>", function()
-- harpoon:list():next()
-- end)
