"-------------------------------------------------------------------------------
" GVIM��{�ݒ�
"-------------------------------------------------------------------------------
set ambiwidth=double
"---------------------------------------
" �t�H���g�ݒ�u�l�r �S�V�b�N�v
" �i���p�S�p�F�l�r �S�V�b�N�^�T�C�Y9.5�j
" NOTE: �W��
"---------------------------------------
"set guifont=MS_Gothic:h9.5:cSHIFTJIS
"---------------------------------------
" �t�H���g�ݒ�uConsolas�v
" �i���p�FConsolas�^�T�C�Y9.5 or Lucida_Console�^�T�C�Y9.5�j
" �i�S�p�F�l�r �S�V�b�N�^�T�C�Y9.5�j
" NOTE: ���p�S�p��ʂɐݒ肷��ꍇ�́A[encoding="UTF-8"]�ƂȂ��Ă��Ȃ��Ƃ����Ȃ�
"       [encoding="UTF-8"]�ɂ���ɂ�vim�t�H���_�́uswitches/enabled�v�Ɂuswitches/catalog�v�́uutf-8.vim�v���R�s�[����
"       [encoding="UTF-8"]�ɕύX����Ɠ��{��֘A�ŗl�X�Ȗ�肪��������
"---------------------------------------
"set guifont=Consolas:h9.5,Lucida_Console:h9.5
"set guifontwide=MS_Gothic:h9.5:cSHIFTJIS
"---------------------------------------
" �t�H���g�ݒ�uRicty_Diminished�v
" �i���p�S�p�FRicty_Diminished�^�T�C�Y10.5�j
" NOTE: ���{�ꂪ�������Â炢���A�p�����͌��₷��
"---------------------------------------
"set guifont=Ricty_Diminished:h10.5:cSHIFTJIS
"---------------------------------------
" �t�H���g�ݒ�uMeiryoKe_Console�v
" �i���p�S�p�FMeiryoKe_Console�^�T�C�Y9.5�j
" NOTE: ���{����Y�킾���ǁA�p�����ƑS�p���p�J�b�R�����Â炢
"---------------------------------------
"set guifont=MeiryoKe_Console:h9.5:cSHIFTJIS
"---------------------------------------
" �t�H���g�ݒ�uConsolas�v
" �i���p�FConsolas�^�T�C�Y9�j
" �i�S�p�F�t�H���g�����N���ꂽ�t�H���g�^�T�C�Y�����j
" NOTE: ���W�X�g�����C�����t�H���g�����N���Ă��Ȃ��ꍇ�͓��{�ꂪ������
"---------------------------------------
set guifont=Consolas:h9:cSHIFTJIS
"---------------------------------------
" �����_�����O�I�v�V����
"---------------------------------------
" DirectWrite��L���ɂ���i����:��j
" NOTE: renderoptions��[encoding="UTF-8"]�A[has('directx')]�AVista�ȍ~�Ŏg�p�\
if has('directx') && &encoding ==# 'utf-8'
  set renderoptions=type:directx
  "set renderoptions=type:directx,renmode:5,taamode:1
endif

"---------------------------------------
" �F�e�[�}
"---------------------------------------
"colorscheme pablo
colorscheme molokai

"---------------------------------------
" ���j���[�^�c�[���o�[
"---------------------------------------
" ���j���[�폜
set guioptions-=m
" �c�[���o�[�폜
set guioptions-=T

"---------------------------------------
" �X�N���[���o�[
"---------------------------------------
" ���X�N���[���o�[��\��
set guioptions+=b

"---------------------------------------
" �^�u���C��
"---------------------------------------
" �^�u�y�[�W����ɕ\��
set showtabline=2
" GVim�ł��e�L�X�g�x�[�X�̃^�u�y�[�W���g��
set guioptions-=e

"---------------------------------------
" �E�B���h�E
"---------------------------------------
"" �E�C���h�E�̕�
"set columns=120
"" �E�C���h�E�̍���
"set lines=39
" �E�B���h�E���ő剻���ċN��
autocmd GUIEnter * simalt ~x
" �E�C���h�E�̕\���ʒu�i����̍��W�j
winpos 50 20
" �n�C���C�g�L��
if &t_Co > 2 || has('gui_running')
  syntax on
  set hlsearch
endif
" �R�}���h���C���̍���(GUI�g�p��)
set cmdheight=2

"---------------------------------------
" �}�E�X
"---------------------------------------
" �ǂ̃��[�h�ł��}�E�X���g����悤�ɂ���
set mouse=a
" �}�E�X�̈ړ��Ńt�H�[�J�X�������I�ɐؑւ��Ȃ� (mousefocus:�ؑւ�)
set nomousefocus
" ���͎��Ƀ}�E�X�|�C���^���B�� (nomousehide:�B���Ȃ�)
set mousehide
