local M = {}

local function is_helm_file(path)
  local check =
    vim.fs.find('Chart.yaml', { path = vim.fs.dirname(path), upward = true })
  return not vim.tbl_isempty(check)
end

local function yaml_filetype(path, bufname)
  return is_helm_file(path) and 'helm' or 'yaml'
end

function M.filetype()
  vim.filetype.add({
    extension = {
      yaml = yaml_filetype,
      yml = yaml_filetype,
      tpl = yaml_filetype,
    },
    filename = {
      ['Chart.yaml'] = 'yaml',
      ['Chart.lock'] = 'yaml',
      ['values.yaml'] = 'yaml',
    },
  })
end

function M.lookup()
  vim.cmd([[normal! "kyi"]])
  vim.cmd([[exec "silent! grep 'define \"" . getreg('k') . "\"'"]])
end

return M
