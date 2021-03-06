" ░█░█░▀█▀░█▄█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
" ░▀▄▀░░█░░█░█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
" ░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀

" Set leader key to <space>
let mapleader = "\<Space>"
set shell=/bin/zsh

" Imports {{{
let $conf_path = "$HOME/.config/nvim"

source $conf_path/coc.vim 
source $conf_path/plugs.vim
source $conf_path/maps.vim
"}}}

" general settings {{{
set nobackup
set nowritebackup
set noswapfile
set dir=/tmp
" }}}

" Colorscheme madness {{{
" let g:material_terminal_italics = 1
" let g:material_theme_style = 'darker'
" let g:material_theme_terminal_italics=1

" Not so much a dusty chalkboard
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_palette = 'material'
let g:gruvbox_material_visual = 'green background'
let g:_material_cursor = 'auto'
let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_invert_selection= 0

" let g:tokyonight_style = 'storm' " available: night, storm
" let g:tokyonight_enable_italic = 1
" let g:daycula_enable_italic = 1
" let g:daycula_current_word = 'underline'
" let g:sonokai_style = 'espresso'
" let g:sonokai_enable_italic = 1
" let g:material_terminal_italics = 1
" let python_highlight_all=1
set fillchars+=vert:│
augroup colorscheme_change | au!
    au ColorScheme * hi Comment gui=italic cterm=italic
    au ColorScheme * hi JsThis gui=italic cterm=italic
    au ColorScheme * hi JsClassKeyword gui=italic cterm=italic
    " au ColorScheme * hi Keyword gui=italic cterm=italic
    au ColorScheme * hi pythonClassKeyword gui=italic cterm=italic
    au ColorScheme * hi pythonClassVar gui=italic
    if &background != "dark"
        au ColorScheme toast hi Normal guibg=#d9d9d9
        au ColorScheme isaac hi Normal guibg=#d9d9d9
        au ColorScheme polar hi Normal guibg=#d9d9d9
    else
        au ColorScheme toast hi Normal guibg=#18191E
        au ColorScheme tokyonight hi Normal guibg=#18191E
        " au ColorScheme material hi Normal guibg=#18191E
    endif
augroup END

set termguicolors
colo dracula
" colo gruvbox-material
set background=dark
"}}}

" vim-devicons {{{
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[''] = "\uf15b"
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
"}}}

" Float Term {{{
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
"}}}

" Better whitespaces {{{
" set list
" set fillchars=vert:\│
" set listchars=tab:-▸,eol:↲,extends:»,precedes:«,space:•
set list
set listchars=
set listchars+=tab:›\ ,
set listchars+=trail:•,
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
" set listchars=tab:┊\ ,nbsp:␣,space:•,extends:>,precedes:<,trail:•
"}}}

" Markdown {{{
let g:vim_markdown_folding_disabled = 1
" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0
" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1
" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
" Pandoc syntax
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END
"}}}

" Closetag {{{
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,javascript'
"}}}

" Colorizer {{{
"------------------------------------------------------------------------------
lua require'colorizer'.setup()
"}}}

" NERDTree {{{
" set autochdir
let NERDTreeChDirMode=1
nnoremap <leader>n :NERDTree .<CR>
nmap <C-n> :NERDTreeToggle<CR>

let g:NERDTreeMinimalUI           = 1
let g:NERDTreeWinPos              = 'left'
let g:NERDTreeWinSize             = 20
let g:NERDTreeStatusline          = "  "
let g:NERDTreeDirArrowExpandable  = '+'
let g:NERDTreeDirArrowCollapsible = '-'
"}}}

" Illuminate {{{
"------------------------------------------------------------------------------
let g:Illuminate_ftblacklist = ['javascript', 'jsx', 'html']
" }}}

" Indenting {{{
augroup plaintext
    autocmd!
    autocmd FileType text setlocal ts=2 sts=2 sw=2 expandtab textwidth=80 colorscheme
augroup END

augroup webdev
    autocmd!
    autocmd FileType less,css,html,js?,ts? setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType less,css,html nnoremap <Leader>s viB:sort<cr>
augroup END

augroup restorecursor
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   execute "normal! g`\"" |
augroup END
                \ endif
" }}}

" Indent line {{{
"------------------------------------------------------------------------------
let g:indentLine_char = '▏'
let g:indentLine_color_gui = '#565e6e'
let g:indentLine_setColors = 1
" }}}

" Git Settings {{{
" Twiggy {{{
let g:twiggy_group_locals_by_slash = 0
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_remote_branch_sort = 'date'
"}}}

" Git Gutter {{{
let g:gitgutter_enabled = 1
let g:gitgutter_override_sign_column_highlight = 0

let g:gitgutter_sign_added                     = '+'
let g:gitgutter_sign_modified                  = '±'
let g:gitgutter_sign_removed                   = '-'
let g:gitgutter_sign_removed_first_line        = '×'
let g:gitgutter_sign_modified_removed          = '×'
"}}}
" Git Settings }}}

" FZF {{{
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_buffers_jump = 0

map <leader>p :Files<CR>
nnoremap <C-b> :Buffers<CR>

map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'

"let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
"let $FZF_DEFAULT_OPTS="--reverse "                      " top to bottom

let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**' -g '!{node_modules,.git}'"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)
"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)


" Get text in files with Rg
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep(
"   \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,

 " Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
"}}}

" Defaults {{{
syntax enable
set hidden
set colorcolumn=80

set t_Co=256
set encoding=utf-8
set fileencoding=utf-8
" Unix as standard
set ffs=unix,dos,mac

set pumheight=10
set ruler
set cmdheight=2
set mouse=a
set splitbelow
set splitright
set conceallevel=0
set wildmenu
set autoread
au FocusGained,BufEnter * checktime

" Testing with path ** disabled
" set path+=**
set updatetime=100

" Indentation {{{
set smarttab
set expandtab
set smartindent
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
"}}}


set number
set relativenumber

set laststatus=2
set showtabline=2
set noshowmode
set shortmess+=c
set signcolumn=yes
set timeoutlen=500

" Default search
set incsearch
set hlsearch
set smartcase

set formatoptions-=cro
set iskeyword-=_
set clipboard=unnamedplus

set visualbell
set title

set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Ignored filetype {{{
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*
" }}}

" Code folding {{{
set foldnestmax=3
set foldlevel=2
" Start code folded
set foldlevelstart=0
set foldnestmax=10
set foldcolumn=2
set foldmethod=syntax
" Set fold method mark base on filytype
autocmd FileType vim setlocal foldmethod=marker
autocmd FileType html setlocal foldmethod=indent
autocmd FileType js call JavaScriptFold()

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
"}}}
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Undo {{{
try
    set undodir=~/.config/nvim/temp_dirs/undodir
    set undofile
catch
endtry
"}}}
"}}}

" Helper functions {{{
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction
"}}}


