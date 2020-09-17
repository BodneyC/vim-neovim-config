local M = {}

function M.file_exists(fn)
  local f = io.open(fn, 'r')
  if f == nil then
    return false
  end
  io.close(f)
  return true
end

function M.dir_exists(fn)
  local f = io.open(fn, 'r')
  if f == nil then
    return false
  end
  local _, _, c = f:read()
  io.close(f)
  return c == 21
end

function M.fsize(fn)
  local f = assert(io.open(fn, 'r'))
  local size = f:seek('end')
  io.close(f)
  return size
end

return M
