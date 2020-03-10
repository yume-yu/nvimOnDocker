"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/root/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/root/.cache/dein')
  call dein#begin('/root/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/root/.cache/dein/repos/github.com/Shougo/dein.vim')

	" Add or remove your plugins here like this:
	let g:rc_dir    = expand('/root/.config/nvim/rc')
	let s:toml      = g:rc_dir . '/dein.toml'
	let s:lazy_toml = g:rc_dir . '/plugins_lazy.toml'
	" TOML を読み込み、キャッシュしておく
	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

"  If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"基本の挙動-------------------------------
set backspace=indent,eol,start	"Ins時のbackspaseの挙動をいつもどおりにする
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
let g:clipboard = {
      \'name': 'pbcopy',
      \'copy': {
      \   '+': 'pbcopy',
      \   '*': 'pbcopy',
      \ },
      \'paste': {
      \   '+': 'pbpaste',
      \   '*': 'pbpaste',
      \},
      \'cache_enabled': 0,
      \}
set clipboard=unnamedplus           "クリップボード共有の有効化
let b:did_ftplugin = 1
"set foldmethod=indent           "折りたたみ有効化
set cursorline                  "カーソル行のハイライト表示
set number                      "行番号の表示
let g:netrw_dirhistmax = 0      "ファイル変更履歴 .netrwhistを生成しないようにする
set showmatch                   "カッコを打ったとき対応するカッコに一瞬カーソルを合わせる
set matchtime=1                 "カーソルを合わせる時間(0.1sにかける倍数)
set display=lastline            "長過ぎる行が現れたときにvim上にしっかり表示されるようにする
set tabstop=2
set expandtab
set tabstop=2
set shiftwidth=2
set hidden                      "バッファを保存せずに切り替えられるようにする
set spelllang=en,cjk            "スペルチェックの対象から日本語を除く
set spell
"分割した画面間の移動をCtrl+hjklに置き換え
nnoremap <C-j> <C-w><Down>
nnoremap <C-k> <C-w><Up>
nnoremap <C-l> <C-w><Right>
nnoremap <C-h> <C-w><Left>

"ウィンドウ最大化を再マッピング
nnoremap <c-w>h <C-w>H
nnoremap <c-w>j <C-w>J
nnoremap <c-w>k <C-w>K
nnoremap <c-w>l <C-w>L

"タブ移動をマッピング
nnoremap <c-n> <C-PageUp>

"Windowサイズの自動調整をoffに
set noequalalways

"インクリメント/デクリメントを+/-に置換
nnoremap + <C-a>
nnoremap - <C-x>
"yの挙動をdと合わせる
nnoremap Y v$hy
"jjでインサート脱出
inoremap <silent> jj <ESC>
"no highlightを簡略化
nnoremap <silent> nh :<c-u>noh<CR>
"terminalでもjjでterminal-job脱出
tnoremap <silent>jj <C-\><C-n>
augroup in-terminal
  autocmd!
  " terminal bufferに入ったら即Insert
  autocmd BufEnter * if &buftype ==# "terminal" | startinsert | endif
  " terminal bufferを開いたら
  autocmd TermOpen * set nospell    "スペルチェックなし
  autocmd TermOpen * set nonumber   "行番号なし
  autocmd TermOpen * set listchars= "特殊文字表示なし
augroup END

"見栄え-----------------------------------
"背景色をターミナルに統一
highlight Normal ctermbg=none
highlight LineNr ctermbg=none
highlight Nontext ctermbg=none
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set termguicolors    " ターミナルでも True Color を使えるようにする。
set pumblend=10      " 0 〜 100 が指定できます。ドキュメントによると 5 〜 30 くらいが適当だそうです。
"新しいウィンドウを開くとき左ではなく右にする
" language C " 言語を英語に
".vueファイルのときシンタックスがおかしくなるのを解消
autocmd FileType vue syntax sync fromstart
" texファイルを開くときに裏で自動継続コンパイルをスタート
autocmd! BufRead *.tex :call jobstart('latexmk -pvc')

" packadd nvim-lsp'
"基本的にこれだけでOK
" autocmd! BufRead *.py lua require'nvim_lsp'.pyls.setup{}
" ポップアップの透明度を設定
set pumblend=30

"文字コード/改行文字周り------------------
"エンコードの設定
set encoding=utf-8
"ファイルのエンコードの設定
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,
"ファイルの改行絡み
set fileformat=unix
set fileformats=unix,dos,mac

"外部連携周り-----------------------------
"pythonの有効化
"let g:python_host_prog  = '/Users/yume_yu/.pyenv/versions/py2neovim/bin/python2'
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
"nodeの有効化
let g:node_host_prog = '/usr/local/bin/neovim-node-host'
"rubyの有効化
let g:ruby_host_prog = '/usr/bin/neovim-ruby-host'

function! EditDailyMemo()
    let l:daily_memo_dir = '/tmp'
    if isdirectory($DAILY_MEMO_DIR)
        let l:daily_memo_dir = $DAILY_MEMO_DIR
    endif
    let l:memo_dir = l:daily_memo_dir.'/'.strftime('%Y/%m')
    let l:memo_file = l:memo_dir.'/'.strftime('%d').'.txt'
    call mkdir(l:memo_dir, 'p')
    execute "tabnew ".l:memo_file
endfunction

function! UpdateFloadSize()
  let s:denite_win_width_percent = 0.5
  let s:denite_win_height_percent = 0.5
  call denite#custom#option('default', {
      \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })
endfunction
