" vimrc配置文件
" 移动此文件到~/.vimrc


syntax on
set mouse=a
set smartindent
set showmatch
" 显示标尺
set ruler
set number
" 设置不换行
set nowrap
set autoread

set autoindent
set cindent

" 显示command
set showcmd

set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

colorscheme desert
set t_Co=256

set tabstop=4
set shiftwidth=4
set helplang=cn

au FileType html,python,vim,javascript,sh,shell,bash setl shiftwidth=4
au FileType html,python,vim,javascript,sh,shell,bash setl tabstop=4
au FileType java,php setl shiftwidth=4
au FileType java,php setl tabstop=4

set hlsearch
filetype on
filetype plugin on
filetype indent on
set cursorline
" 高亮列
" set cursorcolumn
" 共享剪贴板
set clipboard+=unnamed
