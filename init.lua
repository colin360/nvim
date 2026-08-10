vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Enable whitespace rendering
vim.opt.list = true

vim.opt.listchars = {
  space = '·',      -- Displays for regular spaces
  tab = '» ',       -- Displays for tab characters (requires a trailing space)
  trail = '•',      -- Displays for trailing spaces at the end of lines
  -- eol = '↲',        -- Displays at the end of each line
  nbsp = '␣',       -- Displays for non-breaking spaces
}

-- Set the color of whitespace characters to gruvbox dark bg1 color
vim.api.nvim_set_hl(0, "Whitespace", { fg = "#3c3836" })

vim.keymap.set('n', '<leader>rw', ':set list!<CR>', { desc = 'Toggle render whitespace', silent = true })
