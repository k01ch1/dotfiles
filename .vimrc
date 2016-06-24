if &compatible 
set nocompatible 
endif 
 
"--------------------------------------------------------------------------- 
" 検索の挙動に関する設定: 
" 
" 検索時に大文字小文字を無視 (noignorecase:無視しない) 
set ignorecase 
" 大文字小文字の両方が含まれている場合は大文字小文字を区別 
set smartcase 


"--------------------------------------------------------------------------- 
" 編集に関する設定: 
" 
" タブの画面上での幅 
set tabstop=2 
" タブをスペースに展開する (noexpandtab:展開しない) 
set expandtab 
"expandtabで<Tab>が対応する<Space>の数 
set softtabstop=2 
" 自動的にインデントする (noautoindent:インデントしない) 
set autoindent 
" 自動インデントの幅
set shiftwidth=2
" バックスペースでインデントや改行を削除できるようにする 
set backspace=indent,eol,start 
" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない) 
set wrapscan 
" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない) 
set showmatch 
" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu) 
set wildmenu 
" テキスト挿入中の自動折り返しを日本語に対応させる 
set formatoptions+=mM 
"カーソルを行頭、行末で止まらないようにする 
set whichwrap=b,s,h,l,<,>,[,] 


"--------------------------------------------------------------------------- 
" 画面表示の設定: 

syntax enable

" 行番号を表示 (nonumber:非表示) 
set number 
" ルーラーを表示 (noruler:非表示) 
set ruler 
" タブや改行を表示 (nolist:非表示) 
set list 
" どの文字でタブや改行を表示するかを設定 
"set listchars=tab:>-,extends:<,trail:-,eol:< 
" 長い行を折り返して表示 (nowrap:折り返さない) 
set wrap 
" 常にステータス行を表示 (詳細は:he laststatus) 
set laststatus=2 
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること) 
set cmdheight=1 
" コマンドをステータス行に表示 
set showcmd 
" タイトルを表示 
set title 
" カーソル行の背景色を変える 
set cursorline 
" メッセージ表示欄を2行確保 
set cmdheight=2 

"タブ、空白、改行の可視化 
set list 
set listchars=tab:>-,trail:_,eol:$,extends:>,precedes:<,nbsp:% 

colorscheme jellybeans
"colorscheme molokai
"colorscheme desert

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

"全角スペースをハイライト表示 
function! ZenkakuSpace() 
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666 
endfunction 

if has('syntax') 
  augroup ZenkakuSpace 
    autocmd! 
    autocmd ColorScheme * call ZenkakuSpace() 
    autocmd VimEnter,WinEnter,BufRead * match ZenkakuSpace /　/ 
    "autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　') 
  augroup END 
  call ZenkakuSpace() 
endif 

" " 挿入モード時、ステータスラインの色を変更 
" """""""""""""""""""""""""""""" 
" let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=lightyellow cterm=none' 
"  
" if has('syntax') 
"   augroup InsertHook 
"     autocmd! 
"     autocmd InsertEnter * call s:StatusLine('Enter') 
"     autocmd InsertLeave * call s:StatusLine('Leave') 
"   augroup END 
" endif 
"  
" let s:slhlcmd = '' 
" function! s:StatusLine(mode) 
"   if a:mode == 'Enter' 
"     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine') 
"     silent exec g:hi_insert 
"   else 
"     highlight clear StatusLine 
"     silent exec s:slhlcmd 
"   endif 
" endfunction 
"  
" function! s:GetHighlight(hi) 
"   redir => hl 
"   exec 'highlight '.a:hi 
"   redir END 
"   let hl = substitute(hl, '[\r\n]', '', 'g') 
"   let hl = substitute(hl, 'xxx', '', '') 
"   return hl 
" endfunction 
" """""""""""""""""""""""""""""" 

set noshowmode

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode'
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


"--------------------------------------------------------------------------- 
" ファイル操作に関する設定 
" 
" バックアップファイルの設定
set backupdir=~/.vim/tmp 
set nobackup 

" スワップファイルの設定 
set directory=~/.vim/tmp 
set noswapfile


"--------------------------------------------------------------------------- 
" 新しいウィンドウを下に開く 
set splitbelow 
" 新しいウィンドウを右に開く 
set splitright 
" netrwで新しいウィンドウを下に分割する 
let g:netrw_alto = 1 
" netrwで新しいウィンドウを右に分割する 
let g:netrw_altv = 1 

" NERDTreeの設定
let NERDTreeShowHidden = 1 "隠しファイルをデフォルトで表示
" ファイル名が指定されてVIMが起動した場合はNERDTreeを表示しない
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"NERDTreeをCnt+eでトグル
nnoremap <silent><C-e> :NERDTreeToggle<CR> 

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')


"--------------------------------------------------------------------------- 
" ファイル名に大文字小文字の区別がないシステム用の設定: 
" (例: DOS/Windows/MacOS) 
" 
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC') 
" tagsファイルの重複防止 
  set tags=./tags,tags 
endif 


"--------------------------------------------------------------------------- 
"" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くならない対応 
if !has('gui_running') && has('xterm_clipboard') 
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen 
endif 


"--------------------------------------------------------------------------- 
" プラットホーム依存の特別な設定 
" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac') 
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正 
  set iskeyword=@,48-57,_,128-167,224-235 
endif 


"--------------------------------------------------------------------------- 
"Gundoの設定
if has('persistent_undo')
    set undodir=~/.vimundo
    set undofile
endif

nnoremap <SPACE>g :GundoToggle<CR>


"--------------------------------------------------------------------------- 
"dein Scripts-----------------------------
" Required:
set runtimepath^=/home/pi/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/home/pi/.vim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('scrooloose/nerdtree')
call dein#add('tomtom/tcomment_vim') "コメントON/OFFを手軽に実行 command:Ctrl+-
call dein#add('bronson/vim-trailing-whitespace') "行末の半角スペースを可視化&削除
call dein#add('itchyny/lightline.vim') "ステータスライン拡張
call dein#add('nanotech/jellybeans.vim')
call dein#add('tomasr/molokai')
call dein#add('sjl/gundo.vim')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"--------------------------------------------------------------------------- 
"prefix keys
inoremap <C-b> <LEFT> 
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-f> <RIGHT> 

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <CR> a<CR><ESC> 

"現在行の下に空行挿入 
inoremap <C-o> <ESC>o 

" セットで括弧入力時に自動で中に移動 
" inoremap {} {}<LEFT> 
" inoremap [] []<LEFT> 
" inoremap () ()<LEFT> 
" inoremap "" ""<LEFT> 
" inoremap '' ''<LEFT> 
" inoremap <> <><LEFT> 

" 括弧入力時に自動で閉じ括弧を入力 
inoremap {<Enter> {}<Left><CR><ESC><S-o> 
inoremap [<Enter> []<Left><CR><ESC><S-o> 
inoremap (<Enter> ()<Left><CR><ESC><S-o> 

" 日付挿入マクロ 
inoremap <Leader>date <C-R>=strftime('%Y/%m/%d (%a)')<CR> 
inoremap <Leader>time <C-R>=strftime('%H:%M')<CR> 
inoremap <Leader>w3cd <C-R>=strftime('%Y-%m-%d %H:%M:%S +09:00')<CR> 
