" Modeline and Notes {{{
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker nospell:

"          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"                     Version 2, December 2004
"
"   Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
"
"   Everyone is permitted to copy and distribute verbatim or modified
"   copies of this license document, and changing it is allowed as long
"   as the name is changed.
"
"             DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
"    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
"
"   0. You just DO WHAT THE FUCK YOU WANT TO.
" }}}

" Config {{{
  set nocompatible                                " Disable VI compatibility
  filetype plugin indent on                       " Automatically detect file types
  syntax on                                       " Syntax Highlight
  set autoread                                    " Re-read file if it was changed on disk
  set autowrite                                   " Write buffer on leave
  set shortmess=aoOtTc                            " Basically... truncate almost everything
  set viewoptions=cursor,folds,options,unix,slash " What to write for mkview
  set virtualedit=onemore                         " Allow virtual editing everything
  set history=250                                 " Moar history!
  set hidden                                      " allow switching buffers without writing
  set lazyredraw                                  " Don't redraw on every sneeze
  set completeopt=menuone,noinsert,noselect       " Always show completion menu, don't auto-insert/select
  set noshowmode                                  " Don't show current mode in status line
  set foldtext=FoldText()                         " Folds text
  set nowrap                                      " Don't wrap lines
  set nolinebreak                                 " Don't break lines
  set autoindent                                  " Indent at the same level of the previous line
  set shiftwidth=2                                " Use indents of 2 spaces
  set expandtab                                   " Tabs are spaces, not tabs
  set tabstop=2                                   " An indentation every 2 columns
  set softtabstop=2                               " Let backspace delete indent
  set splitright                                  " Puts new vsplit windows to the right of the current
  set splitbelow                                  " Puts new split windows to the bottom of the current
  set matchpairs+=<:>                             " Match, to be used with %
  set pastetoggle=<F11>                           " pastetoggle (sane indentation on pastes)
  set cursorline                                  " Highlight the line where cursor located
  set backspace=indent,eol,start                  " Better backspace navigation
  "set nu                                          " Line numbers
  "set rnu                                         " RELATIVE line numbers
  set showmatch                                   " Show matching bracket/parenthesis
  set winminheight=0                              " allow buffers to be 1 line high
  set wildmenu                                    " Show list instead of just completing
  set wildmode=list:longest,full                  " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]                   " Backspace and cursor keys wrap too
  set foldenable                                  " Enable folding by default
  set list                                        " Enable showing tabs, spaces and trailings
  set listchars=tab:┆\ ,trail:•,extends:#,nbsp:.  " Highlight problematic whitespace
  set signcolumn=yes                              " Always show signs column
  set scrolljump=5                                " Lines to scroll when cursor leaves screen
  set scrolloff=3                                 " Minimum lines to keep above and below cursor
  set nospell                                       " Enable spell checker
  set timeoutlen=500                              " Set shorter timeout for mappings
  " Search setup {{{
    set incsearch  " Find as you type
    set hlsearch   " Hilight search
    set ignorecase " Case insensitive search
    set smartcase  " Case sensitive when uc present
  " }}}

  " Map leader and local leader keys to <space> and , respectively {{{
    let mapleader=" "
    let localleader="\\"
  " }}}

  " Setting up the directories {{{
    set backup           " Backups are nice ...
    if has('persistent_undo')
      set undofile       " So is persistent undo ...
      set undolevels=250 " Maximum number of changes that can be undone
      set undoreload=500 " Maximum number lines to save for undo on a buffer reload
    endif
  " }}}

  " Mouse settings {{{
    set mouse=a   " Enable mouse
    set mousehide " Hide mouse cursor while typing
  " }}}

  " Set Encoding {{{
    scriptencoding utf-8
    set encoding=utf-8
  " }}}

  " Clipboard {{{
    if has('clipboard')       " There is a chance that CP is not available in nvim
        if has('unnamedplus') " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else                  " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
  " }}}

  " Windows {{{
    "if has('windows')
      "set shell=powershell shellquote=( shellpipe=\| shellredir=> shellxquote=
      "set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
    "endif
  " }}}


" }}}

" AutoCmd {{{
  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " Open help as rightmost split
  au FileType help wincmd L

  " Remove trailing whitespaces and ^M chars
  " To disable the stripping of whitespace, add the following to your
  autocmd FileType c,cpp,java,php,javascript,puppet,python,rust,twig,xml,yml,perl,lua autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" }}}

