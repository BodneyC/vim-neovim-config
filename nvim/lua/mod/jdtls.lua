local vim = vim
local bskm = vim.api.nvim_buf_set_keymap
local util = require 'utl.util'

local jdtls = require 'jdtls'

local M = {}

M.commands = function()
  util.command('JdtCompile', [[lua require'jdtls'.compile()]], {buffer = true})
  util.command('JdtUpdateConfig', [[lua require'jdtls'.update_project_config()]], {buffer = true})
  util.command('JdtJol', [[lua require'jdtls'.jol()]], {buffer = true})
  util.command('JdtBytecode', [[lua require'jdtls'.javap()]], {buffer = true})
  util.command('JdtJshell', [[lua require'jdtls'.jshell()]], {buffer = true})
end

M.mappings = function()
  bskm(0, 'n', 'ga', [[<Cmd>lua require'jdtls'.code_action()<CR>]], {})
  bskm(0, 'v', 'ga', [[<Esc><Cmd>lua require'jdtls'.code_action(true)<CR>]], {})
  bskm(0, 'n', '<leader>R', [[<Cmd>lua require'jdtls'.code_action(false, 'refactor')<CR>]], {})
  bskm(0, 'n', '<A-o>', [[<Cmd>lua require'jdtls'.organize_imports()<CR>]], {})
  bskm(0, 'n', 'crv', [[<Cmd>lua require'jdtls'.extract_variable()<CR>]], {})
  bskm(0, 'v', 'crv', [[<Esc><Cmd>lua require'jdtls'.extract_variable(true)<CR>]], {})
  bskm(0, 'v', 'crm', [[<Esc><Cmd>lua require'jdtls'.extract_method(true)<CR>]], {})

  bskm(0, 'n', '<leader>df', [[<Cmd>lua require'jdtls'.test_class()<CR>]], {})
  bskm(0, 'n', '<leader>dn', [[<Cmd>lua require'jdtls'.test_nearest_method()<CR>]], {})
end

M.attach = function()
  jdtls.start_or_attach({
    cmd = {'jdt.ls.sh'},
    root_dir = jdtls.setup.find_root({'.git', 'pom.xml'}),
    init_options = {
      bundles = {
        vim.fn.glob(
            '$HOME/software/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
        unpack(vim.split(vim.fn.glob('$HOME/software/vscode-java-test/server/*.jar'), '\n')),
      },
    },
    on_attach = function()
      jdtls.setup_dap()
    end,
  })
end

M.init = function()
  if not jdtls then return end
  M.attach()
  M.mappings()
  M.commands()
end

return M
