"-------------------------------------------------------------------------------
" Initialize GVIM
"-------------------------------------------------------------------------------
" {{{
scriptencoding utf-8
" autocmd
augroup MyGVimrc
  autocmd!
augroup END
" autocmd command
command! -nargs=* Autocmd autocmd MyGVimrc <args>
command! -nargs=* AutocmdFT autocmd MyGVimrc FileType <args>
" 環境判定用変数
" NOTE: 今は未使用
let s:windows = has('win32') || has('win64') || has('win32unix')
let s:unix = has('unix')
let s:mac = has('mac') || has('macunix')
" }}}

"-------------------------------------------------------------------------------
" GVIM基本設定
"-------------------------------------------------------------------------------
" {{{
set ambiwidth=double
" }}}
"---------------------------------------
" フォント設定 {{{
"---------------------------------------
if has('win32')
  " 「ＭＳ ゴシック」
  " （半角全角：ＭＳ ゴシック／サイズ9.5）
  " NOTE: 標準
  "set guifont=MS_Gothic:h9.5:cSHIFTJIS

  " 「Consolas」
  " （半角：Consolas／サイズ9.5 or Lucida_Console／サイズ9.5）
  " （全角：ＭＳ ゴシック／サイズ9.5）
  " NOTE: 半角全角を別に設定する場合は、[encoding="UTF-8"]となっていないといけない
  "       [encoding="UTF-8"]にするにはvimフォルダの「switches/enabled」に「switches/catalog」の「utf-8.vim」をコピーする
  "       [encoding="UTF-8"]に変更すると日本語関連で様々な問題が発生する
  "set guifont=Consolas:h9.5,Lucida_Console:h9.5
  "set guifontwide=MS_Gothic:h9.5:cSHIFTJIS

  " 「Ricty_Diminished」
  " （半角全角：Ricty_Diminished／サイズ10.5）
  " NOTE: 日本語が少し見づらいが、英数字は見やすい
  "set guifont=Ricty_Diminished:h10.5:cSHIFTJIS

  " 「MeiryoKe_Console」
  " （半角全角：MeiryoKe_Console／サイズ9.5）
  " NOTE: 日本語は綺麗だけど、英数字と全角半角カッコが見づらい
  "set guifont=MeiryoKe_Console:h9.5:cSHIFTJIS

  " 「Consolas」
  " （半角：Consolas／サイズ9）
  " （全角：フォントリンクされたフォント／サイズ同じ）
  " NOTE: レジストリを修正しフォントリンクしていない場合は日本語が化ける
  set guifont=Consolas:h9:cSHIFTJIS

elseif has('unix')
  " 「Monospace」
  " （半角全角：Monospace／サイズ12）
  " NOTE: 端末の標準フォントと同じ
  set guifont=Monospace\ 12

endif
" }}}

"---------------------------------------
" レンダリングオプション
"---------------------------------------
" {{{
if has('win32')
  " DirectWriteを有効にする（無効:空）
  " NOTE: renderoptionsは[encoding="UTF-8"]、[has('directx')]、Vista以降で使用可能
  if has('directx') && &encoding ==# 'utf-8'
    set renderoptions=type:directx
    "set renderoptions=type:directx,renmode:5,taamode:1
  endif
  " }}}
endif

"---------------------------------------
" 色テーマ {{{
"---------------------------------------
"colorscheme pablo
colorscheme molokai
" }}}

"---------------------------------------
" メニュー／ツールバー {{{
"---------------------------------------
" メニュー削除
set guioptions-=m
" ツールバー削除
set guioptions-=T
" }}}

"---------------------------------------
" スクロールバー {{{
"---------------------------------------
" 横スクロールバーを表示
set guioptions+=b
" }}}

"---------------------------------------
" タブライン {{{
"---------------------------------------
" タブページを常に表示
set showtabline=2
" GVimでもテキストベースのタブページを使う
set guioptions-=e
" }}}

"---------------------------------------
" ウィンドウ {{{
"---------------------------------------
if has('win32')
  " ウィンドウを最大化して起動
  Autocmd GUIEnter * simalt ~x
elseif has('unix')
  " ウインドウの幅
  set columns=120
  " ウインドウの高さ
  set lines=39
endif
" ウインドウの表示位置（左上の座標）
winpos 50 30
" ハイライト有効
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif
" コマンドラインの高さ(GUI使用時)
set cmdheight=2
" }}}

"---------------------------------------
" マウス {{{
"---------------------------------------
" どのモードでもマウスを使えるようにする
set mouse=a
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide
" }}}

"-------------------------------------------------------------------------------
" Finalize
"-------------------------------------------------------------------------------
" {{{
unlet s:windows
unlet s:unix
unlet s:mac
" }}}
