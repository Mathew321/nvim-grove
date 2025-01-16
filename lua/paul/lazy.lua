local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Advanced yank highlighting
local function setup_highlight_on_yank()
    -- Create an autogroup for managing the autocmds
    vim.api.nvim_command('augroup kickstart_highlight_yank')
    vim.api.nvim_command('autocmd!')
    -- Define the autocmd to trigger after text is yanked
    vim.api.nvim_command('autocmd TextYankPost * lua vim.highlight.on_yank()')
    -- End the autogroup
    vim.api.nvim_command('augroup END')
end

-- Call the function to set up the autocmd
setup_highlight_on_yank()

require("lazy").setup({
    { import = "paul.plugins" },
    { import = "paul.plugins.lsp" },
    { import = "paul.plugins.rust" },
    { import = "paul.plugins.debug" },
  },
  {

    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      notify = false,
    },
  })
