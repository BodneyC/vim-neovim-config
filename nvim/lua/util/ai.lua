-- Detects which AI providers are usable on this machine, so one config works
-- everywhere without nagging about whichever provider isn't set up.
--
-- Override with $NVIM_AI: a comma-separated list of providers to enable
-- (e.g. `NVIM_AI=copilot`), or `none` to disable all of them.
--
-- Copilot is never used under a directory containing a `.nocopilot` file
-- (searched upwards), whatever $NVIM_AI says. Put it in a parent directory
-- (e.g. ~/work/client/) rather than a repo so it is never committed.
local M = {}

M.COPILOT_MARKER = '.nocopilot'

---@param name string
---@return boolean? nil when $NVIM_AI is unset (auto-detect)
local function env_override(name)
  local env = vim.env.NVIM_AI
  if not env or env == '' then
    return nil
  end
  for item in env:gmatch('[^,%s]+') do
    if item == name then
      return true
    end
  end
  return false
end

local function copilot_config_dir()
  if vim.fn.has('win32') == 1 then
    return vim.fs.joinpath(vim.env.LOCALAPPDATA or '~/AppData/Local', 'github-copilot')
  end
  return vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or vim.fn.expand('~/.config'), 'github-copilot')
end

--- Copilot has been signed in on this machine (`:Copilot auth` writes these).
---@return boolean
function M.copilot_authed()
  local dir = copilot_config_dir()
  for _, file in ipairs({ 'apps.json', 'hosts.json' }) do
    if vim.uv.fs_stat(vim.fs.joinpath(dir, file)) then
      return true
    end
  end
  return false
end

--- `path` (file or directory) is somewhere Copilot must not be used.
---@param path string
---@return boolean
function M.copilot_blocked(path)
  if path == '' then
    path = vim.fn.getcwd()
  end
  return vim.fs.root(path, M.COPILOT_MARKER) ~= nil
end

--- Copilot should attach automatically (signed in and node available).
---@return boolean
function M.copilot_enabled()
  if M.copilot_blocked(vim.fn.getcwd()) then
    return false
  end
  local override = env_override('copilot')
  if override ~= nil then
    return override
  end
  return vim.fn.executable('node') == 1 and M.copilot_authed()
end

--- Claude Code CLI is installed.
---@return boolean
function M.claude_enabled()
  local override = env_override('claude')
  if override ~= nil then
    return override
  end
  return vim.fn.executable('claude') == 1
end

return M
