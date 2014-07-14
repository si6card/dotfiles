"-------------------------------------------------------------------------------
" Initialize VIM
"-------------------------------------------------------------------------------
" scriptencoding {{{
"---------------------------------------
scriptencoding utf-8
set nocompatible
" }}}
"---------------------------------------
" autocmd {{{
"---------------------------------------
augroup MyVimrc
  autocmd!
augroup END
" autocmd command
command! -nargs=* Autocmd autocmd MyVimrc <args>
command! -nargs=* AutocmdFT autocmd MyVimrc FileType <args>
" Autocmd/AutocmdFT highlight
function! s:hl_my_autocmd()
  highlight def link myVimAutocmd vimAutoCmd
  syntax match vimAutoCmd /\<\(Autocmd\|AutocmdFT\)\>/
endfunction
Autocmd BufWinEnter,ColorScheme *vimrc call s:hl_my_autocmd()
" }}}
"---------------------------------------
" 環境判定用変数 {{{
" NOTE: うまいこと判定できるかな？とりあえず困ってない
"---------------------------------------
let s:is_windows = has('win32') || has('win64') || has('win32unix')
let s:is_mac = has('mac') || has('macunix')
let s:is_unix = has('unix')
" }}}
"---------------------------------------
" エンコード指定 {{{
"---------------------------------------
if s:is_windows
  " windows の場合は標準のまま使用
elseif s:is_mac
  set encoding=utf-8
elseif s:is_unix
  set encoding=utf-8
endif
" }}}
"---------------------------------------
" runtimepath設定 {{{
"---------------------------------------
" vim起動時のみruntimepathに ~/.vim を追加
if has('vim_starting')
  set runtimepath+=~/.vim/
endif
" }}}
"---------------------------------------
" 環境変数 {{{
"---------------------------------------
if has('vim_starting')
  if !exists('$MYGVIMRC')
    let $MYGVIMRC=expand('~/.gvimrc')
  endif
endif
" netrw.vim を疑似的にロード済み状態とすることでロードさせない
let g:loaded_netrwPlugin = 1
" }}}

"-------------------------------------------------------------------------------
" プラグイン管理
"-------------------------------------------------------------------------------
" Initialize NeoBundle {{{
"---------------------------------------
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
" neobundle.vimの初期化
call neobundle#rc(expand('~/.vim/bundle'))
" NeoBundleを更新するための設定
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}
"---------------------------------------
" プラグイン読込 {{{
"---------------------------------------
" 他プラグイン読込前 {{{
if has('clientserver')
  NeoBundle 'thinca/vim-singleton'
  call singleton#enable()
endif
" }}}
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \   'windows' : 'make -f make_mingw32.mak',
      \   'cygwin'  : 'make -f make_cygwin.mak ',
      \   'mac'     : 'make -f make_mac.mak    ',
      \   'unix'    : 'make -f make_unix.mak   ',
      \   },
      \ }
NeoBundleLazy 'Shougo/unite.vim', {
      \ 'autoload' : {
      \   'commands' : [
      \     {'name' : 'Unite',
      \      'complete' : 'customlist,unite#complete_source'},
      \     'UniteWithCursorWord', 'UniteWithInput',
      \     ]
      \   },
      \ }
NeoBundleLazy 'Shougo/neomru.vim', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : [
      \     'file_mru',
      \     'directory_mru',
      \     ],
      \   },
      \ }
NeoBundleLazy 'Shougo/vimshell', {
      \ 'autoload' : {
      \   'commands' : [
      \     {'name' : 'VimShell',
      \      'complete' : 'customlist,vimshell#complete'},
      \     'VimShellExecute', 'VimShellInteractive',
      \     'VimShellTerminal', 'VimShellPop'
      \     ],
      \   'mappings' : [
      \     '<Plug>(vimshell_switch)',
      \     ]
      \   },
      \ }
NeoBundleLazy 'Shougo/vimfiler', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'commands' : [
      \     {'name' : 'VimFiler',
      \      'complete' : 'customlist,vimfiler#complete'},
      \     'VimFilerExplorer',
      \     'Edit', 'Read', 'Source', 'Write',
      \     ],
      \   'mappings' : [
      \     '<Plug>(vimfiler_',
      \     ],
      \   'explorer' : 1,
      \   },
      \ }
NeoBundleLazy 'Shougo/unite-outline', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : ['outline'],
      \   },
      \ }
NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload' : {
      \   'commands' : 'QuickRun',
      \   'mappings' : [
      \     '<Plug>(quickrun',
      \     ],
      \   },
      \ }
NeoBundleLazy 'osyo-manga/shabadou.vim', {
      \ 'depends' : 'thinca/vim-quickrun',
      \ 'autoload' : {
      \   'commands' : 'QuickRun',
      \   'mappings' : [
      \     '<Plug>(quickrun',
      \     ],
      \   },
      \ }
NeoBundleLazy 'Shougo/neocomplete', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   },
      \ 'disabled' : !has('lua'),
      \ 'vim_version' : '7.3.885',
      \ }
NeoBundleLazy 'Shougo/neosnippet', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   },
      \ }
NeoBundleLazy 'Shougo/neosnippet-snippets', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   },
      \ }
NeoBundleLazy 'koron/codic-vim', {
      \ 'autoload' : {
      \   'commands' : 'Codic',
      \   },
      \ }
NeoBundleLazy 'rhysd/unite-codic.vim', {
      \ 'depends' : [
      \   'koron/codic-vim',
      \   'Shougo/unite.vim',
      \   ],
      \ 'autoload' : {
      \   'unite_sources' : ['codic'],
      \   },
      \ }
NeoBundleLazy 't9md/vim-choosewin', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(choosewin)',
      \     ],
      \   'commands' : 'ChooseWin',
      \   },
      \ }
NeoBundle 'kana/vim-submode'
NeoBundleLazy 'glidenote/memolist.vim', {
      \ 'autoload' : {
      \   'commands' : [
      \     'MemoNew',
      \     'MemoList',
      \     'MemoGrep',
      \     ],
      \   },
      \ }
NeoBundleLazy 'tyru/restart.vim', {
      \ 'gui' : 1,
      \ 'autoload' : {
      \   'commands' : 'Restart',
      \   }
      \ }
NeoBundleLazy 'osyo-manga/vim-anzu', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(anzu-',
      \     ],
      \   },
      \ 'vim_version' : '7.3.867',
      \ }
NeoBundleLazy 'itchyny/calendar.vim', {
      \ 'autoload' : {
      \   'commands' : 'Calendar',
      \   },
      \ }
NeoBundleLazy 'tyru/caw.vim', {
      \ 'autoload' : {
      \   'mappings' : [
      \     '<Plug>(caw:',
      \     ],
      \   },
      \ }
NeoBundleLazy 'scrooloose/syntastic', {
      \ 'autoload' : {
      \   'insert' : 1,
      \   },
      \ }
NeoBundle 'itchyny/lightline.vim'
NeoBundleLazy 'ujihisa/unite-colorscheme', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'unite_sources' : ['colorscheme'],
      \   },
      \ }
" NOTE: Omnisharp 初回導入時には端末などから以下のコマンドを実施
"       cd ~.vim/bundle/Omnisharp
"       git submodule update --init
"       cd server
"       MSBuild.exe(Windows)
"         or
"       xbuild(Mac/Linux)
"       ls -l OmniSharp/bin/Debug/OmniSharp.exe
NeoBundleLazy 'nosami/Omnisharp', {
      \ 'autoload' : {
      \   'filetypes' : ['cs'],
      \   },
      \ 'disabled' : !has('python'),
      \ 'build' : {
      \   'windows' : 'MSBuild.exe ~/.vim/bundle/Omnisharp/server/OmniSharp.sln /p:Platform="Any CPU"',
      \   'mac'     : 'xbuild server/OmniSharp.sln',
      \   'unix'    : 'xbuild server/OmniSharp.sln',
      \   }
      \ }
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundleLazy 'thinca/vim-scouter', {
      \ 'autoload' : {
      \   'commands' : [
      \     'Scouter',
      \     'Scouter!',
      \     ],
      \   },
      \ }
NeoBundleLazy 'rhysd/clever-f.vim', {
      \ 'autoload' : {
      \   'mappings' : ['f', 'F', 't', 'T'],
      \   },
      \ }
