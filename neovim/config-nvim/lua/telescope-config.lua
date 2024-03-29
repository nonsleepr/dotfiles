require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    --[[
    vimgrep_arguments = {
      'ag',
      '-i',
      '--vimgrep',
      '--noheading',
      '--hidden',
      '--smart-case',
    },
    ]]--
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key",
        ["<PageUp>"] = function (prompt_bufnr)
          require('telescope.actions.set').shift_selection(prompt_bufnr, -5)
        end,
        ["<PageDown>"] = function (prompt_bufnr)
          require('telescope.actions.set').shift_selection(prompt_bufnr, 5)
        end,
      }
    },
    layout_strategy = "vertical",
    layout_config = {
      preview_height = 0.65,
      width = 0.95,
      height = 0.70,
      preview_cutoff = 1,
      prompt_position = "top",
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

vim.api.nvim_set_keymap('n', '<Leader>af', ":Telescope find_files<CR>", { noremap = true, silent = true }) -- all files
vim.api.nvim_set_keymap('n', '<Leader>f', ":Telescope git_files<CR>", { noremap = true, silent = true }) -- git files
vim.api.nvim_set_keymap('n', '<Leader>g', ":Telescope grep_string<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ":Telescope live_grep<CR>", { noremap = true, silent = true })
