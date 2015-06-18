set nocompatible
set expandtab
set ts=4
set shiftwidth=4
set ruler
set showmode
set showcmd
"set wrap linebreak textwidth=0
set wildmenu
set showmatch
set matchtime=3
set noerrorbells
set incsearch
set gdefault
set wildchar=<TAB>
set wildmode=list:longest,full
set whichwrap=h,l,~,[,]
set number
"set textwidth=80

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2

"filetype plugin indent on
set autoindent
syntax enable
:command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
set tags=tags;/
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
"syn match tab display "\t"
hi link tab Error
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" Make filetypes for json and txt
au! BufRead,BufNewFile *.json set filetype=json 
au! BufRead,BufNewFile *.txt set filetype=txt 

" kill any trailing whitespace on save
autocmd FileType c,cabal,cpp,haskell,javascript,php,python,readme,text,json,txt
  \ autocmd BufWritePre <buffer>
  \ :call <SID>StripTrailingWhitespaces()

autocmd BufRead,BufWinEnter * if &ft!='qf' | let &l:modifiable = 
  \ (&readonly ? 0 : 1) | endif

map <CR> o<Esc>k

" make htns movement keys (instead of hjkl) to be dvorak-friendly
noremap h h
noremap t j
noremap n k
noremap s l
noremap j t
noremap l n
noremap k s
noremap J T
noremap L N
noremap K S
noremap S K
" make T jump to bottom of screen (analagous to t moving down one line)
noremap T L
" make N jump to top of screen (analagous to n moving up one line)
noremap N H
" make it possible to do capital J (whatever that does)
noremap H J

" move easily to beginning and end of line in dvorak
noremap - $
noremap _ ^

" set textwrap for plain text files - not working 
" autocmd FileType text setlocal textwidth=78
