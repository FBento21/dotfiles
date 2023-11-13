" GENERAL COMMANDS:

" Set the leader key to a space
let mapleader = "\<space>"
" Set the maximum amount of lines to scroll when moving the cursor off the screen
set nocompatible
" Center buffer
set scrolloff=999
" Enable mouse support
set mouse=a
" Copy/paste to system clipboard on Wayland
autocmd TextYankPost * if (v:event.operator == 'y' || v:event.operator == 'd') | silent! execute 'call system("wl-copy", @")' | endif
nnoremap p :let @"=substitute(system("wl-paste"), '<C-v><C-m>', '', 'g')<cr>p
" Highlight on search
set hlsearch
" Clear search highlighting with Ctrl-l
nnoremap <C-l> :noh<CR>
" Enable line numbers
set number
set nornu
" Highlight matching parenthesis
set showmatch
" Enable folding with 'marker' method
set foldmethod=marker
" Line length marker at 80 columns
set colorcolumn=80
" Vertical split to the right
set splitright
" Horizontal split to the bottom
set splitbelow
" Ignore case letters when searching
set ignorecase
" Ignore lowercase for the whole pattern if there's any uppercase character
set smartcase
" Wrap on word boundary
set linebreak
" Enable 24-bit RGB colors
set termguicolors
" Set global statusline
set laststatus=1
" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
" Disable auto-commenting new lines
autocmd BufEnter * set fo-=c fo-=r fo-=o
" Use Visual lines
nnoremap j gj
nnoremap k gk
" Use spaces instead of tabs
set expandtab
" Number of spaces for each shiftwidth
set shiftwidth=4
" Number of spaces for a tab character
set tabstop=4
" Enable smart indenting
set smartindent
"utf-8 enconding
set encoding=utf-8
" Add menu in the bottom bar
set wildmenu
" Substitute visually selected text with C-r
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Highlight current line
set cursorline
" Spell check
set spell
" Automatically open in the correct dir
set autochdir


" Vim-Plug:
call plug#begin()
    Plug 'lervag/vimtex'
        " let g:tex_flavor='latex'
        let g:vimtex_view_method='zathura_simple'
        let g:vimtex_compiler_engine = 'lualatex'
    Plug 'Mofiqul/dracula.nvim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'windwp/nvim-autopairs'
    Plug 'mhinz/vim-startify'
    Plug 'preservim/nerdtree'
call plug#end()

" Vimtex
let g:vimtex_matchparen_enabled = 0
let g:vimtex_syntax_enabled = 0
let g:vimtex_delim_stopline = 250
let g:vimtex_motion_matchparen = 0
let g:vimtex_indent_enabled = 0

"Theme
colorscheme dracula
hi Normal guibg=NONE ctermbg=NONE

" Open Vim in the last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"Coc configs
set nobackup
set nowritebackup
set updatetime=100
set signcolumn=yes

" Tab complete with snippets
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
set pumheight=20

" Togleterm
lua require("toggleterm").setup()
lua require("toggleterm-config")
" Define a mapping that checks the file type and runs the Python script
function! RunCode()
    if &filetype ==# 'python'
        " Save the buffer
        w
        " Run the Python script in a terminal
        execute 'TermExec cmd="python %"'
    elseif &filetype ==# 'c'
        " Save the buffer
        w
        " Compile the C code to create an executable (adjust the compiler and flags as needed)
        let l:source_file = expand('%')
        let l:executable_file = fnamemodify(l:source_file, ':t:r')
        let l:compiler = 'gcc'
        let l:compiler_flags = '-o ' . l:executable_file
        execute 'TermExec cmd="' . l:compiler . ' ' . l:compiler_flags . ' ' . l:source_file . '"'
        " Run the compiled executable
        execute 'TermExec cmd="./' . l:executable_file . '"'
    else
        " Inform the user if the file is not a Python script
        echo "Not a Python file (filetype: " . &filetype . ")"
    endif
endfunction

" Map F5 to run the Python script
nnoremap <F5> :call RunCode()<CR>

" Lualine
lua require('lualine').setup()

" Debug python code
lua require('dap-python').setup('/usr/bin/python')
lua require('dap-config')
lua require("dapui").setup()

" Autopairs
lua require("nvim-autopairs").setup()

" Treesitter
lua << EOF

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"python"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

EOF

" Set title for the swallowing
set title
set titlestring=NVIM
