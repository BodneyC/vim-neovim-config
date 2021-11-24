local M = {}

local bytemarkers = {{0x7ff, 192}, {0xffff, 224}, {0x1fffff, 240}}

function M.index_of(arr, ele)
  for idx, val in ipairs(arr) do
    if ele == val then
      return idx
    end
  end
  return -1
end

function M.module_exists(m)
  if package.loaded[m] then
    return true
  end
  for _, searcher in ipairs(package.searchers or package.loaders) do
    local loader = searcher(m)
    if type(loader) == 'function' then
      package.preload[m] = loader
      return true
    end
  end
  return false
end

return M
