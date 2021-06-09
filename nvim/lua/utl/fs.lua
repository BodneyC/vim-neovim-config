local M = {}

function M.file_exists(fn) -- -s-
  local f = io.open(fn, 'r')
  if f == nil then
    return false
  end
  io.close(f)
  return true
end -- -e-

function M.dir_exists(fn) -- -s-
  local f = io.open(fn, 'r')
  if f == nil then
    return false
  end
  local _, _, c = f:read()
  io.close(f)
  return c == 21
end -- -e-

function M.fsize(fn) -- -s-
  local f = assert(io.open(fn, 'r'))
  local size = f:seek('end')
  io.close(f)
  return size
end -- -e-

return M
