vim.api.nvim_create_user_command('Flux', function()
    require('flux').status()
end, {
    desc = 'Open Flux status window',
    force = true,
})