NeoBundle 'tacroe/unite-mark'
" テキストオブジェクト拡張 {{{
NeoBundle 'kana/vim-textobj-user'
" バッファ全体[ae/ie]
NeoBundle 'kana/vim-textobj-entire'
" 改行を含まないカレント行[al/il]
NeoBundle 'kana/vim-textobj-line'
" 関数内[af/if]
NeoBundle 'kana/vim-textobj-function'
" カレント行と同じインデント[ai/ii/aI/iI]
NeoBundle 'kana/vim-textobj-indent'
" }}}
" オペレータ拡張 {{{
NeoBundle 'kana/vim-operator-user'
" }}}
" カラースキーマ {{{
"NeoBundle 'rainux/vim-desert-warm-256'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'jeffreyiacono/vim-colors-wombat'
"NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
colorscheme molokai
" }}}
" }}}
"---------------------------------------
" Finalize NeoBundle {{{
"---------------------------------------
" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on
" インストールのチェック
NeoBundleCheck
" }}}

"-------------------------------------------------------------------------------
" 文字コード自動認識
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
set fileformats=unix,dos,mac
" }}}

"-------------------------------------------------------------------------------
" 基本設定
"-------------------------------------------------------------------------------
" 基本 {{{
"---------------------------------------
" バックアップファイルを作らない
set nobackup
" スワップファイルを作る
set swapfile
" スワップファイルの出力先指定（出力先が存在しない場合は自動作成）
set directory=~/.vim/swp
if !isdirectory(expand('~/.vim/swp'))
  call mkdir(expand('~/.vim/swp'), 'p')
endif
" アンドゥ関連
if has('persistent_undo')
  " アンドゥファイルを作る
  set undofile
  set undodir=~/.vim/undo
  " アンドゥファイルの出力先指定（出力先が存在しない場合は自動作成）
  if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
  endif
endif
" マッピングタイムアウト設定 マッピング2.5秒 キーコード0.1秒
set timeout timeoutlen=2500 ttimeoutlen=100
" K は man ではなく help がいい
set keywordprg=:help
" }}}
"---------------------------------------
" 外観 {{{
"---------------------------------------
" 行番号を表示する
set number
" ルーラーを表示 (noruler:非表示)
set ruler
" コマンドをコマンドラインに表示
set showcmd
" タイトルを表示
set title
" 表示できない文字を表示
set list
" listで表示する文字設定
set lcs=tab:>-,trail:_,extends:\
" カーソル行の強調表示
set cursorline
" ステータスラインを常に表示
set laststatus=2
" シンタックス
syntax enable
" 画面最後の行をできる限り表示する
set display=lastline
" マルチバイト文字(○など)があってもカーソルがずれないようにする
set ambiwidth=double
" タブページを常に表示
set showtabline=2
" 閉じ括弧が入力されたとき、対応する括弧を表示する
set showmatch
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" 長い行の折り返しをする
set wrap
" ウィンドウ開閉時に自動でウィンドウサイズを変更しない
set noequalalways
" スクロール時の余白確保
set scrolloff=5
" }}}
"---------------------------------------
" 入力／編集 {{{
"---------------------------------------
" バッファを隠れた状態にする
set hidden
" 挿入モード・検索モードでのデフォルトのIME状態設定
set iminsert=0 imsearch=0
" クリップボード連携
set clipboard=unnamed
" 新しい行のインデントを現在行と同じにする
set autoindent
" cindent有効
set cindent
" ファイル内の <tab> が対応する空白の数
set tabstop=4 shiftwidth=4 softtabstop=4
" <Tab>でSpaceを入力
set expandtab
" インデントを shiftwidth の倍数で丸め
set shiftround
" バックスペースでインデントや改行を削除できる
set backspace=indent,eol,start
" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM
AutocmdFT * setlocal formatoptions+=mM
" 改行時にコメントしない
set formatoptions-=ro
AutocmdFT * setlocal formatoptions-=ro
" 長い行を入力した際に自動で折り返さない
set textwidth=0
AutocmdFT * setlocal textwidth=0
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu
" 補完時にプレビューウィンドウを表示しない
set completeopt=menuone
" }}}
"---------------------------------------
" 検索 {{{
"---------------------------------------
" 検索時の大文字、小文字を区別
set noignorecase
" 検索時に大文字小文字の両方が含まれている場合は大文字小文字を区別
set nosmartcase
" 検索時にファイルの最後まで検索したら最初に戻らないようにする
set nowrapscan
" インクリメンタルサーチを行う
set incsearch
" migemoによるローマ字入力かなインクリメンタルサーチを有効化
if has('migemo')
  set migemo
