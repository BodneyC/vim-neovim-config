local M = {}

M.flags = {
  n = {
    noremap = true,
  },

  s = {
    silent = true,
  },

  u = {
    unique = true,
  },

  e = {
    expr = true,
  },

  ns = {
    noremap = true,
    silent = true,
  },

  ne = {
    noremap = true,
    expr = true,
  },

  se = {
    silent = true,
    expr = true,
  },

  nse = {
    noremap = true,
    silent = true,
    expr = true,
  },
}

return M
