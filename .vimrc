"-------------------------------------------------------------------------------
" ��{�ݒ�
"-------------------------------------------------------------------------------
" {{{
" �s�ԍ���\������
set number
" ���[���[��\�� (noruler:��\��)
set ruler
" �V�����s�̃C���f���g�����ݍs�Ɠ����ɂ��Ȃ��i�����ɂ���:autoindent�j
set noautoindent
" �N���b�v�{�[�h��Windows�ƘA�g
set clipboard=unnamed
" �o�b�N�A�b�v�t�@�C�������Ȃ�
set nobackup
" �X���b�v�t�@�C�������
set swapfile
" �X���b�v�t�@�C���̏o�͐�w��
set directory=~/.vim/swp
" <Tab>�\��
set list
" list�ŕ\�����镶���ݒ�
set lcs=tab:>-,trail:_,extends:\
" �t�@�C������ <tab> ���Ή�����󔒂̐�
set tabstop=4 shiftwidth=4
" <Tab>��Tab�����
set expandtab
" �C���f���g�� shiftwidth �̔{���Ŋۂ�
set shiftround
" �����ʂ����͂��ꂽ�Ƃ��A�Ή����銇�ʂ�\������
set showmatch
" �o�b�N�X�y�[�X�ŃC���f���g����s���폜�ł���
set backspace=indent,eol,start
" �������̑啶���A�����������
set noignorecase
" �������ɑ啶���������̗������܂܂�Ă���ꍇ�͑啶�������������
set smartcase
" �������Ƀt�@�C���̍Ō�܂Ō���������ŏ��ɖ߂�Ȃ��悤�ɂ���
set nowrapscan
" �C���N�������^���T�[�`���s��
set incsearch
" �J�[�\���s�̋����\��
set cursorline
" �����s�̐܂�Ԃ�
set nowrap
" �E�B���h�E�J���Ɏ����ŃE�B���h�E�T�C�Y��ύX���Ȃ�
set noequalalways
" �R�}���h���C���⊮����Ƃ��ɋ������ꂽ���̂��g��(�Q�� :help wildmenu)
set wildmenu
" �e�L�X�g�}�����̎����܂�Ԃ�����{��ɑΉ�������
set formatoptions+=mM
" �R�}���h���C���̍��� (Windows�pgvim�g�p����gvimrc��ҏW���邱��)
set cmdheight=2
" �R�}���h���X�e�[�^�X�s�ɕ\��
set showcmd
" �^�C�g����\��
set title
" �}�����[�h�E�������[�h�ł̃f�t�H���g��IME��Ԑݒ�
set iminsert=0 imsearch=0
" �X�e�[�^�X���C������ɕ\��
set laststatus=2
" �V���^�b�N�X
syntax on
" ��ʍŌ�̍s���ł������\������
set display=lastline
" migemo�ɂ�郍�[�}�����͂��ȃC���N�������^���T�[�`��L����
if has('migemo')
  set migemo
else
endif
" �⊮���Ƀv���r���[�E�B���h�E��\�����Ȃ�
" NOTE: help completeopt
set completeopt=menuone
" }}}

"-------------------------------------------------------------------------------
" �t�@�C���^�C�v�ʊ�{�ݒ�
"-------------------------------------------------------------------------------
" runtimepath�ݒ� {{{
"---------------------------------------
" vim�N�����̂�runtimepath�� ~/.vim ��ǉ�
" NOTE: �t�@�C���^�C�v�ʐݒ�� ~/.vim/ftplugin ���Œ�`
if has('vim_starting')
  set runtimepath+=~/.vim/
endif
" }}}

"-------------------------------------------------------------------------------
" �����R�[�h�̎����F��
"-------------------------------------------------------------------------------
" {{{
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconv��eucJP-ms�ɑΉ����Ă��邩���`�F�b�N
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconv��JISX0213�ɑΉ����Ă��邩���`�F�b�N
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodings���\�z
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
  " �萔������
  unlet s:enc_euc
  unlet s:enc_jis
endif
" ���{����܂܂Ȃ��ꍇ�� fileencoding �� encoding ���g���悤�ɂ���
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
" ���s�R�[�h�̎����F��
"set fileformats=dos,unix,mac
set fileformats=unix,dos,mac
" ���Ƃ����̕����������Ă��J�[�\���ʒu������Ȃ��悤�ɂ���
if exists('&ambiwidth')
  set ambiwidth=double
