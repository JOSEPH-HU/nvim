let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:ruby_host_prog = '/usr/bin/ruby'
let g:ale_sign_warning = '!'
"设置系统剪切板
set clipboard+=unnamedplus
"显示行号
set number
"不与vi兼容采用vim自己的命令
set nocompatible
"语法高亮
syntax on
"在底部显示模式
set showmode
"命令模式下，在底部显示当前输入的指令
set showcmd
"支持使用鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key
"启用256颜色
set t_Co=256
"使用 utf-8编码 缓存文本
set encoding=utf-8
"文件编码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

"输出终端编码
set termencoding=uft-8
"按下Tab键之后，Vim显示的空格数
set tabstop=4
"显示光标所在的当前行的行号，其他行都为相对于改行的相对行号
set relativenumber
"光标所在的当前行高亮
set cursorline
"设置行宽
"set textwidth=80
set cc=114
"自动折行
"set wrap
"光标遇到圆括号，方括号，自动高亮对应另一半
set showmatch
"搜索是忽略大小写
set ignorecase
" 命令模式下，底部操作指令按下Tab键自动补全
set wildmenu
set wildmode=longest:list,full
"开启文件检查
"filetype plugin on
filetype plugin indent on
"按下回车键后，下一行的缩进会自动跟上一行的缩进保持一致
set autoindent
"在文本上按下>>（增加一级缩进）、<<（取消一级缩进）或者==（取消全部缩进）时，每一级的字符数。
set shiftwidth=4
"只有遇到指定的符号（比如空格、连词号和其他标点符号），才发生折行。也就是说，不会在单词内部折行。
set linebreak
"不创建备份文件。默认情况下，文件保存时，会额外创建一个备份文件，它的文件名是在原文件名的末尾，再添加一个波浪号（〜）。
set nobackup
"保留撤销历史
set undofile
"set backupdir=~/.vim/.backup/
"set directory=~/.vim/.swp/
"set undodir=~/.vim/.undo/
"出错时，不要发出响声。
set noerrorbells
"出错时，发出视觉提示，通常是屏幕闪烁。
set visualbell
"如果行尾有多余的空格（包括 Tab 键），该配置将让这些空格显示成可见的小方块
set listchars=tab:»■,trail:■
set list
"移除 Windows 文件结尾的 `^M`
noremap <leader>m :%s/<C-V><C-M>//ge<CR>

call plug#begin('~/.local/share/nvim/plugged')
" auto format tool
Plug 'sbdchd/neoformat'
" VIM MARKDOWN RUNTIME FILES
Plug 'plasticboy/vim-markdown'
" markdown toc
Plug 'mzlogin/vim-markdown-toc'
" markdown preview
Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown', 'do': 'cd app & yarn install'}

"状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"文件
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

"搜索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'


" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim'

" Vim Applications
Plug 'itchyny/calendar.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'theniceboy/vim-snippets'

"自动补全括号
Plug 'jiangmiao/auto-pairs'

call plug#end()

""""""""""""""""""""""""""""""" plugin settings """"""""""""""""""""""""""
" plasticboy/vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
let g:vim_markdown_fenced_languages = ['python', 'js=javascript', 'viml=vim', 'bash=sh', 'golang=go']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
" sbdchd/neoformat
let g:neoformat_enabled_markdown = ['prettier']
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END

noremap r :call CompileRunGcc()<CR>
  func! CompileRunGcc()
          exec "w"
          if &filetype == 'c'
                  exec "!g++ % -o %<"
                  exec "!time ./%<"
          elseif &filetype == 'cpp'
                  set splitbelow
                  exec "!g++ -std=c++11 % -Wall -o %<"
                  :sp
                  :res -15
                  :term ./%<
          elseif &filetype == 'java'
                  exec "!javac %"
                  exec "!time java %<"
          elseif &filetype == 'sh'
                  :!time bash %
          elseif &filetype == 'python'
                  set splitbelow
                  :sp
                  :term python3 %
          elseif &filetype == 'html'
                  silent! exec "!chromium % &"
          elseif &filetype == 'markdown'
                  exec "MarkdownPreview"
          elseif &filetype == 'tex'
                  silent! exec "VimtexStop"
                  silent! exec "VimtexCompile"
          elseif &filetype == 'go'
                  set splitbelow
                  :sp
                  :term go run %
          endif
  endfunc
