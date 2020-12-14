-- neovim config
-- github.com/ojroques

-------------------- HELPERS -------------------------------
local cmd, fn, g = vim.cmd, vim.fn, vim.g

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then for k, v in pairs(opts) do options[k] = v end end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function opt(scope, key, value)
  local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
  scopes['o'][key] = value
  scopes[scope][key] = value
end

-------------------- PLUGINS -------------------------------
cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq {'airblade/vim-gitgutter'}
paq {'airblade/vim-rooter'}
paq {'joshdick/onedark.vim'}
paq {'junegunn/fzf', hook = fn['fzf#install']}
paq {'junegunn/fzf.vim'}
paq {'lervag/vimtex'}
paq {'machakann/vim-sandwich'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-treesitter/nvim-treesitter'}
paq {'ojroques/nvim-lspfuzzy'}
paq {'ojroques/vim-oscyank'}
paq {'savq/paq-nvim', opt = true}
paq {'shougo/deoplete-lsp'}
paq {'shougo/deoplete.nvim', hook = fn['remote#host#UpdateRemotePlugins']}
paq {'tpope/vim-commentary'}
paq {'tpope/vim-fugitive'}
paq {'vim-airline/vim-airline'}
paq {'yggdroot/indentLine'}

-------------------- PLUGIN SETUP --------------------------
-- airline
g['airline#extensions#tabline#enabled'] = 1
g['airline#extensions#tabline#fnamemod'] = ':p:t'
g['airline#extensions#tabline#formatter'] = 'unique_tail_improved'
g['airline_section_x'] = ''
g['airline_section_y'] = fn['airline#section#create_right'] {'filetype'}
g['airline_section_z'] = fn['airline#section#create'] {
  '%#__accent_bold#%3l%#__restore__#/%L', ' ',
  '%#__accent_bold#%3v%#__restore__#/%3{virtcol("$") - 1}', ' ',
  '%3p%%',
}
-- deoplete
opt('o', 'completeopt', 'menuone,noinsert,noselect')
g['deoplete#enable_at_startup'] = 1
fn['deoplete#custom#option']('ignore_case', false)
fn['deoplete#custom#option']('max_list', 10)
-- fzf
map('n', '<C-p>', '<cmd>Files<CR>')
map('n', '<leader>g', '<cmd>Commits<CR>')
map('n', '<leader>p', '<cmd>Rg<CR>')
map('n', 's', '<cmd>Buffers<CR>')
-- indentline
g['indentLine_fileType'] = {'c', 'cpp', 'lua', 'python', 'sh'}
-- netrw
g['netrw_banner'] = 0
g['netrw_liststyle'] = 3
g['netrw_winsize'] = 20
-- vim-sandwich
cmd 'runtime macros/sandwich/keymap/surround.vim'
-- vimtex
g['vimtex_quickfix_mode'] = 0
g['vimtex_view_method'] = 'zathura'

-------------------- OPTIONS -------------------------------
local indent = 2
cmd 'colorscheme onedark'
opt('b', 'expandtab' , true)                -- Use spaces instead of tabs
opt('b', 'shiftwidth' , indent)             -- Size of an indent
opt('b', 'smartindent' , true)              -- Insert indents automatically
opt('b', 'tabstop' , indent)                -- Number of spaces tabs count for
opt('o', 'hidden' , true)                   -- Enable background buffers
opt('o', 'ignorecase' , true)               -- Ignore case
opt('o', 'joinspaces' , false)              -- No double spaces with join
opt('o', 'pastetoggle' , '<F2>')            -- Paste mode
opt('o', 'scrolloff' , 4 )                  -- Lines of context
opt('o', 'shiftround' , true)               -- Round indent
opt('o', 'sidescrolloff' , 8 )              -- Columns of context
opt('o', 'smartcase' , true)                -- Don't ignore case with capitals
opt('o', 'splitbelow' , true)               -- Put new windows below current
opt('o', 'splitright' , true)               -- Put new windows right of current
opt('o', 'termguicolors' , true)            -- True color support
opt('o', 'updatetime' , 100)                -- Delay before swap file is saved
opt('o', 'wildmode' , 'longest:full,full')  -- Command-line completion mode
opt('w', 'colorcolumn' , '80')              -- Line length marker
opt('w', 'cursorline' , true)               -- Highlight cursor line
opt('w', 'list' , true)                     -- Show some invisible characters
opt('w', 'number' , true)                   -- Print line number
opt('w', 'relativenumber' , true)           -- Relative line numbers
opt('w', 'signcolumn' , 'yes')              -- Show sign column
opt('w', 'wrap' , false)                    -- Disable line wrap

-------------------- MAPPINGS ------------------------------
map('', '<leader>c', '"+y')
map('i', '<C-u>', '<C-g>u<C-u>')
map('i', '<C-w>', '<C-g>u<C-w>')
map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', {expr = true})
map('i', 'jj', '<ESC>')
map('n', '<C-l>', '<cmd>noh<CR>')
map('n', '<F3>', '<cmd>lua toggle_wrap()<CR>')
map('n', '<F4>', '<cmd>set spell!<CR>')
map('n', '<F5>', '<cmd>checkt<CR>')
map('n', '<F6>', '<cmd>set scb!<CR>')
map('n', '<F9>', '<cmd>Lexplore<CR>')
map('n', '<S-Down>', '<C-w>2<')
map('n', '<S-Left>', '<C-w>2-')
map('n', '<S-Right>', '<C-w>2+')
map('n', '<S-Up>', '<C-w>2>')
map('n', '<leader><Down>', '<cmd>cclose<CR>')
map('n', '<leader><Left>', '<cmd>cprev<CR>')
map('n', '<leader><Right>', '<cmd>cnext<CR>')
map('n', '<leader><Up>', '<cmd>copen<CR>')
map('n', '<leader>i', '<cmd>conf qa<CR>')
map('n', '<leader>o', 'm`o<Esc>``')
map('n', '<leader>s', ':%s//gcI<Left><Left><Left><Left>')
map('n', '<leader>u', '<cmd>update<CR>')
map('n', '<leader>w', '<cmd>lua close_buffer()<CR>')
map('n', 'Q', '<cmd>lua warn_caps_lock()<CR>')
map('n', 'S', '<cmd>bn<CR>')
map('n', 'U', '<cmd>lua warn_caps_lock()<CR>')
map('n', 'X', '<cmd>bp<CR>')
map('v', '<leader>s', ':s//gcI<Left><Left><Left><Left>')

-------------------- LSP -----------------------------------
local lsp = require 'lspconfig'
local lspfuzzy = require 'lspfuzzy'
lsp.bashls.setup {}
lsp.ccls.setup {}
lsp.jsonls.setup {}
lsp.pyls.setup {root_dir = lsp.util.root_pattern('.git', fn.getcwd())}
lspfuzzy.setup {}
map('n', '<space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

-------------------- TREE-SITTER ---------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

-------------------- COMMANDS ------------------------------
function close_buffer()
  if #fn.getbufinfo('')[1]['windows'] > 1 then cmd 'close'; return end
  local buflisted = fn.getbufinfo {buflisted = 1}
  local last_bufnr = buflisted[#buflisted]['bufnr']
  if fn.bufnr '' == last_bufnr then cmd 'bp' else cmd 'bn' end
  cmd 'bd #'
end

function toggle_wrap()
  opt('w', 'breakindent', not vim.wo.breakindent)
  opt('w', 'linebreak', not vim.wo.linebreak)
  opt('w', 'wrap', not vim.wo.wrap)
end

function warn_caps_lock()
  cmd 'echohl WarningMsg'
  cmd 'echo "Caps Lock may be on"'
  cmd 'echohl None'
end

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false, timeout = 200}'
cmd 'au TextYankPost * if v:event.operator is "y" && v:event.regname is "+" | call YankOSC52(getreg("+")) | endif'
