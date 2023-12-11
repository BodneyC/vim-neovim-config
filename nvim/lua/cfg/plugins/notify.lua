local icons = require('mod.theme').icons

return {
  timeout = 2000,
  max_width = 60,
  max_height = 25,
  icons = {
    DEBUG = icons.hint,
    ERROR = icons.error,
    INFO = icons.info,
    TRACE = "✎",
    WARN = icons.warn
  },
}
