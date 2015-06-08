let s:libdir = expand('<sfile>:p:h:h') . '/go'

if !filereadable(s:libdir . '/libfizzbuzz.so')
  exe "!cd " . s:libdir . " && make"
endif

function! fizzbuzz#start()
python<<EOS
import vim
import thread
import time
from ctypes import *

libfizzbuzz = CDLL(vim.eval('s:libdir') + '/libfizzbuzz.so')
libfizzbuzz.fizzbuzz.restype = c_char_p

def run():
  while True:
    vim.eval("fizzbuzz#on_fizzbuzz('%s')" % libfizzbuzz.fizzbuzz())
    time.sleep(1)

thread.start_new_thread(run, ())
EOS
endfunction

function! fizzbuzz#on_fizzbuzz(s)
  if mode() != 'n'
    return
  endif
  echo a:s
endfunction