else
endif
" }}}

"-------------------------------------------------------------------------------
" ファイルタイプ別基本設定
"-------------------------------------------------------------------------------
" vim {{{
"---------------------------------------
function! s:FileTypeSettings_vim()
  setlocal tabstop=2 shiftwidth=2 softtabstop=2
endfunction
AutocmdFT vim call s:FileTypeSettings_vim()
" }}}
"---------------------------------------
" c {{{
"---------------------------------------
function! s:FileTypeSettings_c()
  " <TAB>入力を<TAB>にする
  setlocal noexpandtab
  " switch-case文のインデントを調整
  setlocal cinoptions+=:0
endfunction
AutocmdFT c call s:FileTypeSettings_c()
" }}}
"---------------------------------------
" markdown {{{
"---------------------------------------
function! s:FileTypeSettings_markdown()
  " 折り返しを有効にする
  setlocal wrap
  " 80文字で折り返す
  setlocal textwidth=80
  " マルチバイト文字の場合も折り返しを有効にする
  setlocal formatoptions+=m

  " <TAB>入力をスペースにする
  setlocal expandtab

  " 入れ子のリストを折りたたむ
  setlocal foldmethod=expr foldexpr=MkdCheckboxFold(v:lnum) foldtext=MkdCheckboxFoldText()
  function! MkdCheckboxFold(lnum)
    let line = getline(a:lnum)
    let next = getline(a:lnum + 1)
    if MkdIsNoIndentCheckboxLine(line) && MkdHasIndentLine(next)
      return 1
    elseif (MkdIsNoIndentCheckboxLine(next) || next =~ '^$') && !MkdHasIndentLine(next)
      return '<1'
    endif
    return '='
  endfunction
  function! MkdIsNoIndentCheckboxLine(line)
    return a:line =~ '^- \[[ x]\] '
  endfunction
  function! MkdHasIndentLine(line)
    return a:line =~ '^[[:blank:]]\+'
  endfunction
  function! MkdCheckboxFoldText()
    return getline(v:foldstart) . ' (' . (v:foldend - v:foldstart) . ' lines) '
  endfunction

  "" 色指定
  "syntax match MkdCheckboxMark /-\s\[x\]\s.\+/ display containedin=ALL
  "highlight MkdCheckboxMark guifg=green ctermfg=green
  "syntax match MkdCheckboxUnmark /-\s\[\s\]\s.\+/ display containedin=ALL
  "highlight MkdCheckboxUnmark guifg=green ctermfg=red
endfunction
AutocmdFT markdown call s:FileTypeSettings_markdown()
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

" Unite source alias
let g:unite_source_alias_aliases = {
      \ "startup_file_mru" : {
      \     "source" : "file_mru",
      \   },
      \ "startup_directory_mru" : {
      \     "source" : "directory_mru",
      \   },
      \ "sort_mapping" : {
      \     "source" : "mapping",
      \   },
      \ }
call unite#custom_max_candidates("startup_file_mru", 5)
call unite#custom_max_candidates("startup_directory_mru", 5)
call unite#custom_source('sort_mapping', 'sorters', 'sorter_word')
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
      \     [ '[Unite] mapping(Unite)', 'Unite sort_mapping -input=Unite' ],
      \     [ '[Unite] mapping(Space)', 'Unite sort_mapping -input=Space' ],
      \     [ '[Unite] menu:fileencoding', 'Unite menu:fileencoding' ],
      \     [ '[Unite] menu:fileformat', 'Unite menu:fileformat' ],
      \     [ '[NeoBundle] Update', 'Unite neobundle/update -log' ],
      \     [ '[NeoBundle] Log', 'Unite neobundle/log' ],
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
"      \ -quick-match
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
"let g:my_vimshell_prompt_counter = -1
"function! s:my_vimshell_dynamic_prompt()
"  let g:my_vimshell_prompt_counter += 1
"  let anim = [
"        \        "(´･_･`)",
"        \        "( ´･_･)",
"        \        "(  ´･_)",
"        \        "(   ´･)",
"        \        "(    ´)",
"        \        "(     )",
"        \        "(     )",
"        \        "(`    )",
"        \        "(･`   )",
"        \        "(_･`  )",
"        \        "(･_･` )",
"        \    ]
"  return anim[g:my_vimshell_prompt_counter % len(anim)]
"endfunction
"let g:vimshell_prompt_expr = 's:my_vimshell_dynamic_prompt()." > "'
"let g:vimshell_prompt_pattern = '^([ ´･_･`]\{5}) > '
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
" 自動起動する
let g:neocomplete#enable_at_startup = 1
" 補完候補表示を開始する文字数
let g:neocomplete#auto_completion_start_length = 2
" 大文字小文字を違いを無視
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
" 自動選択しない
let g:neocomplete#enable_auto_select = 0
" 
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" キーワード
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
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
      \ 'hook/kawaii/enable' : 1,
      \ 'outputter/buffer/split' : ':botright 5sp',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ 'outputter/error/error' : 'quickfix',
      \ 'outputter/error/success' : 'buffer',
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 40,
      \ }
