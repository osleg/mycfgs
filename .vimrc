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

" Environment {{{
    set nocompatible            " Must be first line
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    set encoding=utf8
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif
    set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxcoOtT         " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=250                     " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    set lazyredraw                      " Don't redraw on macros
    set iskeyword+=.                    " '.' is an end of word designator
    set iskeyword+=#                    " '#' is an end of word designator
    set iskeyword+=-                    " '-' is an end of word designator

    " Set completeopt to menuone only to disable the preview =_=
    set completeopt=menuone

    " Set russian support
    "set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
    "set keymap=russian-juukenwin

    set iminsert=0
    set imsearch=0
    "highlight lCursor guifg=NONE guibg=Cyan

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " Open help as rightmost split
    autocmd FileType help wincmd L

    " Restore cursor to position of last editing session
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Make sure we are not in pager mode
    let $PAGER=''

    " Disable ex mode
    nnoremap Q <nop>

    " Setting up the directories {{{
        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=250         " Maximum number of changes that can be undone
            set undoreload=500        " Maximum number lines to save for undo on a buffer reload
        endif
    " }}}
" }}}

" Plugins {{{
  " Plugins List {{{
    " Start plugin {{{
      call plug#begin('~/.vim/plugged')
    " }}}

    " Unite {{{
      Plug 'Shougo/vimproc.vim', { 'do': 'make' }
      Plug 'Shougo/unite.vim'
      Plug 'Shougo/neomru.vim'
      Plug 'hewes/unite-gtags'
      Plug 'Shougo/unite-outline'
      Plug 'Shougo/unite-help'
      Plug 'osyo-manga/unite-quickfix'
      Plug 'lambdalisue/unite-grep-vcs'
      Plug 'Shougo/vimproc.vim'
      Plug 'Shougo/vimfiler.vim'
    " }}}

    " Git {{{
      " TODO: Map
      Plug 'tpope/vim-fugitive'
      " TODO: Setup
      Plug 'jaxbot/github-issues.vim'
      " TODO: Remap
      Plug 'airblade/vim-gitgutter'

      Plug 'mattn/gist-vim'
    " }}}

    " Buffers {{{
      Plug 'moll/vim-bbye'
      " TODO: Map
      Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    " }}}

    " Database {{{
      Plug 'vim-scripts/dbext.vim'
    " }}}

    " General {{{
      " Search and replace on steroids
      Plug 'dyng/ctrlsf.vim'
      Plug 'kristijanhusak/vim-multiple-cursors'

      Plug 'vim-scripts/gtags.vim'
      Plug 'flazz/vim-colorschemes'
      Plug 'Chiel92/vim-autoformat'
      Plug 'myusuf3/numbers.vim'
      Plug 'farseer90718/vim-taskwarrior'
      " Shows content of registers
      Plug 'junegunn/vim-peekaboo'
      " Scratch on n|vmap gs
      Plug 'mtth/scratch.vim'
      Plug 'tpope/vim-surround'
      Plug 'tpope/vim-repeat'
      Plug 'vim-scripts/sessionman.vim', { 'on': ['SessionOpen','SessionSave','SessionList'] }
      Plug 'Lokaltog/vim-easymotion'
      Plug 'sjl/gundo.vim'
      Plug 'nathanaelkane/vim-indent-guides'
      Plug 'vim-scripts/restore_view.vim'
      Plug 'osyo-manga/vim-over'
    " }}}

    " General Programming {{{
      Plug 'embear/vim-localvimrc'
      Plug 'kshenoy/vim-signature'
      Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
      Plug 'wesQ3/vim-windowswap'
      Plug 'Shougo/vinarise.vim', { 'on': 'Vinarise' }
      Plug 'scrooloose/nerdcommenter'
      Plug 'majutsushi/tagbar'
      Plug 'rizzatti/dash.vim'
      Plug 'w0rp/ale' " Syntax checker
      Plug 'thinca/vim-quickrun'
      Plug 'jiangmiao/auto-pairs'
    " }}}

    " Snippets & AutoComplete {{{
      Plug 'Valloric/YouCompleteMe'
      Plug 'jmcantrell/vim-virtualenv', has('gui') ? {'for': ['python']} : {}
      Plug 'SirVer/ultisnips'
      Plug 'honza/vim-snippets'
    " }}}

    " Theme {{{
      Plug 'bling/vim-airline'
      Plug 'bling/vim-bufferline'
      Plug 'vim-airline/vim-airline-themes'
    " }}}

    " OrgMode {{{
      Plug 'jceb/vim-orgmode', { 'for': ['orgmode', 'org'] }
      Plug 'dhruvasagar/vim-table-mode'
      Plug 'tpope/vim-speeddating'
      Plug 'chrisbra/NrrwRgn'
      Plug 'osleg/calendar-vim', { 'for': ['orgmode', 'org'] }
      Plug 'vim-scripts/SyntaxRange'
      Plug 'vim-scripts/utl.vim', { 'for': ['orgmode', 'org'] }
    " }}}

    " Languages {{{
      " Python {{{
        "Plug 'klen/python-mode', { 'for': 'python', 'branch': 'develop' }
      " }}}

      " Lua {{{
        Plug 'xolox/vim-lua-ftplugin', { 'for': 'lua' }
        Plug 'xolox/vim-misc', { 'for': 'lua' }
      " }}}

      " C | C++ {{{
        Plug 'vim-scripts/c.vim'
        Plug 'vim-scripts/a.vim'
      "}}}

      " Go {{{
        Plug 'fatih/vim-go'
      " }}}

      " Javascript {{{
        Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'typescript'] }
        Plug 'elzr/vim-json', { 'for': ['javascript', 'typescript', 'json'] }
        Plug 'moll/vim-node', { 'for': ['javascript', 'typescript'] }
        Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
      " }}}

      " HTML {{{
        Plug 'amirh/HTML-AutoCloseTag', { 'for': ['html', 'htmljinja'] }
        Plug 'hail2u/vim-css3-syntax', { 'for': ['html', 'htmljinja', 'css', 'scss'] }
        Plug 'gorodinskiy/vim-coloresque', { 'for': ['html', 'htmljinja'] }
        Plug 'mitsuhiko/vim-jinja', { 'for': ['html', 'htmljinja'] }
        Plug 'mattn/emmet-vim', { 'for': ['html', 'htmljinja'] }
      " }}}

      " Rust {{{
        Plug 'wting/rust.vim', { 'for': 'rust' }
      " }}}
      
      " RAML {{{
        Plug 'IN3D/vim-raml', { 'for': 'raml' }
      " }}}
    " }}}

    " End plugin {{{
      call plug#end()
    " }}}
  " }}}

  " Plugins Config {{{
    " Calendar {{{
      let g:calendar_filetype = 'org'
      let g:calendar_diary = '~/.diary'
      let g:calendar_diary_extension = '.org'
    " }}}
    " Numbers {{{
      let g:numbers_exclude = ['unite', 'tagbar', 'startify',
          \ 'gundo', 'vimshell', 'w3m', 'nerdtree', 'calendar', 'vimfiler']
    " }}}"
    " UTL Configuration {{{
      let g:utl_cfg_hdl_scm_http_system = "silent !firefox '%u#%f' 2>/dev/null 1>&2 &"
    " }}}
    " C stuff {{{
      let g:formatprg_args_expr_c = '"--mode=c --style=linux -pcH".(&expandtab ? "s".&shiftwidth : "t")'
      let g:formatprg_args_expr_cpp = '"--mode=c --style=linux -pcH".(&expandtab ? "s".&shiftwidth : "t")'
      noremap   \a        :A<CR>
      inoremap   \a   <C-C>:A<CR>
      let g:alternateNoDefaultAlternate = 1
    "}}}
    " Ctags {{{
      set tags=./tags;/,~/.vimtags

      " Make tags placed in .git/tags file available in all levels of a repository
      let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
      if gitroot != ''
          let &tags = &tags . ',' . gitroot . '/.git/tags'
      endif
    " }}}
    " AutoCloseTag {{{
      " Make it so AutoCloseTag works for xml and xhtml files as well
      au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    " }}}
    " NerdTree {{{
      map <leader>e <plug>NERDTreeTabsToggle<CR>
      map <C-e> :NERDTreeFind<CR>

      let NERDTreeShowBookmarks=1
      let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
      let NERDTreeChDirMode=0
      let NERDTreeQuitOnOpen=1
      let NERDTreeMouseMode=2
      let NERDTreeShowHidden=1
      let NERDTreeKeepTreeInNewTab=1
      let g:nerdtree_tabs_open_on_gui_startup=0
    " }}}
    " Session List {{{
      set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    " }}}
    " JSON {{{
      let g:vim_json_syntax_conceal = 0
    " }}}
    " YouCompleteMe {{{
      " Enable omni completion.
      autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
      autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
      "autocmd FileType javascript,typescript setlocal omnifunc=javascriptcomplete#CompleteJS
      autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
      autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
      autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
      autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

      " Seed identifiers from syntax files
      let g:ycm_seed_identifiers_with_syntax = 1
      let g:ycm_autoclose_preview_window_after_completion = 1
      let g:ycm_autoclose_preview_window_after_insertion = 1
    " }}}
    " Airline {{{
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tagbar#enabled = 1
      let g:airline#extensions#default#section_truncate_width = {
          \ 'b': 79,
          \ 'x': 60,
          \ 'y': 88,
          \ 'z': 45,
          \ 'warning': 80,
          \ 'error': 80,
          \ }


      "let g:airline#extensions#bufferline#enabled = 0
    " }}}
    " {{{ Python-mode
      let g:pymode_rope = 1
      let g:pymode_virtualenv = 0
      let g:pymode_lint_checkers = ['pep8']
    " }}}
    " UltiSnips {{{
      let g:UltiSnipsExpandTrigger="<c-j>"
      let g:UltiSnipsListSnippets="<c-s-j>"
    " }}}
    " LocalVimRC {{{
      let g:localvimrc_persistent=1
    " }}}
    " CtrlSF {{{
      let g:ctrlsf_ackprg='ag'
    " }}}
    " Ale {{{
      let g:ale_statusline_format = ['E%d', 'W%d', 'K']
      let g:ale_lint_delay = 350
      let g:ale_sign_column_always = 1
      let g:ale_warn_about_trailing_whitespace = 0
    " }}}
    " Auto-pairs {{{
      let g:AutoPairsFlyMode = 0
      let g:AutoPairsShortcut = '<Leader>pp'
    " }}}

  " }}}
