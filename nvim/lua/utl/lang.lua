local M = {}

local bytemarkers = {{0x7ff, 192}, {0xffff, 224}, {0x1fffff, 240}}

function M.cmd_output(cmd, throw, raw) -- -s-
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  local _, _, e = f:close()
  if throw and e ~= 0 then error('Cmd `' .. cmd .. '` returned status code ' .. e) end
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  return s
end -- -e-

function M.utf8(decimal) -- -s-
  if decimal < 128 then return string.char(decimal) end
  local charbytes = {}
  for bytes, vals in ipairs(bytemarkers) do
    if decimal <= vals[1] then
      for b = bytes + 1, 2, -1 do
        local mod = decimal % 64
        decimal = (decimal - mod) / 64
        charbytes[b] = string.char(128 + mod)
      end
      charbytes[1] = string.char(vals[2] + decimal)
      break
    end
  end
  return table.concat(charbytes)
end -- -e-

function M.elem_in_array(a, e) -- -s-
  for _, v in ipairs(a) do if v == e then return true end end
  return false
end -- -e-

function M.module_exists(m) -- -s-
  if package.loaded[m] then return true end
  for _, searcher in ipairs(package.searchers or package.loaders) do
    local loader = searcher(m)
    if type(loader) == 'function' then
      package.preload[m] = loader
      return true
    end
  end
  return false
end -- -e-

function string.split(inputstr, sep) -- -s-
  if sep == nil then sep = '%s' end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do table.insert(t, str) end
  return t
end -- -e-

return M
