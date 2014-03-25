"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
" {{{
" 行番号を表示する
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" 新しい行のインデントを現在行と同じにしない（同じにする:autoindent）
set noautoindent
" クリップボードをWindowsと連携
set clipboard=unnamed
" バックアップファイルを作らない
set nobackup
" スワップファイルを作る
set swapfile
" スワップファイルの出力先指定
set directory=~/.vim/swp
" <Tab>表示
set list
" listで表示する文字設定
set lcs=tab:>-,trail:_,extends:\
" ファイル内の <tab> が対応する空白の数
set tabstop=4 shiftwidth=4
" <Tab>でTabを入力
set expandtab
" インデントを shiftwidth の倍数で丸め
set shiftround
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" バックスペースでインデントや改行を削除できる
set backspace=indent,eol,start
" 検索時の大文字、小文字を区別
set noignorecase
" 検索時に大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase
" 検索時にファイルの最後まで検索したら最初に戻らないようにする
set nowrapscan
" インクリメンタルサーチを行う
set incsearch
" カーソル行の強調表示
set cursorline
" 長い行の折り返し
set nowrap
" ウィンドウ開閉時に自動でウィンドウサイズを変更しない
set noequalalways
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title
" 挿入モード・検索モードでのデフォルトのIME状態設定
set iminsert=0 imsearch=0
" ステータスラインを常に表示
set laststatus=2
" シンタックス
syntax on
" 画面最後の行をできる限り表示する
set display=lastline
" migemoによるローマ字入力かなインクリメンタルサーチを有効化
if has('migemo')
  set migemo
else
endif
" 補完時にプレビューウィンドウを表示しない
" NOTE: help completeopt
set completeopt=menuone
" }}}

"-------------------------------------------------------------------------------
" ファイルタイプ別基本設定
"-------------------------------------------------------------------------------
" runtimepath設定 {{{
"---------------------------------------
" vim起動時のみruntimepathに ~/.vim を追加
" NOTE: ファイルタイプ別設定は ~/.vim/ftplugin 内で定義
if has('vim_starting')
  set runtimepath+=~/.vim/
endif
" }}}

"-------------------------------------------------------------------------------
" 文字コードの自動認識
"-------------------------------------------------------------------------------
" {{{
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  augroup AutoReCheckFEnc
    autocmd!
    autocmd BufReadPost * call AU_ReCheck_FENC()
  augroup END
endif
" 改行コードの自動認識
"set fileformats=dos,unix,mac
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" }}}

"-------------------------------------------------------------------------------
" プラグイン管理
"-------------------------------------------------------------------------------
" 標準プラグイン読込 {{{
"---------------------------------------
" matchit.vim（if-endif などを % で移動可能とする）
runtime macros/matchit.vim
" }}}
"---------------------------------------
" NeoBundle {{{
"---------------------------------------
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
" neobundle.vimの初期化
call neobundle#rc(expand('~/.vim/bundle'))
" NeoBundleを更新するための設定
NeoBundleFetch 'Shougo/neobundle.vim'
" 読み込むプラグイン
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \   'windows' : 'make -f make_mingw32.mak',
  \   'cygwin'  : 'make -f make_cygwin.mak ',
  \   'mac'     : 'make -f make_mac.mak    ',
  \   'unix'    : 'make -f make_unix.mak   ',
  \   }
  \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim',
  \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'supermomonga/vimshell-kawaii.vim', {
  \ 'depends' : 'Shougo/vimshell',
  \ }
NeoBundle 'Shougo/vimfiler', {
  \ 'depends' : 'Shougo/unite.vim',
  \ }
NeoBundle 'Shougo/unite-outline', {
  \ 'depends' : 'Shougo/unite.vim',
  \ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim', {
  \ 'depends' : 'thinca/vim-quickrun',
  \ }
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'koron/codic-vim'
NeoBundle 'rhysd/unite-codic.vim', {
  \ 'depends' : 'Shougo/unite.vim',
  \ }