" }}}

" Configuration {{{
  " Vim UI {{{
    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    set background=dark         " Dark background
    set guifont=Terminus\ (TTF):h14
    set noantialias
    colorscheme jellybeans
    set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    highlight Normal ctermbg=NONE
    "highlight NonText ctermbg=250 ctermfg=250

    set cursorline                  " Highlight current line

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set rnu                         " Set relative numbering
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 1 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set noea                        " Don't resize windows on buffers split/close

    if has('gui')
      set guioptions=ag
    endif
  " }}}

  " Formatting {{{
    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=2                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=2                   " An indentation every four columns
    set softtabstop=2               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F11>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your
    autocmd FileType c,cpp,java,php,javascript,puppet,python,rust,twig,xml,yml,perl,lua autocmd BufWritePre <buffer> call StripTrailingWhitespace()

    "autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
    " preceding line best in a plugin but here for now.

    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell,rust setlocal nospell
  " }}}
" }}}

" Keymappings {{{
  " General mappings {{{
    " General {{{
      "Unremap space from "Right"
      nnoremap <Space> <Nop>
      let mapleader = ","
      let localleader = '\'
      " Set toggle line wraps
      nmap <Leader>lb :set wrap!<CR> \| :set linebreak!<CR>
      nmap <Leader>va :VEAct 
    " }}}

    " vim-signature {{{
      nnoremap <Leader>mt :SignatureToggle<CR>
    " }}}

    " Easy splits navigation {{{
      nnoremap <C-J> <C-W>j
      nnoremap <C-K> <C-W>k
      nnoremap <C-L> <C-W>l
      nnoremap <C-H> <C-W>h
    " }}}

    " Wrapped lines j/k goes down to wrap instead of new line {{{
        noremap j gj
        noremap k gk
    " }}}

    " Add modeline to file {{{
      nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
    " }}}

    "  Map g* to relative motion {{{
        function! WrapRelativeMotion(key, ...)
            let vis_sel=""
            if a:0
                let vis_sel="gv"
            endif
            if &wrap
                execute "normal!" vis_sel . "g" . a:key
            else
                execute "normal!" vis_sel . a:key
            endif
        endfunction

        " Map g* keys in Normal, Operator-pending, and Visual+select
        noremap $ :call WrapRelativeMotion("$")<CR>
        noremap <End> :call WrapRelativeMotion("$")<CR>
        noremap 0 :call WrapRelativeMotion("0")<CR>
        noremap <Home> :call WrapRelativeMotion("0")<CR>
        noremap ^ :call WrapRelativeMotion("^")<CR>
        " Overwrite the operator pending $/<End> mappings from above
        " to force inclusive motion with :execute normal!
        onoremap $ v:call WrapRelativeMotion("$")<CR>
        onoremap <End> v:call WrapRelativeMotion("$")<CR>
        " Overwrite the Visual+select mode mappings from above
        " to ensure the correct vis_sel flag is passed to function
        vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
        vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
        vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
    " }}}

    " Fast buffer switching {{{
        map <S-H> :bp<CR>
        map <S-L> :bn<CR>
    " }}}

    " Stupid shift key fixes {{{
        if has("user_commands")
            command! -bang -nargs=* -complete=file E e<bang> <args>
            command! -bang -nargs=* -complete=file W w<bang> <args>
            command! -bang -nargs=* -complete=file Wq wq<bang> <args>
            command! -bang -nargs=* -complete=file WQ wq<bang> <args>
            command! -bang Wa wa<bang>
            command! -bang WA wa<bang>
            command! -bang Q q<bang>
            command! -bang QA qa<bang>
            command! -bang Qa qa<bang>
        endif
        cmap Tabe tabe
    " }}}

    " Yank from the cursor to the end of the line, to be consistent with C and D. {{{
        nnoremap Y y$
    " }}}

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

    " Most prefer to toggle search highlighting rather than clear the current {{{
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
        nmap <silent> <leader>/ :set invhlsearch<CR>
    " }}}

    " Find merge conflict markers {{{
        map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
    " }}}

    " Shortcuts Change Working Directory to that of the current file {{{
        cmap cd. lcd %:p:h
    " }}}

    " Visual shifting (does not exit Visual mode)  {{{
        vnoremap < <gv
        vnoremap > >gv
    " }}}

    " Allow using the repeat operator with a visual selection (!) {{{
    " http://stackoverflow.com/a/8064607/127816
        vnoremap . :normal .<CR>
    " }}}

    " For when you forget to sudo.. Really Write the file. {{{
        cmap w!! w !sudo tee % >/dev/null
    " }}}

    " Some helpers to edit mode {{{
    " http://vimcasts.org/e/14
        cnoremap %% <C-R>=expand('%:h').'/'<cr>
        map <leader>ew :e %%
        map <leader>es :sp %%
        map <leader>ev :vsp %%
        map <leader>et :tabe %%
    " }}}

    " Adjust viewports to the same size {{{
        map <Leader>= <C-w>=
    " }}}

    " Map <Leader>ff to display all lines with keyword under cursor {{{
    " and ask which one to jump to
        nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
    " }}}

    " Easier horizontal scrolling {{{
        map zl zL
        map zh zH
    " }}}

    " Easier formatting  {{{
        nnoremap <silent> <leader>q :Autoformat<CR>
    " }}}

    " Close buffer without closing split {{{
        nnoremap <silent> <leader>bd :Bdelete<CR>
    " }}}

    " {{{ Python helpers
      nmap <silent> <Leader>b<Space> :call MyPlaceBreakpoint()<Esc>
    " }}}

    " NVim {{{
      if has('nvim')
        tnoremap <Esc> <C-\><C-n>
        tnoremap <C-h> <C-\><C-n><C-w>h
        tnoremap <C-j> <C-\><C-n><C-w>j
        tnoremap <C-k> <C-\><C-n><C-w>k
        tnoremap <C-l> <C-\><C-n><C-w>l
      endif
    " }}}
  " }}}

  " Plugins Mappings {{{
    " C.vim {{{
      let g:C_Ctrl_j   = 'off'
    " }}}
    " Sessionman {{{
      nmap <leader>sl :SessionList<CR>
      nmap <leader>ss :SessionSave<CR>
      nmap <leader>sc :SessionClose<CR>
    " }}}
    " JSON {{{
      nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }}}
    " TagBar {{{
      if isdirectory(expand("~/.vim/plugged/tagbar/"))
        " If using go please install the gotags program using the following
        " go install github.com/jstemmer/gotags
        " And make sure gotags is in your path
        nnoremap <silent> <Leader>to :TagbarToggle<CR>
        let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [  'p:package', 'i:imports:1', 'c:constants', 'v:variables',
                \ 't:types',  'n:interfaces', 'w:fields', 'e:embedded', 'm:methods',
                \ 'r:constructor', 'f:functions' ],
            \ 'sro' : '.',
            \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
            \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
      endif
    "}}}
    " NerdTree {{{
      map <C-e> :NERDTreeToggle<CR>
    " }}}
    " CtrlSF {{{
      nmap     <Leader>sp <Plug>CtrlSFPrompt
      nnoremap <Leader>sF :CtrlSFToggle<CR>
    " }}}
    " {{{ YouCompleteMe
      " Select by Enter key
      let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
      nnoremap <Leader>gD :YcmCompleter GetDoc<CR>
      nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>
      nnoremap <Leader>gd :YcmCompleter GoToDeclaration<CR>
      nnoremap <Leader>gf :YcmCompleter GoToDefinition<CR>
    " }}}
    " Unite bindings buffregator settings {{{
        call unite#filters#matcher_default#use(['matcher_fuzzy'])
        call unite#filters#sorter_default#use(['sorter_rank'])
        nmap <Leader>be :Unite -start-insert buffer<CR>
        nmap <Leader>bE :Unite -start-insert buffer file_rec/async:!<CR>
        nmap <Leader>bt :Unite -start-insert outline<CR>
        nmap <Leader>bl :Unite location_list<CR>
        nmap <Leader>bq :Unite quickfix<CR>
        " Running grep for current buffer
        nmap <Leader>bg :Unite grep:%<CR>
        " Running grep for all open buffers
        nmap <Leader>bG :Unite grep:$buffers<CR>

        autocmd FileType unite call s:unite_my_settings()
        " Unite buffer settings {{{
            function! s:unite_my_settings()
              " Overwrite settings.

              " double jj for esc
              imap <buffer> jj      <Plug>(unite_insert_leave)
              imap <buffer><expr> j unite#smart_map('j', '')


              nmap <silent><buffer><expr> v     unite#do_action('vsplit')

              "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
              "nmap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

              "imap <buffer> <TAB>   <Plug>(unite_select_next_line)

              "imap <buffer> '     <Plug>(unite_quick_match_default_action)
              "nmap <buffer> '     <Plug>(unite_quick_match_default_action)

              "imap <buffer><expr> x
                      "\ unite#smart_map('x', "\<Plug>(unite_quick_match_jump)")
              "nmap <buffer> x     <Plug>(unite_quick_match_jump)

              "nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
              "imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)

              "imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
              "nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)

              "nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)

              "nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
              "imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)

              "nnoremap <silent><buffer><expr> l
                      "\ unite#smart_map('l', unite#do_action('default'))

              "let unite = unite#get_current_unite()
              "if unite.profile_name ==# 'search'
                "nnoremap <silent><buffer><expr> r     unite#do_action('replace')
              "else
                "nnoremap <silent><buffer><expr> r     unite#do_action('rename')
              "endif

              "nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
              "nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
                      "\ empty(unite#mappings#get_current_filters()) ?
                      "\ ['sorter_reverse'] : [])

              "" Runs "split" action by <C-s>.
              "nmap <silent><buffer><expr> v     unite#do_action('vsplit')
            endfunction

            " Add UltiSnips
            function! UltiSnipsCallUnite()
                Unite -start-insert -immediately -no-empty ultisnips
                return ''
            endfunction
            inoremap <silent> <c-b><c-u> <C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>
            nnoremap <Leader>bu a<C-R>=(pumvisible()? "\<LT>C-E>":"")<CR><C-R>=UltiSnipsCallUnite()<CR>


        " }}}
    " }}}
  " }}}
