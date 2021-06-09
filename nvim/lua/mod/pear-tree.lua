local vim = vim

local skm = vim.api.nvim_set_keymap

local M = {}

function M.pear_tree_close(c) -- -s-
  if #vim.fn['pear_tree#GetSurroundingPair']() ~= 0 and vim.fn['pear_tree#GetSurroundingPair']()[2] ==
      c and string.match(string.sub(vim.fn.getline('.'), vim.fn.col('.')), '^%s*%' .. c) then
    return vim.fn['pear_tree#insert_mode#JumpOut']()
  else
    return vim.fn['pear_tree#insert_mode#HandleCloser'](c)
  end
end -- -e-

function M.init() -- -s-
  local sne = {noremap = false, silent = true, expr = true}
  vim.g.pear_tree_map_special_keys = 0
  -- cr -s-
  local cr = string.gsub([[
    pumvisible()
    ? complete_info()["selected"] != "-1"
      ? "<Plug>(completion_confirm_completion)"
      : "<C-e><CR>"
    : "<Plug>(PearTreeExpand)"
  ]], '\n', '')
  skm('i', '<CR>', cr, sne)
  -- -e-
  -- bs -s-
  local bs = string.gsub([[
    getline('.')[:col('.') - 2] =~ '^\s\+$'
      ? getline(line('.') - 1) =~ '^\s*$'
        ? getline('.') =~ '^\s*$'
          ? "<C-o>ck"
          : "<C-o>:exe line('.') - 1 . 'delete'<CR>"
        : "<C-w><BS>"
      : pear_tree#insert_mode#Backspace()
  ]], '\n', '')
  skm('i', '<BS>', bs, sne)
  -- -e-
  skm('i', '<C-f>', 'pear_tree#insert_mode#JumpOut()', sne)
  skm('i', '<Esc>', 'pear_tree#insert_mode#Expand()', sne)
  skm('i', '<Space>', 'pear_tree#insert_mode#Space()', sne)

  -- ... well, I'm never going to type these in I suppose...
  skm('i', '䙛', '<Plug>(PearTreeCloser_])', {})
  skm('i', '𭕫', '<Plug>(PearTreeCloser_))', {})
  skm('i', '𔂈', '<Plug>(PearTreeCloser_})', {})

  skm('i', ']', [[luaeval("require'mod.pear-tree'.pear_tree_close(']')")]], sne)
  skm('i', ')', [[luaeval("require'mod.pear-tree'.pear_tree_close(')')")]], sne)
  skm('i', '}', [[luaeval("require'mod.pear-tree'.pear_tree_close('}')")]], sne)
end -- -e-

return M
