-- lua/plugins/mini-surround.lua
return {
  "echasnovski/mini.surround",
  event = "VeryLazy",
  opts = {
    mappings = {
      add = "gsa",      -- add surrounding
      delete = "gsd",   -- delete surrounding
      replace = "gsr",  -- replace surrounding
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
    },
  },
}

-- gsaiw" → wraps current word in "..."
-- gsd' → deletes surrounding single quotes
-- gsr"( → replaces surrounding "..." with (...)
-- gsaip<tag> → wraps paragraph in JSX tag