NeoBundle 't9md/vim-choosewin'
NeoBundle 'kana/vim-submode'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tyru/restart.vim'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundleLazy 'nosami/Omnisharp', {
  \ 'autoload' : {'filetypes': ['cs']},
  \ 'build' : {
  \   'windows' : 'MSBuild.exe ~/.vim/bundle/Omnisharp/server/OmniSharp.sln /p:Platform="Any CPU"',
  \   'mac'     : 'xbuild server/OmniSharp.sln',
  \   'unix'    : 'xbuild server/OmniSharp.sln',
  \   }
  \ }
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-user'
" カラースキーマ
"NeoBundle 'rainux/vim-desert-warm-256'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'jeffreyiacono/vim-colors-wombat'
"NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on
" インストールのチェック
NeoBundleCheck
" }}}

"-------------------------------------------------------------------------------
" プラグイン設定
"-------------------------------------------------------------------------------
" Unite.vim {{{
"---------------------------------------
" Insertモードで開始
"let g:unite_enable_start_insert = 1
" yank履歴ON
let g:unite_source_history_yank_enable = 1

" Unite source 特別設定
let g:unite_source_alias_aliases = {
  \ "startup_file_mru" : {
  \     "source" : "file_mru",
  \   },
  \ "startup_directory_mru" : {
  \     "source" : "directory_mru",
  \   },
  \ "mymapping_list" : {
  \     "source" : "mapping",
  \   },
  \ }
call unite#custom_max_candidates("startup_file_mru", 5)
call unite#custom_max_candidates("startup_directory_mru", 5)
call unite#custom_source('mymapping_list', 'sorters', 'sorter_word')
" カスタマイズメニュー
if !exists("g:unite_source_menu_menus")
  let g:unite_source_menu_menus = {}
endif
" [shortcut]メニュー
let g:unite_source_menu_menus.shortcut = {
  \ 'description' : 'shortcut menu',
  \ 'command_candidates' : [
  \     [ '[edit] vimrc',  'edit ' . $MYVIMRC ],
  \     [ '[edit] gvimrc', 'edit ' . $MYGVIMRC ],
  \     [ '[Unite] file_mru', 'Unite file_mru' ],
  \     [ '[Unite] directory_mru', 'Unite directory_mru' ],
  \     [ '[Unite] mapping(Unite)', 'Unite mymapping_list -input=Unite' ],
  \     [ '[Unite] mapping(Space)', 'Unite mymapping_list -input=Space' ],
  \     [ '[Unite] menu:fileencoding', 'Unite menu:fileencoding' ],
  \     [ '[Unite] menu:fileformat', 'Unite menu:fileformat' ],
  \     [ '[Plugin] VimFiler', 'VimFiler' ],
  \     [ '[Plugin] MemoList', 'MemoList' ],
  \   ]
  \ }
" [fileencoding]メニュー
let g:unite_source_menu_menus.fileencoding = {
  \ 'description' : 'fileencode change menu',
  \ 'command_candidates' : [
  \     [ 'fileencoding=utf-8', 'set fileencoding=utf-8' ],
  \     [ 'fileencoding=euc-jp', 'set fileencoding=euc-jp' ],
  \     [ 'fileencoding=cp932', 'set fileencoding=cp932' ],
  \   ]
  \ }
" [fileformat]メニュー
let g:unite_source_menu_menus.fileformat = {
  \ 'description' : 'fileformat change menu',
  \ 'command_candidates' : [
  \     [ 'fileformat=unix', 'set fileformat=unix' ],
  \     [ 'fileformat=mac', 'set fileformat=mac' ],
  \     [ 'fileformat=dos', 'set fileformat=dos' ],
  \   ]
  \ }

" g:unite_source_alias_aliasesに設定したsource名を使用する
" スタートアップコマンド
command! UniteStartUp
  \ Unite
  \ output:echo:"===:file:mru:===":! startup_file_mru
  \ output:echo:":"
  \ output:echo:"===:directory:mru:===":! startup_directory_mru
  \ output:echo:":"
  \ output:echo:"===:menu:shortcut:===":! menu:shortcut
  \ -hide-source-names
  \ -no-split
"  \ -quick-match
" }}}

