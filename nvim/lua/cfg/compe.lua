local vim = vim

vim.o.completeopt = 'menu,menuone,noselect'

-- compe -s-
require'compe'.setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = 'disable', -- or 'enable' or 'always',
  ---- Defaults are fine
  -- throttle_time = ... number ...,
  -- source_timeout = ... number ...,
  -- incomplete_delay = ... number ...,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  allow_prefix_unmatch = true,
  source = {
    path = true,
    calc = true,
    buffer = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
  },
}
-- -e-

-- tab cr -s-
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
    ? compe#confirm('<CR>')
    : "<C-e><CR>"
  : "<CR><Plug>AutoPairsReturn"
]], '\n', ''), {noremap = false, silent = true, expr = true})
-- -e-
