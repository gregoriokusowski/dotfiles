vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'svermeulen/vimpeccable'
  use 'tpope/vim-sensible'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'
  use 'AndrewRadev/splitjoin.vim'
  use 'vim-airline/vim-airline'
  use 'scrooloose/nerdtree' --, cmd = {'NERDTreeToggle', 'NERDTreeFind'} }
  use 'scrooloose/nerdcommenter'
  use 'editorconfig/editorconfig-vim'
  use 'ntpeters/vim-better-whitespace'

  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/nvim-treesitter'
  use 'neovim/nvim-lspconfig'

  use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- use 'liuchengxu/vim-which-key' --, opt = true, cmd = {'WhichKey', 'WhichKey!'} }

  use 'ayu-theme/ayu-vim'
  use 'Yggdroot/indentLine'
end)

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-L>",
      node_incremental = "<M-L>",
      scope_incremental = "<M-K>",
      node_decremental = "<M-H>",
    },
  },

  indent = {
    enable = true,
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["am"] = "@function.outer",
        ["im"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        [">a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<a"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    --lsp_interop = {
      --enable = true,
      --peek_definition_code = {
        --["gp"] = "@function.outer",
      --},
    --},
  },
}
require('telescope').setup {
  extensions = {
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

--function Sorbet()
  require'lspconfig'.sorbet.setup{}
--end
--vim.api.nvim_command("command! Sorbet call Sorbet()")
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>Telescope lsp_range_code_actions<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'sorbet' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end


vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

vim.o.hidden = true
vim.o.relativenumber = true
vim.o.number = true           -- Show line numbers
vim.o.ruler = true            -- Show line and column number
vim.cmd('syntax enable')      -- Turn on syntax highlighting allowing local overrides

-- Color scheme
vim.o.termguicolors = true --     " enable true colors support
vim.cmd('let ayucolor="light"') --  " for light version of theme
vim.cmd('colorscheme ayu')

-- ayu IndentLine
vim.g.indentLine_showFirstIndentLevel = 1
vim.g.indentLine_setColors = 0

-- NERDTree
vim.cmd('let NERDTreeRespectWildIgnore = 1')
vim.cmd('let NERDTreeShowHidden = 1')
vim.cmd('let NERDTreeCascadeSingleChildDir = 0')

-- Airline
vim.g.airline_powerline_fonts = 1
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g.rainbow_active = 1

--
-- Whitespace
--

vim.wo.wrap = false                        -- don't wrap lines
vim.o.tabstop = 2 			   --  a tab is two spaces
vim.o.shiftwidth = 2                   -- an autoindent (with <<) is two spaces
vim.o.expandtab = true                     -- use spaces, not tabs
vim.o.list = true                          -- Show invisible characters
vim.o.backspace = "indent,eol,start"    -- backspace through everything in insert mode

-- List chars
-- vim.o.listchars=""                  -- Reset the listchars
-- vim.o.listchars=tab:\ \             -- a tab should display as "  ", trailing whitespace as "."
-- vim.o.listchars+=trail:.            -- show trailing spaces as dots
-- vim.o.listchars+=extends:>          -- The character to show in the last column when wrap is off and the line continues beyond the right of the screen
-- vim.o.listchars+=precedes:<         -- The character to show in the last column when wrap is off and the line continues beyond the left of the screen

--
-- Searching
--

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.g.mapleader      = " "
vim.g.maplocalleader = ','

local vimp = require('vimp')
-- " Project tree
vimp.nnoremap('<Leader>pt', ':NERDTreeToggle<CR>')
vimp.nnoremap('<Leader>pf', ':NERDTreeFind<CR>')

-- " Search
vim.cmd([[command! -bang -nargs=? -complete=dir ProjectFiles call fzf#vim#files(<q-args>, {'options': ['--query=rb$ ']}, <bang>0)]])
vimp.nnoremap('<Leader>pp', ':ProjectFiles<CR>')
vimp.nnoremap('<C-p>', ':Files<Cr>')
vimp.nnoremap('<C-c>', '<cmd>Telescope commands<cr>')
--
-- " .
vim.cmd('xnoremap . :normal .<CR>')
--
--vimp.nnoremap('<silent>', '<leader> :WhichKey "<Space>"<CR>')
vim.cmd('set timeoutlen=500')
vim.cmd([[set completeopt=menu,menuone,noselect]])
--
-- " text utils
-- " Leader+Y copies into clipboard - from https://vim.fandom.com/wiki/Mac_OS_X_clipboard_sharing
vim.cmd([[vnoremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>]])
--vimp.vnoremap({'expr', 'silent'}, '<Leader>y', [[:<CR>:let @a=@" | execute "normal! vgvy" | let res=system("pbcopy", @") | let @"=@a<CR>]])
-- " sort
vimp.vnoremap('<Leader>s', ":'<,'>!sort<CR><CR>")
-- " shuffle
vimp.vnoremap('<Leader>S', ":'<,'>!sort -R<CR><CR>")
--
-- " Copy from https://github.com/liuchengxu/vim-better-default/blob/master/plugin/default.vim
-- " Buffers
-- " bb because b hangs because of other buffer mappings and C-b may conflict when using nested tmuxes
vimp.nnoremap('<Leader>bb', ':Buffers<Cr>')
vimp.nnoremap('<leader>fb', '<cmd>Telescope buffers<cr>')
vimp.nnoremap('<leader>fr', '<cmd>Telescope registers<cr>')
vimp.nnoremap('<C-j>', ':bprevious<Cr>')
vimp.nnoremap('<C-k>', ':bnext<Cr>')
vimp.nnoremap('<Leader>bp', ':bprevious<CR>')
vimp.nnoremap('<Leader>bn', ':bnext<CR>')
vimp.nnoremap('<Leader>bf', ':bfirst<CR>')
vimp.nnoremap('<Leader>bl', ':blast<CR>')
vimp.nnoremap('<Leader>bd', ':bd<CR>')
vimp.nnoremap('<Leader>bk', ':bw<CR>')
--
-- " Window
vimp.nnoremap('<Leader>ww', '<C-W>w')
vimp.nnoremap('<Leader>wr', '<C-W>r')
vimp.nnoremap('<Leader>wd', '<C-W>c')
vimp.nnoremap('<Leader>wq', '<C-W>q')
vimp.nnoremap('<Leader>wj', '<C-W>j')
vimp.nnoremap('<Leader>wk', '<C-W>k')
vimp.nnoremap('<Leader>wh', '<C-W>h')
vimp.nnoremap('<Leader>wl', '<C-W>l')
-- if has('nvim') || has('terminal')
--vimp.tnoremap('<Leader>wj', '<C-W>j')
--vimp.tnoremap('<Leader>wk', '<C-W>k')
--vimp.tnoremap('<Leader>wh', '<C-W>h')
--vimp.tnoremap('<Leader>wl', '<C-W>l')
-- endif
vimp.nnoremap('<Leader>wH', '<C-W>5<')
vimp.nnoremap('<Leader>wL', '<C-W>5>')
vimp.nnoremap('<Leader>wJ', ':resize +5<CR>')
vimp.nnoremap('<Leader>wK', ':resize -5<CR>')
vimp.nnoremap('<Leader>w=', '<C-W>=')
vimp.nnoremap('<Leader>ws', '<C-W>s')
vimp.nnoremap('<Leader>w-', '<C-W>s')
vimp.nnoremap('<Leader>wv', '<C-W>v')
vimp.nnoremap('<Leader>w|', '<C-W>v') -- was w\|
vimp.nnoremap('<Leader>w2', '<C-W>v')
--