" C#用設定（MAC用設定は未検証）
if s:is_mac
  let g:quickrun_config['cs'] = {
        \ 'command' : 'cs',
        \ 'runmode' : 'simple',
        \ 'exec' : ['%c %s > /dev/null', 'mono "%S:p:r:gs?/?\\?.exe" %a', ':call delete("%S:p:r.exe")'],
        \ 'tempfile' : '{tempname()}.cs',
        \ }
elseif s:is_windows
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
      \   'kawaii',
      \   [
      \     " (*'-')? ",
      \     " (*'-')! ",
      \     " (*'-') < active!",
      \   ],
      \   40,
      \   ),
      \ 1)
" }}}

"---------------------------------------
" Omnisharp {{{
"---------------------------------------
" 補完用設定
AutocmdFT cs setlocal omnifunc=OmniSharp#Complete
" [neocomplete]による自動補完設定
" NOTE: 自動補完を行わない場合は <C-x><C-o> で手動補完
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
Autocmd BufWritePost,FileWritePost *.c,*.cs,*.cpp,*.ps,*.h call s:syntaxCheck()
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
  return winwidth(0) > 30 ? strftime("%Y/%m/%d %H:%M") : ''
endfunction
" }}}

"-------------------------------------------------------------------------------
" 基本キーマップ
"-------------------------------------------------------------------------------
" 基本 {{{
"---------------------------------------
" プレフィックスキー
nmap <Space> [Space]
xmap <Space> [Space]
nnoremap [Space] <Nop>
xnoremap [Space] <Nop>
" 押し間違え防止（Q:Exモード）
nnoremap Q <Nop>
" 押し間違え防止（～して閉じる系）
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" 検索時強調表示停止
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
" メニュー表示／非表示
map <silent> <F2> :<Bar>
      \ if &guioptions =~# 'm' <Bar>
      \   set guioptions-=T <Bar>
      \   set guioptions-=m <Bar>
      \ else <Bar>
      \   set guioptions+=T <Bar>
      \   set guioptions+=m <Bar>
      \ endif<CR>