"用atom打开文件 
noremap at :call Atom()<CR>
func! Atom()
	:!atom %
endfunc

" defx
"map <silent> - :Defx<CR>
" 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent> <LocalLeader>a
\ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>
function! s:defx_mappings() abort
	" Defx window keyboard mappings
	setlocal signcolumn=no
	" 使用回车打开文件
	  nnoremap <silent><buffer><expr> <CR> defx#do_action('multi', ['drop'])
	  nnoremap <silent><buffer><expr> c defx#do_action('copy')
	  nnoremap <silent><buffer><expr> p defx#do_action('paste')
	  nnoremap <silent><buffer><expr> r defx#do_action('rename')
	  nnoremap <silent><buffer><expr> m defx#do_action('move')
	  nnoremap <silent><buffer><expr> d defx#do_action('remove_trash')
	  nnoremap <silent><buffer><expr> nf defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> nd defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> ~ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q defx#do_action('quit')
	  nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')
          nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns','mark:filename:type:size:time')
endfunction
call defx#custom#option('_', {
	\ 'columns': 'indent:git:icons:filename',
	\ 'winwidth': 25,
	\ 'split': 'vertical',
	\ 'direction': 'topleft',
	\ 'listed': 1,
	\ 'show_ignored_files': 0,
	\ 'root_marker': '≡ ',
	\ 'ignored_files':
	\     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	\   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
	\ })

autocmd FileType defx call s:defx_mappings()

"Defx icons
let g:defx_icons_enable_syntax_highlight = 1

"Defx git
let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment


"fzf
nmap <C-p> :Files<CR>
nmap <C-e> :Buffers<CR>
let g:fzf_action = { 'ctrl-e': 'edit' }
"fzf浮动窗口
" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }
function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

" ===
" === coc
" ===
" fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
let g:coc_global_extensions = ['coc-python', 'coc-vimlsp', 'coc-html', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-yank', 'coc-gitignore', 'coc-vimlsp', 'coc-tailwindcss', 'coc-stylelint', 'coc-tslint', 'coc-lists', 'coc-git', 'coc-explorer', 'coc-pyright', 'coc-sourcekit', 'coc-translator', 'coc-flutter', 'coc-todolist']
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"nmap <silent> <TAB> <Plug>(coc-range-select)
"xmap <silent> <TAB> <Plug>(coc-range-select)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()

" Open up coc-commands
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" coctodolist
nnoremap <leader>tn :CocCommand todolist.create<CR>
nnoremap <leader>tl :CocList todolist<CR>
nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>

" ===
" === vim-calendar
" ===
noremap \c :Calendar -position=here<CR>
"noremap \\ :Calendar -view=clock -position=here<CR>
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1
augroup calendar-mappings
        autocmd!
        " diamond cursor
        autocmd FileType calendar nmap <buffer> k <Plug>(calendar_up)
        autocmd FileType calendar nmap <buffer> h <Plug>(calendar_left)
        autocmd FileType calendar nmap <buffer> j <Plug>(calendar_down)
        autocmd FileType calendar nmap <buffer> l <Plug>(calendar_right)
        autocmd FileType calendar nmap <buffer> <c-u> <Plug>(calendar_move_up)
        autocmd FileType calendar nmap <buffer> <c-n> <Plug>(calendar_move_left)
        autocmd FileType calendar nmap <buffer> <c-e> <Plug>(calendar_move_down)
        autocmd FileType calendar nmap <buffer> <c-i> <Plug>(calendar_move_right)
        autocmd FileType calendar nmap <buffer> i <Plug>(calendar_start_insert)
        autocmd FileType calendar nmap <buffer> K <Plug>(calendar_start_insert_head)
        " unmap <C-n>, <C-p> for other plugins
        autocmd FileType calendar nunmap <buffer> <C-n>
        autocmd FileType calendar nunmap <buffer> <C-p>
augroup END

" ===
" === Markdown Settings
" ===
" Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
                        \ 'mkit': {},
                        \ 'katex': {},
                        \ 'uml': {},
                        \ 'maid': {},
                        \ 'disable_sync_scroll': 0,
                        \ 'sync_scroll_type': 'middle',
                        \ 'hide_yaml_meta': 1
                        \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
