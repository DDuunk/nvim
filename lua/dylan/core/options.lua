local opt = vim.opt

-- Cursor
opt.guicursor = ""

-- Line numbers
opt.nu = true
opt.relativenumber = true

-- Tabs & indentation
opt.softtabstop = 2
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- opt.autoindent = true
opt.smartindent = true

-- Line wrappin
-- opt.textwidth = 0
-- opt.wrapmargin = 0
-- opt.wrap = true
-- opt.linebreak = true
-- opt.columns = 80
opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.isfname:append("@-@")

opt.colorcolumn = "80"