" }}}
"---------------------------------------
" 移動 {{{
"---------------------------------------
" 折り返し行に対応
nnoremap <silent> j gj
xnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> k gk
" 0 で行の初めの非空白文字へ移動
nnoremap <silent> 0 ^
xnoremap <silent> 0 ^
" - で行末へ移動
nnoremap <silent> - $
xnoremap <silent> - $<Left>
" ^ で行頭へ移動
nnoremap <silent> ^ 0
xnoremap <silent> ^ 0
" <Tab> = %
" NOTE: matchit のマッピングを再帰的に使用するために noremap ではなく map にする
" NOTE: nmap で <TAB> を潰すと Ctrl-i でジャンプできなくなるのでコメントアウト
"nmap <TAB> %
"xmap <TAB> %
" マーク
"nnoremap <silent> mm mm
"nnoremap <silent> mu 'm
"nnoremap <silent> mn ]'
"nnoremap <silent> mp ['
" ウィンドウ移動
nnoremap <silent> <Up> <C-W>k
nnoremap <silent> <Down> <C-W>j
nnoremap <silent> <Left> <C-W>h
nnoremap <silent> <Right> <C-W>l
" }}}
"---------------------------------------
" 入力／編集 {{{
"---------------------------------------
" 補完候補表示などのポップアップメニュー表示時に<TAB>で移動可能にする
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" 日本語入力制御(Insertモード終了時に日本語入力モードを解除)
inoremap <silent> <unique> <Esc> <Esc>:set imsearch=0 iminsert=0<CR>
" 文字削除時レジスタに削除文字を登録しない
nnoremap x "_x
nnoremap X "_X
xnoremap x "_x
xnoremap X "_X
" Y で カーソル位置移行をヤンク
nnoremap <silent> Y y$
" 最後にヤンクしたテキストをプット
nnoremap <silent> [Space]p "0p
nnoremap <silent> [Space]P "0P
xnoremap <silent> [Space]p "0p
xnoremap <silent> [Space]P "0P
" ノーマルモード空行入力
nnoremap <silent> <CR> o<Esc>
nnoremap <silent> <S-CR> O<Esc>
" 現在日付を入力
inoremap <silent> <C-d>ymd <C-R>=strftime("%Y/%m/%d")<CR>
" 現在時刻を入力
inoremap <silent> <C-d>hm <C-R>=strftime("%H:%M")<CR>
"" ',' -> ',<Space>'
"inoremap <silent> , ,<Space>
"inoremap <silent> ,<CR> ,<CR>
"" ';' -> ';<Space>'
"inoremap <silent> ; ;<Space>
"inoremap <silent> ;<CR> ;<CR>
" }}}
"---------------------------------------
" タブ操作 {{{
"---------------------------------------
nnoremap <silent> te :<C-u>tabedit<CR>
nnoremap <silent> tc :<C-u>tabclose<CR>
nnoremap <silent> tf :<C-u>tabfirst<CR>
nnoremap <silent> tl :<C-u>tablast<CR>
" 下のタブ移動キーマップは submode を使用しない場合に必要
"nnoremap <silent> tn :<C-u>tabnext<CR>
"nnoremap <silent> tp :<C-u>tabprevious<CR>
" }}}
"---------------------------------------
" エディット {{{
"---------------------------------------
nnoremap <silent> [Space]ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]eg :<C-u>edit $MYGVIMRC<CR>
" }}}

"-------------------------------------------------------------------------------
" ファイルタイプ別キーマップ
"-------------------------------------------------------------------------------
" help {{{
"---------------------------------------
function! s:FileTypeMappings_help()
  " q で help を閉じる
  nnoremap <buffer> q <C-w>c
endfunction
AutocmdFT help call s:FileTypeMappings_help()
" }}}
"---------------------------------------
" markdown {{{
"---------------------------------------
function! s:FileTypeMappings_markdown()
  " ToDo 用マッピング {{{
  " todoリストを簡単に入力する
  " NOTE: 'tl ' -> '- [ ]'
  inoremap <buffer> tl<Space> - [ ]<Space>
  " todoリストのon/offを切り替える
  nnoremap <buffer> <Space><Space> :call ToggleCheckbox()<CR>
  xnoremap <buffer> <Space><Space> :call ToggleCheckbox()<CR>
  " 選択行のチェックボックスを切り替える
  " NOTE: '- [ ]' <-> '- [x]'
  function! ToggleCheckbox()
    let l:line = getline('.')
    if l:line =~ '\-\s\[\s\]'
      " 完了時刻を挿入する
      let l:result = substitute(l:line, '-\s\[\s\]', '- [x]', '') . ' [' . strftime("%Y/%m/%d (%a) %H:%M") . ']'
      call setline('.', l:result)
    elseif l:line =~ '\-\s\[x\]'
      let l:result = substitute(substitute(l:line, '-\s\[x\]', '- [ ]', ''), '\s\[\d\{4}.\+]$', '', '')
      call setline('.', l:result)
    end
  endfunction
  " }}}
endfunction
AutocmdFT markdown call s:FileTypeMappings_markdown()
" }}}

