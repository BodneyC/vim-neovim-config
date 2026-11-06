local function title_case(str)
  local spaced = ' ' .. str:gsub('[_-]', ' ')
  return (spaced:gsub('(%W)(%l)', function(sep, char)
    return sep .. char:upper()
  end):sub(2))
end

local function insert_template()
  local title = vim.fn.expand('%:t:r')
  if title:lower() == 'readme' then
    title = vim.fn.expand('%:p:h:t'):lower()
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, {
    '<!-- markdownlint-disable MD013 -->',
    '',
    '# ' .. title_case(title),
    '',
  })
end

local function smart_tab()
  local cmp_ok, cmp = pcall(require, 'cmp')
  if cmp_ok and cmp.visible() then
    return cmp.select_next_item()
  end
  if vim.fn.pumvisible() == 1 then
    return require('util').feedkeys('<C-n>')
  end

  local col = vim.fn.col('.') - 1
  local line = vim.api.nvim_get_current_line()
  if col == 0 or line:sub(col, col):match('%s') then
    if line:match('^%s*-') then
      return require('util').feedkeys('<C-o>>><C-o>A')
    end
    return require('util').feedkeys('<Tab>')
  end

  if cmp_ok then
    return cmp.complete()
  end
  require('util').feedkeys('<Tab>')
end

vim.opt_local.shiftwidth = 2
vim.opt_local.conceallevel = 0
vim.opt_local.concealcursor = ''
vim.opt_local.commentstring = '<!-- %s -->'
vim.opt_local.spell = true
vim.opt_local.number = false

vim.api.nvim_buf_create_user_command(0, 'MDTemplate', insert_template, {})
if vim.api.nvim_buf_line_count(0) == 1 and vim.fn.getline(1) == '' then
  insert_template()
end

local group = vim.api.nvim_create_augroup('config_markdown', { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = 0 })
vim.api.nvim_create_autocmd('BufEnter', {
  group = group,
  buffer = 0,
  callback = function()
    vim.opt_local.number = false
  end,
})

vim.fn.setreg('t', 'mzvip:EasyAlign *|\r`z')
vim.fn.setreg('h', 'YpVr=')

vim.keymap.set('n', '<leader>S', '1z=', { buffer = true, desc = 'Accept first spelling suggestion' })
vim.keymap.set('i', '<Tab>', smart_tab, { buffer = true, desc = 'Indent list item or complete' })
