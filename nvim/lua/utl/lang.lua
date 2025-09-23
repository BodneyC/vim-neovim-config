local M = {}

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
  ---@diagnostic disable-next-line: deprecated
  for _, searcher in ipairs(package.loaders) do
    local loader = searcher(m)
    if type(loader) == 'function' then
      package.preload[m] = loader
      return true
    end
  end
  return false
end

return M
