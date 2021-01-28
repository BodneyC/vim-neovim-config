local vim = vim

vim.o.completeopt = 'menu,menuone,noselect'

require'compe'.setup {
  enabled = true,
  debug = false,
  min_length = 1,
  preselect = 'enable', -- or 'disable' or 'always',
  -- throttle_time = ... number ...,
  -- source_timeout = ... number ...,
  -- incomplete_delay = ... number ...,
  allow_prefix_unmatch = true,
  source = {
    path = true,
    buffer = true,
    vsnip = true,
    nvim_lsp = true,
    -- nvim_lua = { ... overwrite source configuration ... },
  },
}

local skm = vim.api.nvim_set_keymap

-- Well, this is awful
local function tab_string(e, k)
  return [[ pumvisible() ? "\]] .. e .. [[" ]] ..
             [[ : (!(col('.') - 1) || getline('.')[col('.') - 2]  =~ '\s') ? "\]] .. k ..
             [[" : compe#complete() ]]
end
skm('i', '<Tab>', tab_string('<C-n>', '<Tab>'), {noremap = true, silent = true, expr = true})
skm('i', '<S-Tab>', tab_string('<C-p>', '<C-d>'), {noremap = true, silent = true, expr = true})
skm('i', '<C-e>', [[compe#close('<C-e>')]], {noremap = true, silent = true, expr = true})

skm('i', '<CR>', string.gsub([[
  pumvisible()
  ? complete_info()["selected"] != "-1"
    ? "<C-r>=compe#confirm('<C-y>')<CR> "
    : "<C-e><CR>"
  : "<CR><Plug>AutoPairsReturn"
]], '\n', ''), {noremap = false, silent = true, expr = true})
