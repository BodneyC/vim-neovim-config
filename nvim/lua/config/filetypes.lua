local helm_dirs = { templates = true, crds = true, tests = true }

local function yaml_or_helm(path)
  path = vim.fs.abspath(path)
  local root = vim.fs.root(path, 'Chart.yaml')
  local rel = root and vim.fs.relpath(root, path)
  local top = rel and rel:match('^([^/]+)/')
  return helm_dirs[top] and 'helm' or 'yaml'
end

vim.filetype.add({
  extension = {
    yaml = yaml_or_helm,
    yml = yaml_or_helm,
    tpl = yaml_or_helm,
  },
  filename = {
    ['Chart.yaml'] = 'yaml',
    ['Chart.lock'] = 'yaml',
    ['values.yaml'] = 'yaml',
    PKGBUILD = 'pkgbuild',
  },
  pattern = {
    ['Dockerfile.*'] = 'dockerfile',
    ['Jenkinsfile.*'] = 'groovy',
  },
})
