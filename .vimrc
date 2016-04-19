" uses vim settings instead of vi settings
set nocompatible 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugins
    " :PluginInstall
        Plugin 'VundleVim/Vundle.vim'

    " Pretty
        Plugin 'scwood/vim-hybrid'
        Plugin 'vim-airline/vim-airline'
        Plugin 'vim-airline/vim-airline-themes'
        Plugin 'Yggdroot/indentLine.git'

    " I'm lazy
        Plugin 'jiangmiao/auto-pairs'
        Plugin 'kien/ctrlp.vim'
        Plugin 'scrooloose/nerdcommenter'               " ezpz comments
        Plugin 'scrooloose/syntastic'                   " compiler-esque
        Plugin 'scrooloose/nerdtree'                    " blessed tree
        Plugin 'jeffkreeftmeijer/vim-numbertoggle'      " toggleline numbers
        Plugin 'ajh17/VimCompletesMe'                   " autocomplete
        Plugin 'easymotion/vim-easymotion'
        Plugin 'rking/ag.vim'
        Plugin 'tpope/vim-surround'                     " cs'(

    " language specific
        Plugin 'maksimr/vim-jsbeautify'
        Plugin 'pangloss/vim-javascript'
        Plugin 'jelera/vim-javascript-syntax'   " javascript bracket matching
        Plugin 'gregsexton/MatchTag'            " html tag colouring
        Plugin 'rstacruz/sparkup'               " html autocomplete, div <C+E>
        Plugin 'terryma/vim-multiple-cursors'   " multiple cursors

    " Other
        Plugin 'wikitopian/hardmode'            " :call HardMode(), :call EasyMode()

    " Disabled
        " Plugin 'wookiehangover/jshint.vim'
        " Plugin 'Valloric/YouCompleteMe'           " autocomplete
        " Plugin 'SirVer/ultisnips.git'           " java snippest
        " Plugin 'honza/vim-snippets'
    
    call vundle#end()         
    filetype plugin indent on
    syntax on

" Plugin Settings
    " Airline setings
        set laststatus=2
        let g:airline_right_sep = ''
        let g:airline_left_sep = ''
        let g:airline_theme = 'bubblegum'

    " Easymotion
        " <Leader>f{char} to move to {char}
        "map  <Leader>f <Plug>(easymotion-bd-f)
        "nmap <Leader>f <Plug>(easymotion-overwin-f)
        " s{char}{char} to move to {char}{char}
        nmap s <Plug>(easymotion-overwin-f2)
        " Move to line
        map <Leader>L <Plug>(easymotion-bd-jk)
        nmap L <Plug>(easymotion-overwin-line)
        " Move to word
        "map  <Leader>w <Plug>(easymotion-bd-w)
        "nmap <Leader>w <Plug>(easymotion-overwin-w)

    " Syntastic 
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0

        let g:syntastic_javascript_checkers = ['jshint']
        let g:syntastic_css_checkers = ['csslint']
        let g:syntastic_mode_map = { 'passive_filetypes': ['java']  }
        " disables syntastic for java because I have eclim
    
    " vertical line indentation
        let g:indentLine_color_term = 239
        let g:indentLine_color_gui = '#09AA08'
        let g:indentLine_char = '│'

    " Pretty Javascript
    map <c-a> :call JsBeautify()<cr>

    " You Complete me
    let g:ycm_filetype_blacklist = { 'java': 1 }

    " Autocomplete
    autocmd FileType text,markdown let b:vcm_tab_complete = 'dict'

    " Autocomplete - Eclim
    autocmd FileType java inoremap <leader><tab> <C-x><C-u>

    " Multiple cursors
        let g:multi_cursor_use_default_mapping=0
        let g:multi_cursor_next_key='<C-m>'
        let g:multi_cursor_prev_key='<C-k>'
        let g:multi_cursor_skip_key='<C-x>'
        let g:multi_cursor_quit_key='<Esc>'

" Native vim settings
    " pretty/UI
        set background=dark
        colorscheme hybrid
        set history=50      " keep 50 lines of command line history
        set ruler       " shows cursor
        set showcmd     " display incomplete commands

    " search
        set ignorecase          " ignorecase for search
        set smartcase           " case sensitive if at least one is capitalized
        set incsearch       " do incremental searching

    " compiler
        map <F8> :call CompileRunGcc()<CR>
        func! CompileRunGcc()
            exec "w"
            exec "!clear"
            if &filetype == 'c'
                exec "!gcc % -o %<"
                exec "!time ./%<"
            elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
            elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java -cp %:p:h %:t:r"
            elseif &filetype == 'sh'
                exec "!time bash %"
            elseif &filetype == 'python'
                exec "!time python2.7 %"
            elseif &filetype == 'html'
                exec "!firefox % &"
            elseif &filetype == 'go'
                exec "!go build %<"
                exec "!time go run %"
            elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
            endif
        endfunc

    " Toggle paste mode
        set pastetoggle=<leader>p
		set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
        set backspace=indent,eol,start

    " Better tabs
        " use 4 spaces for tabs
        set tabstop=4 softtabstop=4 shiftwidth=4

    " behavior settings
        set nowrap
        set foldmethod=indent
        set backup
        set number

" Macros/Mappings
    " Plugin Mappings
        map <F2> :NERDTreeToggle<cr>
        map <leader>nt :NERDTree %:p:h<cr>
        map <leader>R :SyntasticReset<cr>

    " Vim traversal
        nmap <C-tab> i<tab><Esc>
        map <C-u> 10<C-y>
        map <C-d> 10<C-e>
        map <C-f> 30<C-e>
        map <C-b> 30<C-y>

    " Vim Navigation
        nnoremap <tab> <C-w>w
        nnoremap <S-tab> <C-w>W

    " Vim windows
        nmap <leader>. :vertical resize +5<cr>
        nmap <leader>, :vertical resize -5<cr>
        nmap <leader>= :resize +5<cr>
        nmap <leader>- :resize -5<cr>
    
    " Vim Language Specific
        " Javascript
            imap cll console.log();<Esc><Left>i
            imap <C-z> <C-w>
        " Java
            imap sypl System.out.println();<Esc><Left>i

    " Other
         map <M-w> :w
         set showcmd

        " visual
            vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
			vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