"---------------------------------------
" vimfiler {{{
"---------------------------------------
" VimFilerをデフォルトに
let g:vimfiler_as_default_explorer = 1
" VimFilerのセーフモードをデフォルトで解除（ファイル操作可能にする）
let g:vimfiler_safe_mode_by_default = 0
" VimFilerが表示しているディレクトリに自動で移動
let g:vimfiler_enable_auto_cd = 1
" }}}

"---------------------------------------
" vimshell {{{
"---------------------------------------
" 動的プロンプト設定
let g:my_vimshell_prompt_counter = -1
function! g:my_vimshell_dynamic_prompt()
  let g:my_vimshell_prompt_counter += 1
  let anim = [
        \        "(´･_･`)",
        \        "( ´･_･)",
        \        "(  ´･_)",
        \        "(   ´･)",
        \        "(    ´)",
        \        "(     )",
        \        "(     )",
        \        "(`    )",
        \        "(･`   )",
        \        "(_･`  )",
        \        "(･_･` )",
        \    ]
  return anim[g:my_vimshell_prompt_counter % len(anim)]
endfunction
let g:vimshell_prompt_expr = 'g:my_vimshell_dynamic_prompt()." > "'
let g:vimshell_prompt_pattern = '^([ ´･_･`]\{5}) > '
" }}}

"---------------------------------------
" vim-choosewin {{{
"---------------------------------------
" オーバーレイ機能を有効
let g:choosewin_overlay_enable = 1
" オーバーレイ時、マルチバイト文字を含むバッファで、ラベル文字が崩れるのを防ぐ
let g:choosewin_overlay_clear_multibyte = 1
" 着地時カーソル点滅しない
let g:choosewin_blink_on_land = 0
" ステータスラインリプレイス（0:無効 1:有効）
let g:choosewin_statusline_replace = 0
" タブラインリプレイス（0:無効 1:有効）
let g:choosewin_tabline_replace = 1
" }}}

"---------------------------------------
" vim-submode {{{
"---------------------------------------
" ウィンドウサイズ変更モード
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
" タブ移動モード
call submode#enter_with('changetab', 'n', '', 'tn', 'gt')
call submode#enter_with('changetab', 'n', '', 'tp', 'gT')
call submode#map('changetab', 'n', '', 'n', 'gt')
call submode#map('changetab', 'n', '', 'p', 'gT')
" }}}

"---------------------------------------
" memolist.vim {{{
"---------------------------------------
" PATH（デフォルト:~/memo）
let g:memolist_path = '~/.vim/memo'
" メモタイプ（デフォルト:markdown）
"let g:memolist_memo_suffix = 'txt'
" unite.vimを使用（デフォルト:0）
let g:memolist_unite = 1
" unite.vimオプション（デフォルト:empty）
let g:memolist_unite_option = '-auto-preview'
" }}}

"---------------------------------------
" restart.vim {{{
"---------------------------------------
" 終了時に保存するセッションオプションを設定する
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'
" }}}

"---------------------------------------
" caw.vim {{{
"---------------------------------------
" caw.vim のデフォルトキーマッピングを使用する(0)か否(1)か
let g:caw_no_default_keymappings = 1
" コメント挿入時にコメント文字列の後に挿入する文字／挿入モードか否か
" [i]系コメント
let g:caw_i_sp = ""
let g:caw_i_sp_blank = " "
let g:caw_i_startinsert_at_blank_line = 1
" [I]系コメント
let g:caw_I_sp = ""
let g:caw_I_sp_blank = " "
let g:caw_I_startinsert_at_blank_line = 1
" [a]系コメント
let g:caw_a_sp_left = " "
let g:caw_a_sp_right = " "
let g:caw_a_startinsert = 1
" wrapコメント
let g:caw_wrap_sp_left = " "
let g:caw_wrap_sp_right = " "
let g:caw_wrap_skip_blank_line = 1
let g:caw_wrap_align = 1
" }}}

"---------------------------------------
" syntastic {{{
"---------------------------------------
" 自動でチェックする（チェック／非チェックリスト）
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'],
  \ }