endif
" }}}

"-------------------------------------------------------------------------------
" �v���O�C���Ǘ�
"-------------------------------------------------------------------------------
" �W���v���O�C���Ǎ� {{{
"---------------------------------------
" matchit.vim�iif-endif �Ȃǂ� % �ňړ��\�Ƃ���j
runtime macros/matchit.vim
" }}}
"---------------------------------------
" NeoBundle {{{
"---------------------------------------
" vim�N�����̂�runtimepath��neobundle.vim��ǉ�
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
" neobundle.vim�̏�����
call neobundle#rc(expand('~/.vim/bundle'))
" NeoBundle���X�V���邽�߂̐ݒ�
NeoBundleFetch 'Shougo/neobundle.vim'
" �ǂݍ��ރv���O�C��
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
" �J���[�X�L�[�}
"NeoBundle 'rainux/vim-desert-warm-256'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'jeffreyiacono/vim-colors-wombat'
"NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
" �ǂݍ��񂾃v���O�C�����܂߁A�t�@�C���^�C�v�̌��o�A�t�@�C���^�C�v�ʃv���O�C��/�C���f���g��L��������
filetype plugin indent on
" �C���X�g�[���̃`�F�b�N
NeoBundleCheck
" }}}

"-------------------------------------------------------------------------------
" �v���O�C���ݒ�
"-------------------------------------------------------------------------------
" Unite.vim {{{
"---------------------------------------
" Insert���[�h�ŊJ�n
"let g:unite_enable_start_insert = 1
" yank����ON
let g:unite_source_history_yank_enable = 1

" Unite source ���ʐݒ�
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
" �J�X�^�}�C�Y���j���[
if !exists("g:unite_source_menu_menus")
  let g:unite_source_menu_menus = {}
endif
" [shortcut]���j���[
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
" [fileencoding]���j���[
let g:unite_source_menu_menus.fileencoding = {
  \ 'description' : 'fileencode change menu',
  \ 'command_candidates' : [
  \     [ 'fileencoding=utf-8', 'set fileencoding=utf-8' ],
  \     [ 'fileencoding=euc-jp', 'set fileencoding=euc-jp' ],
  \     [ 'fileencoding=cp932', 'set fileencoding=cp932' ],
  \   ]
  \ }
" [fileformat]���j���[
let g:unite_source_menu_menus.fileformat = {
  \ 'description' : 'fileformat change menu',
  \ 'command_candidates' : [
  \     [ 'fileformat=unix', 'set fileformat=unix' ],
  \     [ 'fileformat=mac', 'set fileformat=mac' ],
  \     [ 'fileformat=dos', 'set fileformat=dos' ],
  \   ]
  \ }

" g:unite_source_alias_aliases�ɐݒ肵��source�����g�p����
" �X�^�[�g�A�b�v�R�}���h
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
" VimFiler���f�t�H���g��
let g:vimfiler_as_default_explorer = 1
" VimFiler�̃Z�[�t���[�h���f�t�H���g�ŉ����i�t�@�C������\�ɂ���j
let g:vimfiler_safe_mode_by_default = 0
" VimFiler���\�����Ă���f�B���N�g���Ɏ����ňړ�
let g:vimfiler_enable_auto_cd = 1
" }}}

"---------------------------------------
" vimshell {{{
"---------------------------------------
" ���I�v�����v�g�ݒ�
let g:my_vimshell_prompt_counter = -1
function! g:my_vimshell_dynamic_prompt()
  let g:my_vimshell_prompt_counter += 1
  let anim = [
        \        "(�L�_�`)",
        \        "( �L�_�)",
        \        "(  �L�_)",
        \        "(   �L�)",
        \        "(    �L)",
        \        "(     )",
        \        "(     )",
        \        "(`    )",
        \        "(�`   )",
        \        "(_�`  )",
        \        "(�_�` )",
        \    ]
  return anim[g:my_vimshell_prompt_counter % len(anim)]
endfunction
let g:vimshell_prompt_expr = 'g:my_vimshell_dynamic_prompt()." > "'
let g:vimshell_prompt_pattern = '^([ �L�_�`]\{5}) > '
" }}}

