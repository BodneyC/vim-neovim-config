local M = {}
local _MODULE_NAME_ = 'utl.fn_store'

local store = {}

local function register_fn(fn)
  table.insert(store, fn)
  return #store
end

function M.apply_fn(idx)
  store[idx]()
end

function M.apply_expr(idx)
  return require('utl.util').replace_termcodes(store[idx]())
end

function M.store_fn(fn)
  return string.format([[<CMD>lua require('%s').apply_fn(%s)<CR>]],
    _MODULE_NAME_, register_fn(fn))
end

function M.store_expr(fn)
  return string.format([[v:lua.require('%s').apply_expr(%s)<CR>]],
    _MODULE_NAME_, register_fn(fn))
end

return M
