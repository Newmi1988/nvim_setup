require("dashboard").setup({
  theme = 'hyper',
  config = {
    week_header = {
      enable = true,
    },
    shortcut = {
      {
        desc = ' Update',
        group = '@property',
        action = 'Lazy update',
        key = 'u'
      },
      {
        desc = ' Files',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'f',
      },
      {
        desc = ' Branches',
        group = 'DiagnosticHint',
        action = 'Telescope git_branches',
        key = 'b',
      },
      {
        desc = '󱝪 Grep',
        group = 'Number',
        action = 'Telescope live_grep',
        key = 'g',
      },
      {
        desc = 'Restore Session',
        group = 'Number',
        action = 'RestoreSession',
        key = 'r',
      },
    },
  },
})
