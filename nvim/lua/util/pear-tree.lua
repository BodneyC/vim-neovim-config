local vim = vim
local skm = vim.api.nvim_set_keymap

local M = {}

function M.pear_tree_close(c)
  if #vim.fn['pear_tree#GetSurroundingPair']() ~= 0 and
      vim.fn['pear_tree#GetSurroundingPair']()[2] == c and
      string.match(string.sub(vim.fn.getline('.'), vim.fn.col('.')), '^%s*%' .. c) then
    return vim.fn['pear_tree#insert_mode#JumpOut']()
  else
    return vim.fn['pear_tree#insert_mode#HandleCloser'](c)
  end
end

function M.init()
  vim.g.pear_tree_map_special_keys = 0
  skm('i', '<CR>', '' ..
    [[ pumvisible()                                 ]] ..
    [[ ? complete_info()["selected"] != "-1"        ]] ..
    [[   ? completion#wrap_completion()             ]] ..
    [[   : "\<C-e>\<CR>"                            ]] ..
    [[ : pear_tree#insert_mode#PrepareExpansion()   ]],
    { noremap = true, silent = true, expr = true })
  skm('i', '<BS>', '' ..
    [[ getline('.')[:col('.') - 2] =~ '^\s\+$'        ]] ..
    [[ ? getline(line('.') - 1) =~ '^\s*$'            ]] ..
    [[   ? getline('.') =~ '^\s*$'                    ]] ..
    [[     ? "<Esc>ck"                                ]] ..
    [[     : "<C-o>:exe line('.') - 1 . 'delete'<CR>" ]] ..
    [[   : "<C-w><BS>"                                ]] ..
    [[ : pear_tree#insert_mode#Backspace()            ]],
    { noremap = true, silent = true, expr = true })
  skm('i', '<C-f>',   'pear_tree#insert_mode#JumpOut()', { silent = true, noremap = true,expr=true })
  skm('i', '<Esc>',   'pear_tree#insert_mode#Expand()',  { silent = true, noremap = true,expr=true })
  skm('i', '<Space>', 'pear_tree#insert_mode#Space()',   { silent = true, noremap = true,expr=true })

  -- ... well, I'm never going to type these in I suppose...
  skm('i', '䙛', '<Plug>(PearTreeCloser_])', {})
  skm('i', '𭕫', '<Plug>(PearTreeCloser_))', {})
  skm('i', '𔂈' , '<Plug>(PearTreeCloser_})', {})

  skm('i', ']', [[luaeval("require'util.pear-tree'.pear_tree_close(']')")]], { noremap = true, silent = true, expr = true })
  skm('i', ')', [[luaeval("require'util.pear-tree'.pear_tree_close(')')")]], { noremap = true, silent = true, expr = true })
  skm('i', '}', [[luaeval("require'util.pear-tree'.pear_tree_close('}')")]], { noremap = true, silent = true, expr = true })
end

return M
