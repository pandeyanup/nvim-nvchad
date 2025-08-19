vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.number = true
    vim.opt.relativenumber = true
  end,
})