let g:syntastic_enable_signs = 1
" エラーの際にQuickfixが立ち上がる(1)か否(2)か
" NOTE: Quickfixが立ち上がる(1)にするとlightlineとの関係がおかしくなる
let g:syntastic_auto_loc_list = 2
" }}}

"---------------------------------------
" neocomplete {{{
"---------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#sources#syntax#min_keyword_length = 1
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
" }}}

"---------------------------------------
" neosnippet {{{
"---------------------------------------
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" スニペットファイルの保存ディレクトリを設定
let g:neosnippet#snippets_directory = '~/.vim/snippets'
" }}}

"---------------------------------------
" vim-quickrun {{{
"---------------------------------------
let g:quickrun_config = {}
" 基本設定
" runnerオプション：実行方法設定（非同期実行／更新間隔40秒）
" outputterオプション：バッファの開き方設定（水平分割／ウィンドウの高さ5行／出力がない場合は自動で閉じる）
let g:quickrun_config['_'] = {
  \ 'hook/vimshellkawaii/enable' : 1,
  \ 'outputter/buffer/split' : ':botright 5sp',
  \ 'outputter/buffer/close_on_empty' : 1,
  \ 'outputter/error/error' : 'quickfix',
  \ 'outputter/error/success' : 'buffer',
  \ 'runner' : 'vimproc',
  \ 'runner/vimproc/updatetime' : 40,
  \ }
" C#用設定（MAC用設定は未検証）
if has('mac')
  let g:quickrun_config['cs'] = {
    \ 'command' : 'cs',
    \ 'runmode' : 'simple',
    \ 'exec' : ['%c %s > /dev/null', 'mono "%S:p:r:gs?/?\\?.exe" %a', ':call delete("%S:p:r.exe")'],
    \ 'tempfile' : '{tempname()}.cs',
    \ }
else
  let g:quickrun_config['cs'] = {
    \ 'hook/output_encode/enable' : 1,
    \ 'hook/output_encode/encoding' : 'cp932',
    \ 'command' : 'csc',
    \ 'runmode' : 'simple',
    \ 'exec' : ['%c /nologo %s:gs?/?\\? > /dev/null', '"%S:p:r:gs?/?\\?.exe" %a'],
    \ 'tempfile' : '{tempname()}.cs',
    \ }
endif
" }}}

"---------------------------------------
" shabadou.vim {{{
"---------------------------------------
" QuickRun時にコマンドラインに表示するアニメーション
call quickrun#module#register(
  \ shabadou#make_quickrun_hook_anim(
    \ 'vimshellkawaii',
    \ [
    \   " (*'-')? ",
    \   " (*'-')! ",
    \   " (*'-') < active!",
    \ ],
    \ 40,
    \ ),
  \ 1)
" }}}

"---------------------------------------
" Omnisharp {{{
"---------------------------------------
" 補完用設定
augroup AutoSetOmnifunc
  autocmd!
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
augroup END
" [neocomplete]による自動補完設定
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'
" }}}

"---------------------------------------
" lightline.vim {{{
"---------------------------------------
" 他のプラグインからのステータスラインの上書きを抑制
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
" シンタックスチェックを自動でしない（AutoSyntaxCheckでチェックするリストを指定）
" lightlineとの関連でpassiveにする必要あり
let g:syntastic_mode_map = {
  \ 'mode': 'passive'
  \ }
augroup AutoSyntaxCheck
  autocmd!
  autocmd BufWritePost,FileWritePost *.c,*.cs,*.cpp,*.ps,*.h call s:syntaxCheck()
augroup END
function! s:syntaxCheck()
  SyntasticCheck
  call lightline#update()
endfunction