"-------------------------------------------------------------------------------
" プラグイン用キーマップ
"-------------------------------------------------------------------------------
" Unite.vim {{{
"---------------------------------------
nnoremap [Unite] <Nop>
nmap [Space]u [Unite]
nnoremap <silent> [Unite]  :<C-u>Unite sort_mapping -input=[Unite]<CR>
nnoremap <silent> [Unite]y :<C-u>Unite history/yank<CR>
nnoremap <silent> [Unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [Unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [Unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [Unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]c :<C-u>Unite codic -start-insert<CR>
nnoremap <silent> [Unite]o :<C-u>Unite -no-quit -vertical -winwidth=36 -direction=botright outline<CR>
nnoremap          [Unite]p :<C-u>Unite output:
nnoremap <silent> [Unite]u :<C-u>Unite menu:shortcut<CR>
nnoremap <silent> [Unite]n :<C-u>Unite -start-insert file/new<CR>
" UniqueSettings[grep]
nnoremap <silent> [Space]g  :<C-u>Unite sort_mapping -input=[Space]g<CR>
nnoremap <silent> [Space]gr :<C-u>Unite grep:. -no-quit -buffer-name=grep-result<CR>
nnoremap <silent> [Space]gw :<C-u>Unite grep:. -no-quit -buffer-name=grep-result<CR><C-R><C-W><CR>
nnoremap <silent> [Space]gR :<C-u>UniteResume grep-result<CR>
" UniqueSettings[Search]
nnoremap <silent> [Space]/ :<C-u>Unite line -start-insert -auto-highlight -buffer-name=search<CR>
nnoremap <silent> [Space]* :<C-u>UniteWithCursorWord line -auto-highlight -buffer-name=search<CR>
nnoremap <silent> [Space]? :<C-u>UniteResume search -no-start-insert<CR>
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
" 補完のundo
inoremap <expr><C-g> neocomplete#undo_completion()
" 補完候補共通の文字まで自動入力
inoremap <expr><C-l> neocomplete#complete_common_string()
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
xmap [Space]cc <Plug>(caw:I:toggle)
nmap [Space]ci <Plug>(caw:i:toggle)
xmap [Space]ci <Plug>(caw:i:toggle)
nmap [Space]ca <Plug>(caw:a:toggle)
xmap [Space]ca <Plug>(caw:a:toggle)
nmap [Space]cw <Plug>(caw:wrap:toggle)
xmap [Space]cw <Plug>(caw:wrap:toggle)
nmap [Space]co <Plug>(caw:jump:comment-next)
xmap [Space]co <Plug>(caw:jump:comment-next)
nmap [Space]cO <Plug>(caw:jump:comment-prev)
xmap [Space]cO <Plug>(caw:jump:comment-prev)
" コピペしてコメントアウト
" （カレント行or選択箇所をレジスタcを使用してヤンク／プットしてヤンク元をコメントアウト）
nmap [Space]cn "cyy"cp<Plug>(caw:I:toggle)k
xmap [Space]cn "cygv<Plug>(caw:I:toggle)"cP
" }}}

"-------------------------------------------------------------------------------
" autocmd
"-------------------------------------------------------------------------------
" 基本 {{{
"---------------------------------------
" 現在開いているファイルのパスに移動する
Autocmd BufEnter * execute ":lcd " . expand("%:p:h")
" vimgrep使用時にQuickFixで表示させるautocmd
Autocmd QuickfixCmdPost vimgrep cw
" }}}
"---------------------------------------
" 起動時 {{{
"---------------------------------------
" UniteStartUp（引数もバッファも指定されずに起動した際にUniteStartUpを実行）
Autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | call s:UniteStartUpExec() | endif
function! s:GetBufByte()
  let byte = line2byte(line('$') + 1)
  if byte == -1
    return 0
  else
    return byte - 1
  endif
endfunction
" 直接書けなかったからfunction化
function! s:UniteStartUpExec()
  :UniteStartUp
endfunction
" }}}

"-------------------------------------------------------------------------------
" Finalize VIM
"-------------------------------------------------------------------------------
" {{{
" }}}



"-------------------------------------------------------------------------------
" Vim-Script Test
" NOTE: help vim-script-intro, help functions
"-------------------------------------------------------------------------------
"" vim-marker {{{
""---------------------------------------
"nnoremap <unique> <script> <Plug>(mkr-init-idx)     <SID>MkInitIdx
"nnoremap <unique> <script> <Plug>(mkr-clear)        <SID>MkClear
"nnoremap <unique> <script> <Plug>(mkr-buff-add)     <SID>MkBuffAdd
""nnoremap <unique> <script> <Plug>(mkr-buff-del)     <SID>MkBuffDel
"nnoremap <unique> <script> <Plug>(mkr-buff-jump-p)  <SID>MkBuffJumpP
"nnoremap <unique> <script> <Plug>(mkr-buff-jump-n)  <SID>MkBuffJumpN
""nnoremap <unique> <script> <Plug>(mkr-file-write)   <SID>MkFileWrite
"nnoremap <unique> <script> <Plug>(mkr-list)         <SID>MkList
"nnoremap <SID>MkInitIdx   :call <SID>MkInitIdx()<CR>
"nnoremap <SID>MkClear     :call <SID>MkClear()<CR>
"nnoremap <SID>MkBuffAdd   :call <SID>MkBuffAdd()<CR>
""nnoremap <SID>MkBuffDel   :call <SID>MkBuffDel()<CR>
"nnoremap <SID>MkBuffJumpP :call <SID>MkBuffJumpP()<CR>
"nnoremap <SID>MkBuffJumpN :call <SID>MkBuffJumpN()<CR>
""nnoremap <SID>MkFileWrite :call <SID>MkFileWrite()<CR>
"nnoremap <SID>MkList      :call <SID>MkList()<CR>
"" common function
"function! s:str2list(str)
"  return split(a:str, '\zs')
"endfunction
"" variable
"if !exists('g:marker_buff_char')
"  let g:marker_buff_str = 'abcdefghijklmnopqrstuvwxyz'
"endif
"let g:marker_buff_char = s:str2list(g:marker_buff_str)
"let g:marker_buff_curidx = 0
"let g:marker_buff_list_viewer = 0
"" mapping
"" function
""function! s:MkFileRead()
""  if filereadable(expand('~/.cache/marker/.marker_save.vim'))
""    unlet g:marker_buff_curidx
""    source ~/.cache/marker/.marker_save.vim
""  else
""    call s:MkFileWrite()
""  endif
""endfunction
""function! s:MkFileWrite()
""  if !isdirectory(expand('~/.cache/marker'))
""    call mkdir(expand('~/.cache/marker'), 'p')
""  endif
""  let list = ['let g:marker_buff_curidx = ' . g:marker_buff_curidx]
""  call writefile(list, expand('~/.cache/marker/.marker_save.vim'))
""endfunction
"function! s:MkInitIdx()
"  let idx = 0
"  for mkchar in g:marker_buff_char
"    let mkpos = getpos("'" . mkchar)
"    if mkpos[1] == 0
"      unlet g:marker_buff_curidx
"      let g:marker_buff_curidx = idx
"      break
"    endif
"    let idx += 1
"  endfor
"endfunction
"function! s:MkClear()
"  call s:MkClearBuff()
"  echo ''
"endfunction
"function! s:MkClearBuff()
"  unlet g:marker_buff_curidx
"  let g:marker_buff_curidx = 0
"  execute 'delmarks' g:marker_buff_str
"endfunction
"function! s:MkBuffAdd()
"  execute 'mark' g:marker_buff_char[g:marker_buff_curidx]
"  echo 'marked' g:marker_buff_char[g:marker_buff_curidx]
"  let g:marker_buff_curidx = (g:marker_buff_curidx + 1) % len(g:marker_buff_char)
"  execute 'delmarks' g:marker_buff_char[g:marker_buff_curidx]
"endfunction
""function! s:MkBuffDel()
""  echo ''
""  let curpos = getpos(".")
""  for mkchar in g:marker_buff_char
""    let mkpos = getpos("'" . mkchar)
""    if mkpos[1] == curpos[1]
""      execute 'delmarks' mkchar
""      echo 'delmark' mkchar
""      break
""    endif
""  endfor
""endfunction
"function! s:MkBuffJumpP()
"  call feedkeys("['")
"  echo ''
"endfunction
"function! s:MkBuffJumpN()
"  call feedkeys("]'")
"  echo ''
"endfunction
"function! s:MkList()
"  echo ''
"  if g:marker_buff_list_viewer == 1
"    " unite-vim
"    " 未実装
"  elseif g:marker_buff_list_viewer == 2
"    " quickfix
"    " 未実装
"  else
"    " marks command
"    execute 'marks'
"  endif
"endfunction
"" test autocmd
""Autocmd BufEnter * call s:MkFileRead()
"Autocmd BufEnter * call s:MkInitIdx()
"" test mapping
"nmap mi <Plug>(mkr-init-idx)
"nmap mc <Plug>(mkr-clear)
"nmap mm <Plug>(mkr-buff-add)
"nmap mn <Plug>(mkr-buff-jump-n)
"nmap mp <Plug>(mkr-buff-jump-p)
""nmap md <Plug>(mkr-buff-del)
""nmap mf <Plug>(mkr-file-write)
"nmap ml <Plug>(mkr-list)
"" }}}