"---------------------------------------
" vim-choosewin {{{
"---------------------------------------
" �I�[�o�[���C�@�\��L��
let g:choosewin_overlay_enable = 1
" �I�[�o�[���C���A�}���`�o�C�g�������܂ރo�b�t�@�ŁA���x�������������̂�h��
let g:choosewin_overlay_clear_multibyte = 1
" ���n���J�[�\���_�ł��Ȃ�
let g:choosewin_blink_on_land = 0
" �X�e�[�^�X���C�����v���C�X�i0:���� 1:�L���j
let g:choosewin_statusline_replace = 0
" �^�u���C�����v���C�X�i0:���� 1:�L���j
let g:choosewin_tabline_replace = 1
" }}}

"---------------------------------------
" vim-submode {{{
"---------------------------------------
" �E�B���h�E�T�C�Y�ύX���[�h
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
" �^�u�ړ����[�h
call submode#enter_with('changetab', 'n', '', 'tn', 'gt')
call submode#enter_with('changetab', 'n', '', 'tp', 'gT')
call submode#map('changetab', 'n', '', 'n', 'gt')
call submode#map('changetab', 'n', '', 'p', 'gT')
" }}}

"---------------------------------------
" memolist.vim {{{
"---------------------------------------
" PATH�i�f�t�H���g:~/memo�j
let g:memolist_path = '~/.vim/memo'
" �����^�C�v�i�f�t�H���g:markdown�j
"let g:memolist_memo_suffix = 'txt'
" unite.vim���g�p�i�f�t�H���g:0�j
let g:memolist_unite = 1
" unite.vim�I�v�V�����i�f�t�H���g:empty�j
let g:memolist_unite_option = '-auto-preview'
" }}}

"---------------------------------------
" restart.vim {{{
"---------------------------------------
" �I�����ɕۑ�����Z�b�V�����I�v�V������ݒ肷��
let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'
" }}}

"---------------------------------------
" caw.vim {{{
"---------------------------------------
" caw.vim �̃f�t�H���g�L�[�}�b�s���O���g�p����(0)����(1)��
let g:caw_no_default_keymappings = 1
" �R�����g�}�����ɃR�����g������̌�ɑ}�����镶���^�}�����[�h���ۂ�
" [i]�n�R�����g
let g:caw_i_sp = ""
let g:caw_i_sp_blank = " "
let g:caw_i_startinsert_at_blank_line = 1
" [I]�n�R�����g
let g:caw_I_sp = ""
let g:caw_I_sp_blank = " "
let g:caw_I_startinsert_at_blank_line = 1
" [a]�n�R�����g
let g:caw_a_sp_left = " "
let g:caw_a_sp_right = " "
let g:caw_a_startinsert = 1
" wrap�R�����g
let g:caw_wrap_sp_left = " "
let g:caw_wrap_sp_right = " "
let g:caw_wrap_skip_blank_line = 1
let g:caw_wrap_align = 1
" }}}

"---------------------------------------
" syntastic {{{
"---------------------------------------
" �����Ń`�F�b�N����i�`�F�b�N�^��`�F�b�N���X�g�j
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': ['html'],
  \ }
let g:syntastic_enable_signs = 1
" �G���[�̍ۂ�Quickfix�������オ��(1)����(2)��
" NOTE: Quickfix�������オ��(1)�ɂ����lightline�Ƃ̊֌W�����������Ȃ�
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
" �X�j�y�b�g�t�@�C���̕ۑ��f�B���N�g����ݒ�
let g:neosnippet#snippets_directory = '~/.vim/snippets'
" }}}

"---------------------------------------
" vim-quickrun {{{
"---------------------------------------
let g:quickrun_config = {}
" ��{�ݒ�
" runner�I�v�V�����F���s���@�ݒ�i�񓯊����s�^�X�V�Ԋu40�b�j
" outputter�I�v�V�����F�o�b�t�@�̊J�����ݒ�i���������^�E�B���h�E�̍���5�s�^�o�͂��Ȃ��ꍇ�͎����ŕ���j
let g:quickrun_config['_'] = {
  \ 'hook/vimshellkawaii/enable' : 1,
  \ 'outputter/buffer/split' : ':botright 5sp',
  \ 'outputter/buffer/close_on_empty' : 1,
  \ 'outputter/error/error' : 'quickfix',
  \ 'outputter/error/success' : 'buffer',
  \ 'runner' : 'vimproc',
  \ 'runner/vimproc/updatetime' : 40,
  \ }
" C#�p�ݒ�iMAC�p�ݒ�͖����؁j
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
" QuickRun���ɃR�}���h���C���ɕ\������A�j���[�V����
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
" �⊮�p�ݒ�
augroup AutoSetOmnifunc
  autocmd!
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
augroup END
" [neocomplete]�ɂ�鎩���⊮�ݒ�
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'
" }}}