let g:lightline = {
  \ 'colorscheme': 'solarized_dark',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'fugitive', 'filename' ],
  \   ],
  \   'right': [
  \     ['percent', 'lineinfo', 'syntastic'],
  \     ['fileformat', 'fileencoding', 'filetype'],
  \     ['charcode'],
  \   ]
  \   },
  \ 'tabline': {
  \   'right': [
  \     [ 'datetime' ],
  \   ]
  \   },
  \ 'component_function': {
  \   'modified': 'MyModified',
  \   'readonly': 'MyReadonly',
  \   'fugitive': 'MyFugitive',
  \   'filename': 'MyFilename',
  \   'fileformat': 'MyFileformat',
  \   'filetype': 'MyFiletype',
  \   'fileencoding': 'MyFileencoding',
  \   'mode': 'MyMode',
  \   'charcode': 'MyCharCode',
  \   'datetime': 'MyDateTime',
  \   },
  \ 'component_expand': {
  \   'syntastic': 'SyntasticStatuslineFlag',
  \   },
  \ 'component_type': {
  \   'syntastic': 'error',
  \   },
  \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return  &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! MyCharCode()
  if winwidth('.') <= 70
    return ''
  endif
  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END
  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif
  " Zero pad hex values
  let nrformat = '0x%02x'
  let encoding = (&fenc == '' ? &enc : &fenc)
  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif
  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')
  " Format the numeric value
  let nr = printf(nrformat, nr)
  return "'". char ."' ". nr
endfunction

function! MyDateTime()
  return winwidth(0) > 30 ? strftime("%x %H:%M") : ''
  "return strftime("%x %H:%M ")
endfunction
" }}}

"-------------------------------------------------------------------------------
" キーマップ
"-------------------------------------------------------------------------------
" 基本 {{{
"---------------------------------------
" プレフィックスキー
nmap <Space> [Space]
vmap <Space> [Space]
nnoremap [Space] <Nop>
vnoremap [Space] <Nop>
" 押し間違え防止（Q:Exモード）
nnoremap Q <Nop>
" 押し間違え防止（～して閉じる系）
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" メニュー表示／非表示
map <silent> <F2> :if &guioptions =~# 'm' <Bar>
                 \   set guioptions-=T <Bar>
                 \   set guioptions-=m <Bar>
                 \ else <Bar>
                 \   set guioptions+=T <Bar>
                 \   set guioptions+=m <Bar>
                 \ endif<CR>