" VIM Mappings {{{
  " Disable EX mode
  nnoremap Q <nop>
  " Unmap Space from right
  nnoremap <Space> <nop>
  " Toggle Linebreaks and wraps
  nnoremap <silent><Leader>lb :set wrap!<CR> \| :set linebreak!<CR>
  " Force j/k to move by wraps and lines {{{
    noremap j gj
    noremap k gk
  " }}}
  " Add modeline to file
  nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
  " I'm too fast for handling shift {{{
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  " }}}
  " Fix yank defaults not yanking from cursor
  nnoremap Y y$
  " Code folding options {{{
      nmap <leader>f0 :set foldlevel=0<CR>
      nmap <leader>f1 :set foldlevel=1<CR>
      nmap <leader>f2 :set foldlevel=2<CR>
      nmap <leader>f3 :set foldlevel=3<CR>
      nmap <leader>f4 :set foldlevel=4<CR>
      nmap <leader>f5 :set foldlevel=5<CR>
      nmap <leader>f6 :set foldlevel=6<CR>
      nmap <leader>f7 :set foldlevel=7<CR>
      nmap <leader>f8 :set foldlevel=8<CR>
      nmap <leader>f9 :set foldlevel=9<CR>
      nmap <leader>f- :set foldmethod=manual<CR>
      nmap <leader>f= :set foldmethod=syntax<CR>
  " }}}
  " Clear search term (and it hilight :) )
  nmap <silent><Leader>/ :let @/=""<CR>
  " Visual shifting (does not exit Visual mode)  {{{
    vnoremap < <gv
    vnoremap > >gv
  " }}}
  " Allow using the repeat operator with a visual selection (!)
  vnoremap . :normal .<CR>
  " Write the file with sudo
  cmap w!! w !sudo tee % > /dev/null
  " Adjust splits evenly
  map <Leader>= <C-w>=

  " Toggle loclist
  nmap <silent> <leader>ql :call ToggleList("Location List", 'l')<CR>
  " Toggle qfix
  nmap <silent> <leader>qq :call ToggleList("Quickfix List", 'c')<CR>

  " NVim Terminal emulator mappings {{{
    if has('nvim')
      tnoremap <Esc> <C-\><C-n>
      tnoremap <C-h> <C-\><C-n><C-w>h
      tnoremap <C-j> <C-\><C-n><C-w>j
      tnoremap <C-k> <C-\><C-n><C-w>k
      tnoremap <C-l> <C-\><C-n><C-w>l
    endif
  " }}}

  " Fast buffer switching {{{
    map <S-H> :bp<CR>
    map <S-L> :bn<CR>
  " }}}

  " Easy splits navigation {{{
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-L> <C-W>l
    nnoremap <C-H> <C-W>h
  " }}}
  nnoremap <silent> <leader>fec :tabnew ~/AppData/Local/nvim/init.vim<CR>

" }}}