"---------------------------------------
" lightline.vim {{{
"---------------------------------------
" ���̃v���O�C������̃X�e�[�^�X���C���̏㏑����}��
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
" �V���^�b�N�X�`�F�b�N�������ł��Ȃ��iAutoSyntaxCheck�Ń`�F�b�N���郊�X�g���w��j
" lightline�Ƃ̊֘A��passive�ɂ���K�v����
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
" �L�[�}�b�v
"-------------------------------------------------------------------------------
" ��{ {{{
"---------------------------------------
" �v���t�B�b�N�X�L�[
nmap <Space> [Space]
vmap <Space> [Space]
nnoremap [Space] <Nop>
vnoremap [Space] <Nop>
" �����ԈႦ�h�~�iQ:Ex���[�h�j
nnoremap Q <Nop>
" �����ԈႦ�h�~�i�`���ĕ���n�j
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" ���j���[�\���^��\��
map <silent> <F2> :if &guioptions =~# 'm' <Bar>
                 \   set guioptions-=T <Bar>
                 \   set guioptions-=m <Bar>
                 \ else <Bar>
                 \   set guioptions+=T <Bar>
                 \   set guioptions+=m <Bar>
                 \ endif<CR>
" }}}
"---------------------------------------
" ���́^�ҏW {{{
"---------------------------------------
" ���{����͐���(Insert���[�h�I�����ɓ��{����̓��[�h������)
inoremap <silent> <unique> <Esc> <Esc>:set imsearch=0 iminsert=0<CR>
" �����폜�����W�X�^�ɍ폜������o�^���Ȃ�
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X
" �A��put
nnoremap <silent> [Space]p "0p
vnoremap <silent> [Space]p "0p
" ��s����
nmap <silent> [Space]o o<Esc>
" }}}
"---------------------------------------
" �^�u���� {{{
"---------------------------------------
nnoremap <silent> te :<C-u>tabedit<CR>
nnoremap <silent> tc :<C-u>tabclose<CR>
" ���̃^�u�ړ��L�[�}�b�v�� submode ���g�p���Ȃ��ꍇ�ɕK�v
"nnoremap <silent> tn :<C-u>tabnext<CR>
"nnoremap <silent> tp :<C-u>tabprevious<CR>
" }}}
"---------------------------------------
" �G�f�B�b�g {{{
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
" �W���R�����g�R�}���h
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
" �R�s�y���ăR�����g�A�E�g
" �i�J�����g�sor�I���ӏ������W�X�^c���g�p���ă����N�^�v�b�g���ă����N�����R�����g�A�E�g�j
nmap [Space]cn "cyy"cp<Plug>(caw:I:toggle)k
vmap [Space]cn "cygv<Plug>(caw:I:toggle)"cP
" }}}

"-------------------------------------------------------------------------------
" autocmd
"-------------------------------------------------------------------------------
" ��{ {{{
"---------------------------------------
augroup AutoMyBasicCmd
  autocmd!
  " ���݊J���Ă���t�@�C���̃p�X�Ɉړ�����
  autocmd BufEnter * execute ":lcd " . expand("%:p:h")
  "autocmd BufEnter,BufRead * execute ":lcd " . expand("%:p:h")
  " vimgrep�g�p����QuickFix�ŕ\��������autocmd
  autocmd QuickfixCmdPost vimgrep cw
  " �R�����g�̃I�[�g�C���f���g��OFF
  " �Q�l�y�[�W: http://d.hatena.ne.jp/dayflower/20081208/1228725403
  if has('autocmd')
    autocmd FileType * let &l:comments=join(filter(split(&l:comments, ','), 'v:val =~ "^[sme]"'), ',')
  endif
augroup END
" }}}
"---------------------------------------
" �N���� {{{
"---------------------------------------
augroup AutoMyStartUpCmd
  autocmd!
  " UniteStartUp�i�������o�b�t�@���w�肳�ꂸ�ɋN�������ۂ�UniteStartUp�����s�j
  autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | call s:UniteStartUpExec() | endif
  function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
    if byte == -1
      return 0
    else
      return byte - 1
    endif
  endfunction
  " �Ȃ������ڏ����Ȃ���������function��
  function! s:UniteStartUpExec()
    :UniteStartUp
  endfunction
augroup END
" }}}