" }}}
"---------------------------------------
" 入力／編集 {{{
"---------------------------------------
" 日本語入力制御(Insertモード終了時に日本語入力モードを解除)
inoremap <silent> <unique> <Esc> <Esc>:set imsearch=0 iminsert=0<CR>
" 文字削除時レジスタに削除文字を登録しない
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X
" 連続put
nnoremap <silent> [Space]p "0p
vnoremap <silent> [Space]p "0p
" 空行入力
nmap <silent> [Space]o o<Esc>
" }}}
"---------------------------------------
" タブ操作 {{{
"---------------------------------------
nnoremap <silent> te :<C-u>tabedit<CR>
nnoremap <silent> tc :<C-u>tabclose<CR>
" 下のタブ移動キーマップは submode を使用しない場合に必要
"nnoremap <silent> tn :<C-u>tabnext<CR>
"nnoremap <silent> tp :<C-u>tabprevious<CR>
" }}}
"---------------------------------------
" エディット {{{
"---------------------------------------
nnoremap <silent> ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> eg :<C-u>edit $MYGVIMRC<CR>
" }}}
"---------------------------------------
" Unite.vim {{{
"---------------------------------------
nnoremap [Unite] <Nop>
nmap [Space]u [Unite]
nnoremap <silent> [Unite]  :<C-u>Unite mymapping_list -input=[Unite]<CR>
nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [Unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]c :<C-u>Unite codic -start-insert<CR>
nnoremap <silent> [Unite]l :<C-u>Unite line<CR>
nnoremap <silent> [Unite]o :<C-u>Unite -no-quit -vertical -winwidth=36 -direction=botright outline<CR>
nnoremap          [Unite]p :<C-u>Unite output:
nnoremap <silent> [Unite]u :<C-u>Unite menu:shortcut<CR>
" UniqueSettings[grep]
nnoremap <silent> [Space]g  :<C-u>Unite mymapping_list -input=[Space]g<CR>
nnoremap <silent> [Space]gr :<C-u>Unite grep:. -no-quit -buffer-name=grep-result<CR>
nnoremap <silent> [Space]gw :<C-u>Unite grep:. -no-quit -buffer-name=grep-result<CR><C-R><C-W><CR>
nnoremap <silent> [Space]gR :<C-u>UniteResume grep-result<CR>
" }}}
"---------------------------------------
" vimshell {{{
"---------------------------------------
nnoremap <silent> [Space]vs :<C-u>VimShell -split<CR>
" }}}
"---------------------------------------
" vimfiler {{{
"---------------------------------------
nnoremap <silent> [Space]vf :<C-u>VimFiler -split -simple -winwidth=32 -no-quit -auto-cd<CR>
" }}}
"---------------------------------------
" neocomplete {{{
"---------------------------------------
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" }}}
"---------------------------------------
" neosnippet {{{
"---------------------------------------
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
xmap <C-l> <Plug>(neosnippet_start_unite_snippet_target)
" }}}
"---------------------------------------
" vim-choosewin {{{
"---------------------------------------
nmap [Space]w <Plug>(choosewin)
" }}}
"---------------------------------------
" memolist.vim {{{
"---------------------------------------
nnoremap [memolist] <Nop>
nmap [Space]m [memolist]
nnoremap [memolist]n :MemoNew<CR>
nnoremap [memolist]l :MemoList<CR>
nnoremap [memolist]g :MemoGrep<CR>
" }}}
"---------------------------------------
" vim-anzu {{{
"---------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
" }}}
"---------------------------------------
" calendar.vim {{{
"---------------------------------------
nnoremap [Space]cl :<C-u>Calendar<CR>
" }}}
"---------------------------------------
" caw.vim {{{
"---------------------------------------
" 標準コメントコマンド
nmap [Space]cc <Plug>(caw:I:toggle)
vmap [Space]cc <Plug>(caw:I:toggle)
nmap [Space]ci <Plug>(caw:i:toggle)
vmap [Space]ci <Plug>(caw:i:toggle)
nmap [Space]ca <Plug>(caw:a:toggle)
vmap [Space]ca <Plug>(caw:a:toggle)
nmap [Space]cw <Plug>(caw:wrap:toggle)
vmap [Space]cw <Plug>(caw:wrap:toggle)
nmap [Space]co <Plug>(caw:jump:comment-next)
vmap [Space]co <Plug>(caw:jump:comment-next)
nmap [Space]cO <Plug>(caw:jump:comment-prev)
vmap [Space]cO <Plug>(caw:jump:comment-prev)
" コピペしてコメントアウト
" （カレント行or選択箇所をレジスタcを使用してヤンク／プットしてヤンク元をコメントアウト）
nmap [Space]cn "cyy"cp<Plug>(caw:I:toggle)k
vmap [Space]cn "cygv<Plug>(caw:I:toggle)"cP
" }}}

"-------------------------------------------------------------------------------
" autocmd
"-------------------------------------------------------------------------------
" 基本 {{{
"---------------------------------------
augroup AutoMyBasicCmd
  autocmd!
  " 現在開いているファイルのパスに移動する
  autocmd BufEnter * execute ":lcd " . expand("%:p:h")
  "autocmd BufEnter,BufRead * execute ":lcd " . expand("%:p:h")
  " vimgrep使用時にQuickFixで表示させるautocmd
  autocmd QuickfixCmdPost vimgrep cw
  " コメントのオートインデントをOFF
  " 参考ページ: http://d.hatena.ne.jp/dayflower/20081208/1228725403
  if has('autocmd')
    autocmd FileType * let &l:comments=join(filter(split(&l:comments, ','), 'v:val =~ "^[sme]"'), ',')
  endif
augroup END
" }}}
"---------------------------------------
" 起動時 {{{
"---------------------------------------
augroup AutoMyStartUpCmd
  autocmd!
  " UniteStartUp（引数もバッファも指定されずに起動した際にUniteStartUpを実行）
  autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | call s:UniteStartUpExec() | endif
  function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
      return 0
    else
      return byte - 1
    endif
  endfunction
  " なぜか直接書けなかったからfunction化
  function! s:UniteStartUpExec()
    :UniteStartUp
  endfunction
augroup END
" }}}
