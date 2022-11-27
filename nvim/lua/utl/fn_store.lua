local M = {}
local _MODULE_NAME_ = 'utl.fn_store'

local store = {}

local function register_fn(fn, name)
  if name then
    store[name] = fn
    return '\'' .. name .. '\''
  else
    table.insert(store, fn)
    return #store
  end
end

function M.apply_fn(idx) store[idx]() end

function M.apply_expr(idx) return require('utl.util').replace_termcodes(store[idx]()) end

function M.fn_aug(fn, name)
  return string.format([[lua require('%s').apply_fn(%s)]], _MODULE_NAME_, register_fn(fn, name))
end

function M.fn(fn, name) return '<CMD>' .. M.fn_aug(fn, name) .. '<CR>' end

function M.expr(fn, name)
  return string.format([[v:lua.require('%s').apply_expr(%s)<CR>]], _MODULE_NAME_,
    register_fn(fn, name))
end

return M
