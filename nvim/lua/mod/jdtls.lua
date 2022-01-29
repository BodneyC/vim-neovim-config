local bskm = vim.api.nvim_buf_set_keymap
local util = require('utl.util')
local jdtls = require('jdtls')

local M = {}

function M.commands()
  util.commands({
    {
      name = 'JdtCompile',
      command = [[lua require('jdtls').compile()]],
      opts = {
        buffer = true,
      },
    },
    {
      name = 'JdtUpdateConfig',
      command = [[lua require('jdtls').update_project_config()]],
      opts = {
        buffer = true,
      },
    },
    {
      name = 'JdtJol',
      command = [[lua require('jdtls').jol()]],
      opts = {
        buffer = true,
      },
    },
    {
      name = 'JdtBytecode',
      command = [[lua require('jdtls').javap()]],
      opts = {
        buffer = true,
      },
    },
    {
      name = 'JdtJshell',
      command = [[lua require('jdtls').jshell()]],
      opts = {
        buffer = true,
      },
    },
    {
      name = 'JdtOrganizeImports',
      command = [[<Cmd>lua require('jdtls').organize_imports()<CR>]],
      opts = {
        buffer = true,
      },
    },
  })
end

function M.mappings()
  bskm(0, 'n', 'ga', [[<Cmd>lua require('jdtls').code_action()<CR>]], {})
  bskm(0, 'v', 'ga', [[<Esc><Cmd>lua require('jdtls').code_action(true)<CR>]],
    {})
  bskm(0, 'n', '<leader>R',
    [[<Cmd>lua require('jdtls').code_action(false, 'refactor')<CR>]], {})
  bskm(0, 'n', '<M-S-o>', [[<Cmd>lua require('jdtls').organize_imports()<CR>]],
    {})
  bskm(0, 'n', 'crv', [[<Cmd>lua require('jdtls').extract_variable()<CR>]], {})
  bskm(0, 'v', 'crv',
    [[<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>]], {})
  bskm(0, 'v', 'crm',
    [[<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>]], {})

  bskm(0, 'n', '<leader>Dtc', [[<Cmd>lua require('jdtls').test_class()<CR>]], {})
  bskm(0, 'n', '<leader>Dtm',
    [[<Cmd>lua require('jdtls').test_nearest_method()<CR>]], {})
end

function M.attach()
  jdtls.start_or_attach({
    cmd = {'jdt.ls.sh'},
    root_dir = require('jdtls.setup').find_root({
      '.git',
      'pom.xml',
      'mvnw',
      'gradlew',
    }),
    settings = {
      java = {},
    },
    init_options = {
      bundles = {
        vim.fn.glob(
          '$HOME/software/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
        unpack(vim.split(vim.fn.glob(
          '$HOME/software/vscode-java-test/server/*.jar'), '\n')),
      },
    },
    on_attach = function(client, bufnr)
      jdtls.setup_dap({
        hotcodereplace = 'auto',
      })
    end,
  })
end

function M.init()
  if not jdtls then
    return
  end
  M.attach()
  M.mappings()
  M.commands()
end

return M
