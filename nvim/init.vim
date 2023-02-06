set number          "Line numbers.
set relativenumber  "Relative line numbers.

set autoindent      "Copy indent when starting new line.
set smartindent     "Smart autoindent (using some rules for indent).

set smarttab        "Inserts blanks according to shiftwidth.
set shiftwidth=4    "Indent width in spaces.
set tabstop=4       "Number of spaces tab counts for.
set softtabstop=4   "Number of spaces tab counts for while editing.

set mouse=a         "Enable mouse support.
set wrap            "Displaying long lines on separate lines.
set noswapfile      "Remove swap file creation.
set updatetime=250  "Time in ms to update.

call plug#begin('~/AppData/Local/nvim/pluged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ap/vim-css-color'
Plug 'ryanoasis/vim-devicons'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'marko-cerovac/material.nvim'
Plug 'folke/zen-mode.nvim'
" post install (yarn install | npm install) then load plugin only for editing supported files
" MAKES NO FUCKING SENSE IN CPP FORMATING.
"Plug 'prettier/vim-prettier', {
 " \ 'do': 'yarn install --frozen-lockfile --production',
 " \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" Plug 'jeaye/color_coded'
call plug#end()

"CoC settings for comfortable using <TAB>
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

let g:coc_snippet_next = '<tab>'

"Shortcut for clang-format (cpp code formatter).
"map <C-K> :pyf /usr/share/clang/clang-format.py<cr>

"Shortcuts to switch between windows.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Open NERDTree on entering in NVim.
autocmd VimEnter * NERDTree

"Shortcuts for main NERDTree functions.
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFocus<CR>

"Text manipulations (highlight all, copy, paste).
nnoremap <C-a> ggVG
nnoremap <C-v> "*p
vnoremap <C-c> "*v

"Setting airline options and adding airline symbols.
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''


lua << EOF
require 'nvim-treesitter.install'.compilers = { 'clang++' }

vim.opt.list = true
require("indent_blankline").setup {space_char_blankline = " "}

vim.g.material_style = "deep ocean"

require('material').setup({

    contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = false, -- Enable darker background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { italic = true },
        strings = { --[[ bold = true ]] },
        keywords = { --[[ underline = true ]] },
        functions = { italic = true, bold = true },
        variables = {},
        operators = {},
        types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "gitsigns",
        -- "hop",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        -- "nvim-cmp",
        -- "nvim-navic",
        -- "nvim-tree",
        -- "nvim-web-devicons",
        -- "sneak",
        -- "telescope",
        -- "trouble",
        -- "which-key",
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false -- Enable higher contrast text for darker style
    },

    lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to everride the default colors, set this to a function

    custom_highlights = {}, -- Overwrite highlights with your own
})

vim.cmd 'colorscheme paramount'

EOF
