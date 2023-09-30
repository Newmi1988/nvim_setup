local augend = require("dial.augend")
require("dial.config").augends:register_group{
  -- default augends used when no group name is specified
  default = {
    augend.integer.alias.decimal,   -- nonnegative decimal number (0, 1, 2, 3, ...)
    augend.integer.alias.hex,       -- nonnegative hex number  (0x01, 0x1a1f, etc.)
    augend.date.alias["%Y/%m/%d"],  -- date (2022/02/19, etc.)
    augend.date.alias["%d.%m.%Y"],  -- date (01.01.2023, etc.)
    augend.semver.alias.semver,     -- semver version (1.0.0)
    augend.integer.alias.binary,    -- binary natural number 	(0b0101, 0b11001111)
    augend.integer.alias.octal, 	  -- octal natural number (0o00, 0o11, 0o24)
    augend.integer.alias.hex,       -- hex natural number (0x00, 0x3f3f)
    augend.date.alias["%H:%M:%S"], 	-- Time in the format %H:%M:%S (14:31:06, ...)
    augend.date.alias["%H:%M"], 	  -- Time in the format %H:%M  (15:09, ...)
  },
}


vim.keymap.set("n", "<C-a>", function()
    require("dial.map").manipulate("increment", "normal")
end, {
  desc = "Increment normal mode",
})
vim.keymap.set("n", "<C-x>", function()
    require("dial.map").manipulate("decrement", "normal")
end, {
  desc = "Decrement normal mode",
})
vim.keymap.set("n", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gnormal")
end, {
  desc = "Increment global normal mode",
})
vim.keymap.set("n", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gnormal")
end, {
  desc = "Decrement global normal mode",
})
vim.keymap.set("v", "<C-a>", function()
    require("dial.map").manipulate("increment", "visual")
end, {
  desc = "Increment visual mode",
})
vim.keymap.set("v", "<C-x>", function()
    require("dial.map").manipulate("decrement", "visual")
end, {
  desc = "Decrement normal mode",
})
vim.keymap.set("v", "g<C-a>", function()
    require("dial.map").manipulate("increment", "gvisual")
end, {
  desc = "Increment global visual mode",
})
vim.keymap.set("v", "g<C-x>", function()
    require("dial.map").manipulate("decrement", "gvisual")
end, {
  desc = "Decrement global visual mode",
})