" }}}

" Functions {{{
  " {{{ Place breakpoint
    function! MyPlaceBreakpoint()
      redir => output
        if &ft == "javascript"
          normal Odebugger
        elseif &ft == "python"
          normal Oimport ipdb; ipdb.set_trace()
        endif
      redir end
      return output
    endfunction
  " }}}

  " Initialize directories {{{
    function! InitializeDirectories()
      let parent = $HOME.'/.vim'
      let prefix = 'vim'
      let dir_list = {
                  \ 'backup': 'backupdir',
                  \ 'views': 'viewdir',
                  \ 'swap': 'directory' }

      if has('persistent_undo')
          let dir_list['undo'] = 'undodir'
      endif

      " To specify a different directory in which to place the vimbackup,
      " vimviews, vimundo, and vimswap files/directories, add the following to
      " your .vimrc.before.local file:
      let common_dir = parent . '/.' . prefix

      for [dirname, settingname] in items(dir_list)
          let directory = common_dir . dirname . '/'
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
  " {{{ Activate Virtualenv and restart YCM
    function! VEActivate(venv)
      let vea = "VirtualEnvActivate " . a:venv
      let ycmr = "YcmCompleter RestartServer /Users/alex/.virtualenvs/" . a:venv . '/bin/python'
      execute vea
      execute ycmr
    endfunction
    command! -nargs=* VEAct call VEActivate('<args>')
  " }}}
  " Add modeline {{{
    function! AppendModeline()
      let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d fdm=%s %set :",
            \ &tabstop, &shiftwidth, &textwidth, &fdm, &expandtab ? '' : 'no')
      let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
      call append(line("$"), l:modeline)
    endfunction
  " }}}
" }}}

