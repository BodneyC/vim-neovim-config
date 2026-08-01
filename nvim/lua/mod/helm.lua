local M = {}

local function has_parent_dir(path, dir)
  return vim.tbl_isempty(vim.fs.find(dir, { path = path, upward = true, type = 'directory' }))
end

local function is_helm_file(path)
  local chart = vim.fs.find('Chart.yaml', { path = vim.fs.dirname(path), upward = true })
  return not vim.tbl_isempty(chart) and
      (has_parent_dir(path, 'crds') or has_parent_dir(path, 'templates') or has_parent_dir(path, 'tests'))
end

local function yaml_filetype(path, _)
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
