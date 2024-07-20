local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open parent directory" })

-- keymap.set({ "n", "v" }, "H", "^", { desc = "Move to start of line" })
-- keymap.set({ "n", "v" }, "L", "$", { desc = "Move to end of line" })

keymap.set({ "n", "v" }, "j", "gj", { desc = "Move down" })
keymap.set({ "n", "v" }, "k", "gk", { desc = "Move up" })

keymap.set("i", "jk", "<C-o>a", { desc = "Move one char to the right" })

-- Move block up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Keep window centered when going up/down
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "L", "o<ESC>")

-- Paste without overwriting register
keymap.set("x", "<leader>p", [["_dP]])
keymap.set("x", "p", [["_dP]])

keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank into " register' })
keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank into " register' })

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Get out of search
keymap.set({ "n", "v" }, "<ESC>", ":noh<CR>", { desc = "Get out of search" })

-- Get out Q
keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Rename symbol
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make executable
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Copy file path
keymap.set("n", "<leader>cf", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