" Plugins {{{
  " Start plugin {{{
    call plug#begin('~/.vim/plugged')
  " }}}

  " Plugins List {{{
    " Frameworks and tools {{{
      " Nice comments
      Plug 'scrooloose/nerdcommenter'
      " File browser
      Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeFocus' }
      " Tagbar...
      Plug 'majutsushi/tagbar'
      " Hex editor in VIM
      Plug 'Shougo/vinarise.vim', { 'on': 'Vinarise' }
      " Close buffer without ruining splits
      Plug 'moll/vim-bbye'
      " Help with surrounding '"([{ etc
      Plug 'tpope/vim-surround'
      " Show neat indent guides
      Plug 'nathanaelkane/vim-indent-guides'
      " Easy motion in text
      Plug 'easymotion/vim-easymotion'
      " Fuzzy Finder, you don't need anything else
      Plug 'junegunn/fzf'
      Plug 'junegunn/fzf.vim'
      " Remove numbers in non text buffers
      "Plug 'myusuf3/numbers.vim'
      " Shows content of registers
      Plug 'junegunn/vim-peekaboo'
      " Allow repeat of much more
      Plug 'tpope/vim-repeat'
      " Easy and simple session save/restore
      Plug 'vim-scripts/sessionman.vim', { 'on': ['SessionOpen','SessionSave','SessionList'] }
      " Save and restore cursor position
      Plug 'vim-scripts/restore_view.vim'
      " East align stuff
      Plug 'junegunn/vim-easy-align'
      " Visual marks
      Plug 'kshenoy/vim-signature'
      " Syntax checker, linetr and what not
      "Plug 'w0rp/ale'
      " Auto format for different FTs
      Plug 'chiel92/vim-autoformat'
      " Neat fFtT helper WARNING slow as bureucracy
      "Plug 'unblevable/quick-scope'
      " Display nice [N/n] when searching
      Plug 'google/vim-searchindex'
      " Limit split width when there is too many
      Plug 'mattboehm/vim-accordion'
      " Undo tree
      Plug 'mbbill/undotree'
      " Rainbow parenthesis
      Plug 'luochen1990/rainbow'
      "Taskwarrior TUI
      Plug 'blindFS/vim-taskwarrior'
    " }}}

    " Autocomplete {{{
      " CoC LSP {{{
        Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
      " }}}
    " }}}

    " Snippets {{{
      Plug 'honza/vim-snippets'
    " }}}

    " Languages {{{
      " Polyglot - Mega language pack, syntax hilight, ident and ftplugs only {{{
        Plug 'sheerun/vim-polyglot'
      " }}}

      " Go {{{
        Plug 'fatih/vim-go', {'for': 'go'}
      " }}}

      " Markdown {{{
        Plug 'plasticboy/vim-markdown'
      " }}}

      " GoDot {{{
        Plug 'calviken/vim-gdscript3'
      " }}}

      " Clojure {{{
        Plug 'Olical/conjure', { 'tag': 'v2.1.2', 'do': 'bin/compile' }
        Plug 'eraserhd/parinfer-rust'
      " }}}
    " }}}

    " Theme {{{
      " Airline statusline
      Plug 'vim-airline/vim-airline'
      " Some themes for airline and bufferline
      Plug 'vim-airline/vim-airline-themes'
      " Themes for vim
      Plug 'flazz/vim-colorschemes'
      " Icons for filetypes
      "Plug 'ryanoasis/vim-devicons'
      Plug 'bling/vim-bufferline'
      " OneDark theme
      Plug 'joshdick/onedark.vim'
    " }}}

    " Git {{{
      Plug 'tpope/vim-fugitive'
      Plug 'airblade/vim-gitgutter'
      "Plug 'jaxbot/github-issues.vim'
      Plug 'junegunn/gv.vim'
      Plug 'jreybert/vimagit'
    " }}}
  " }}}

  " End Plugin {{{
    call plug#end()
  " }}}
" }}}

" Plugins Config {{{
  " Theme {{{
    "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
    if (empty($TMUX))
      if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
      endif
    endif
    set background=light    " Set dark for transparent window
    set guifont=Hack:h8    " Set font
    set termguicolors      " Set truecolor
    "colorscheme  Atelier_SulphurpoolDark " Nice color scheme
    colorscheme  onedark " Nice color scheme
    " Transaprency {{{
      "highlight Normal ctermbg=NONE
      "highlight NonText ctermbg=NONE
      " Cursor line coloring
      "hi CursorLine ctermbg=16 ctermfg=None
    " }}}
  " }}}

  " Rainbow {{{
    let g:rainbow_active = 1
  " }}}

  " NERDTree {{{
    nnoremap <silent><Leader>e :NERDTreeFocus<CR>
    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$',
      \ '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeMouseMode=2
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    let g:nerdtree_tabs_open_on_gui_startup=0
  " }}}

  " NERDCommenter {{{
    " Disable default mappings
    let NERDCreateDefaultMappings = 0
    " Map toggle comment
    map <silent><Leader>c<space> <Plug>NERDCommenterToggle
  " }}}

  " Autoformat {{{
    nnoremap <leader>q :Autoformat<CR>
  " }}}

  " Airline {{{
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#bufferline#enabled = 0
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#fugutive#enabled = 1
    let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#coc#enabled = 1
    let g:airline_theme = 'onedark'
  " }}}

  " Bufferline {{{
    let g:bufferline_rotate=1
  " "}}}

  " Tagbar {{{
    nnoremap <silent><Leader>t :TagbarOpen fjc<CR>
    let g:tagbar_left = 1
  " }}}

  " BBye {{{
    nnoremap <silent> <leader>d :Bdelete<CR>
  " }}}

  " Indent Guides {{{
    " Enable guides on vim startup
    let g:indent_guides_enable_on_vim_startup = 1
    " Set guides size to be slim
    let g:indent_guides_guide_size = 1
    " Disable guides for...
    let g:indent_guides_exclude_filetypes = ['help']
    " Disable indent guides mapping
    let g:indent_guides_default_mapping = 0
  " }}}

  " FZF {{{
    set rtp+=~/scoop/apps/fzf/current
    nmap <leader><tab> <Plug>(fzf-maps-n)
    imap <leader><tab> <Plug>(fzf-maps-i)
    xmap <leader><tab> <Plug>(fzf-maps-x)
    nnoremap <Leader>bf :GFiles<CR>
    nnoremap <Leader>bF :Files<CR>
    nnoremap <Leader>bb :Buffers<CR>
    " fast buffers access
    nnoremap <Leader><Space> :Buffers<CR>
    nnoremap <Leader>bb :Buffers<CR>
    nnoremap <Leader>bg :Ag 
    nnoremap <Leader>bl :BLines<CR>
    nnoremap <Leader>bL :Lines<CR>
    nnoremap <Leader>bt :BTags<CR>
    nnoremap <Leader>bc :Commands<CR>
    nnoremap <Leader>bp :Commits<CR>

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    " Enable history C-P & C-N
    " Shadowing up and down, FIXME
    "let g:fzf_history_dir = '~/.local/share/fzf-history'

    " A bit of theming
    let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Background'],
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
  " }}}

  " CoC {{{
    " Extensions could be used for CoC to have more powerful features
    " Here is the list:
    " https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions << Explanation
    " https://www.npmjs.com/search?q=keywords%3Acoc.nvim << Actual list

    " use <tab> for trigger completion and navigate to next complete item
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    " Next by Tab
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#rpc#request('doKeymap', ['snippets-expand', "\<TAB>"])

    " Previous by Tab
    inoremap <silent><expr><S-Tab>
          \ pumvisible() ? "\<C-p>" :
          \<SID>check_back_space() ? "\<S-Tab>" :
          \ coc#rpc#request('doKeymap', ['snippets-expand', "\<S-Tab>"])

    " use <c-space>for trigger completion
    imap <expr><c-space> coc#refresh()

    " Don't go to new line on enter when completing
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " Use <C-l> to trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> to select text for visual text of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " Show doc
    function! s:show_doc() 
      if &filetype == 'vim'
        execute 'h ' . expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
    nnoremap <silent> K :call <SID>show_doc()<CR>
    nnoremap <silent><leader>dh :call <SID>show_doc()<CR>

    " GoTos
    nnoremap <silent><leader>gd :call CocAction('jumpDefinition')<CR>
    nnoremap <silent><leader>gl :call CocAction('jumpDeclaration')<CR>
    nnoremap <silent><leader>gi :call CocAction('jumpImplementation')<CR>

    " Diag navigation
    nnoremap <silent><leader>ge :call CocActionAsync('diagnosticList', 'error')<CR>
    nnoremap ]e :call CocActionAsync('diagnosticNext', 'error')<CR>
    nnoremap [e :call CocActionAsync('diagnosticPrevious', 'error')<CR>

    " Other helpful stuff
    nnoremap <silent><leader>gc :call CocAction('codeAction')<CR>
    nnoremap <silent><leader>gr :call CocAction('rename')<CR>
    nnoremap <silent><leader>gq :call CocAction('quickfixes')<CR>
    nnoremap <silent><leader>gL :CocList<CR>
  " }}}

  " Numbers {{{
    let g:numbers_exclude = ['help', 'fzf', 'tagbar', 'gundo', 'vimshell',
      \ 'nerdtree', 'startify', 'w3m', 'Mundo', 'MundoDiff', 'terminal']
  " }}}

  " Markdown {{{
    let g:vim_markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'typescript',
        \ 'go', 'python', 'py=python', 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
  " }}}

  " ALE {{{
    let g:ale_statusline_format = ['E%d', 'W%d', 'K']
    let g:ale_lint_delay = 350
    let g:ale_sign_column_always = 1
    let g:ale_warn_about_trailing_whitespace = 0
  " }}}

  " Sessionman {{{
    " Open session
    nmap <leader>sl :SessionList<CR>
    " Save session
    nmap <leader>ss :SessionSave<CR>
  " }}}

  " Fugutive {{{
    " Stage file
    nmap <silent><Leader>gw :Gwrite<CR>
    " Git status
    nmap <silent><Leader>gs :Gstatus<CR>
    " Commit staged changes
    nmap <silent><Leader>gc :Gcommit<CR>
  " }}}

  " vim-go {{{
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_types = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_build_constraints = 1
    let g:go_fmt_command = "goimports"
    let g:go_fmt_expiremental = 1
    let g:go_term_enabled = 1
    " Mappings {{{
      au FileType go nmap <buffer><silent><localleader>r <Plug>(go-run)
      au FileType go nmap <buffer><silent><localleader>i <Plug>(go-info)
      au FileType go nmap <buffer><silent><localleader>t <Plug>(go-test-func)
      au FileType go nmap <buffer><silent><localleader>d <Plug>(go-doc-vertical)
      au FileType go nmap <buffer><silent><localleader>e <Plug>(go-run)
      au FileType go nmap <buffer><silent><localleader>f :GoFillStruct<CR>
    " }}}
  " }}}

  " Accordion {{{
    " Start accordion with 3 splits by default
    nmap <leader>as :AccordionAll 3<CR>
    " Stop layout management
    nmap <silent><leader>aS :AccordionStop<CR>
    " -1 split visible
    nmap <silent><leader>ai :AccordionZoomIn<CR>
    " +1 split visible
    nmap <silent><leader>ao :AccordionZoomOut<CR>
  " }}}

  " OneDark {{{
    " Allow italic text in terminal
    let g:onedark_terminal_italics=1
  " }}}

  " Conjure {{{
  " }}}
" }}}

" Functions {{{
  " Fold text formatting {{{
    let defaults = {'placeholder': 'Ⱝ', 'line': 'ᚚ', 'whole': 'ᛈ',
    \       'level': 'ᛝ', 'division': '/', 'multiplication': '*',
    \       'epsilon': 'έ'}
    let defaults['denominator'] = 25
    let defaults['gap'] = 4

    if !exists('g:FoldText_placeholder')
      let g:FoldText_placeholder = defaults['placeholder']
    endif
    if !exists('g:FoldText_line')
      let g:FoldText_line = defaults['line']
    endif
    if !exists('g:FoldText_whole')
      let g:FoldText_whole = defaults['whole']
    endif
    if !exists('g:FoldText_level')
      let g:FoldText_level = defaults['level']
    endif
    if !exists('g:FoldText_division')
      let g:FoldText_division = defaults['division']
    endif
    if !exists('g:FoldText_multiplication')
      let g:FoldText_multiplication = defaults['multiplication']
    endif
    if !exists('g:FoldText_epsilon')
      let g:FoldText_epsilon = defaults['epsilon']
    endif
    if !exists('g:FoldText_denominator')
      let g:FoldText_denominator = defaults['denominator']
    endif
    if g:FoldText_denominator >= &maxfuncdepth
      let g:FoldText_denominator = &maxfuncdepth - 1
    endif
    if !exists('g:FoldText_gap')
      let g:FoldText_gap = defaults['gap']
    endif

    unlet defaults


    function! s:FractionsBetween(lo, hi, denominator)
      " Find all fractions between [a, b] and [c, d] with denominator equal
      " to `a:denominator'
      let lo = a:lo[0] / a:lo[1]
      let hi = a:hi[0] / a:hi[1]
      let fractions = []
      let n = 1.0
      while n < a:denominator
        let p = n / a:denominator
        if p > lo && p < hi
          call add(fractions, [n, a:denominator])
        endif
       let n += 1
      endwhile
        return fractions
    endfunction

    function! s:FractionSearch(proportion, denominator)
      " Search for the nearest fraction, used by s:FractionNearest().
      if a:denominator == 1
        return [[0.0, 1], [1.0, 1]]
      endif

      let [lo, hi] = s:FractionSearch(a:proportion, a:denominator - 1)
      let fractionsBetween = s:FractionsBetween(lo, hi, a:denominator)
      for fraction in fractionsBetween
        let f = fraction[0] / fraction[1]
        if a:proportion >= f
          let lo = fraction
        else
          let hi = fraction
          break
        endif
      endfor
      return [lo, hi]
    endfunction

    function! s:FractionNearest(proportion, maxDenominator)
      " Find the neareset fraction to `a:proportion' (which is a float),
      " but using fractions with denominator less than `a:maxDenominator'.
      let [lo, hi] = s:FractionSearch(a:proportion, a:maxDenominator)
      let mid = (lo[0] / lo[1] + hi[0] / hi[1]) / 2
      if a:proportion > mid
        return hi
      else
        return lo
      endif
    endfunction

    function! s:FractionFormat(fraction)
      " Format a fraction: [a, b] --> 'a/b'
      let [n, d] = a:fraction
      if n == 0.0
        return g:FoldText_epsilon
      endif
      if d != 1
        return printf("%.0f%s%d", n, g:FoldText_division, d)
      endif
      return printf("%.0f", n)
    endfunction

    function! FoldText()
      " Returns a line representing the folded text
      "
      " A fold across the following:
      "
      " fu! MyFunc()
      "    call Foo()
      "    echo Bar()
      " endfu
      "
      " should, in general, produce something like:
      "
      " fu! MyFunc() <...> endfu                    L*15 O*2/5 Z*2
      "
      " The folded line has the following components:
      "
      "   - <...>           the folded text, but squashed;
      "   - endfu           the last line (where applicable);
      "   - L*15            the number of lines folded (including first);
      "   - O*2/5           the fraction of the whole file folded;
      "   - Z*2             the fold level of the fold.
      "
      " You may also define any of the following strings:
      "
      " let g:FoldText_placeholder = '<...>'
      " let g:FoldText_line = 'L'
      " let g:FoldText_level = 'Z'
      " let g:FoldText_whole = 'O'
      " let g:FoldText_division = '/'
      " let g:FoldText_multiplication = '*'
      " let g:FoldText_epsilon = '0'
      " let g:FoldText_denominator = 25
      "
      let fs = v:foldstart
      while getline(fs) =~ '^\s*$'
        let fs = nextnonblank(fs + 1)
      endwhile
      if fs > v:foldend
        let line = getline(v:foldstart)
      else
        let spaces = repeat(' ', &tabstop)
        let line = substitute(getline(fs), '\t', spaces, 'g')
      endif

      let foldEnding = strpart(getline(v:foldend), indent(v:foldend), 3)

      let endBlockChars = ['end', '}', ']', ')']
      let endBlockRegex = printf('^\s*\(%s\);\?$', join(endBlockChars, '\|'))
      let endCommentRegex = '\s*\*/$'
      let startCommentBlankRegex = '\v^\s*/\*!?\s*$'

      if foldEnding =~ endBlockRegex
          let foldEnding = " " . g:FoldText_placeholder . " " . foldEnding
      elseif foldEnding =~ endCommentRegex
        if getline(v:foldstart) =~ startCommentBlankRegex
          let nextLine = substitute(getline(v:foldstart + 1), '\v\s*\*', '', '')
          let line = line . nextLine
        endif
        let foldEnding = " " . g:FoldText_placeholder . " " . foldEnding
      else
        let foldEnding = " " . g:FoldText_placeholder
      endif
      let foldColumnWidth = &foldcolumn ? 1 : 0
      let numberColumnWidth = &number ? strwidth(line('$')) : 0
      let width = winwidth(0) - foldColumnWidth - numberColumnWidth - g:FoldText_gap

      let foldSize = 1 + v:foldend - v:foldstart
      let foldSizeStr = printf("%s%s%s", g:FoldText_line, g:FoldText_multiplication, foldSize)

      let foldLevelStr = g:FoldText_level . g:FoldText_multiplication . v:foldlevel . " "

      let proportion = (foldSize * 1.0) / line("$")
      let foldFraction = s:FractionNearest(proportion, g:FoldText_denominator)
      let foldFractionStr = printf(" %s%s%s ", g:FoldText_whole, g:FoldText_multiplication, s:FractionFormat(foldFraction))
      let ending = foldSizeStr . foldFractionStr . foldLevelStr

      if strwidth(line . foldEnding . ending) >= width
        let line = strpart(line, 0, width - strwidth(foldEnding . ending))
      endif

      let expansionStr = repeat(" ", g:FoldText_gap + width - strwidth(line . foldEnding . ending) - 3)
      return line . foldEnding . expansionStr . ending
    endfunction
  " }}}

  " Add modeline {{{
    function! AppendModeline()
      let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
        \ &tabstop, &shiftwidth, &textwidth, &fdm, &expandtab ? '' : 'no')
      let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
      call append(line("$"), l:modeline)
    endfunction
  "}}}

  " Strip whitespace {{{
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
  " }}}

  " Toggle Location/Quickfix buffers {{{
    function! GetBufferList()
      redir =>buflist
      silent! ls!
      redir END
      return buflist
    endfunction

    function! ToggleList(bufname, pfx)
      let buflist = GetBufferList()
      for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
          exec(a:pfx.'close')
          return
        endif
      endfor
      if a:pfx == 'l' && len(getloclist(0)) == 0
          echohl ErrorMsg
          echo "Location List is Empty."
          return
      endif
      let winnr = winnr()
      exec(a:pfx.'open')
      if winnr() != winnr
        wincmd p
      endif
    endfunction

  " }}}

  " Init Directories (stolen from spf13) {{{
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif
        for [dirname, settingname] in items(dir_list)
            let directory = parent . '/.' . prefix . '/' . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
  " }}}
" }}}
