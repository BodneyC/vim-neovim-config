local M = {}

M.file_exists = function(fn)
  local f = io.open(fn, 'r')
  if f == nil then
    return false
  end
  io.close(f)
  return true
end

M.dir_exists = function(fn)
  local f = io.open(fn, 'r')
  if f == nil then
    return false
  end
  local _, _, c = f:read()
  io.close(f)
  return c == 21
end

M.fsize = function(fn)
  local f = assert(io.open(fn, 'r'))
  local size = f:seek('end')
  io.close(f)
  return size
end

return M
