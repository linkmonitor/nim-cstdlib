import stdio

import core
export core
#
# Local type aliases
#

type
  FILE = stdio.FILE(C.stdio)
    ## TODO: Find a way to avoid this.

#
# Types
#

type
  wint_t_private {.importc:"wint_t", header:"<wchar.h>".} = object
  wchar_t_private {.importc:"wchar_t", header:"<wchar.h>".} = object

template wint_t*(typ:type C.wchar):typedesc =
  wint_t_private

template wchar_t*(typ:type C.wchar):typedesc =
  wchar_t_private

#
# Converters
#

converter toPointer*[N,T](arr:array[N,T]):ptr[T] {.inline.} =
  cast[ptr[T]](unsafeAddr(arr[0]))

converter toWint*(n:char):C.wchar.wint_t {.inline.} =
  cast[C.wchar.wint_t](n)

converter toWchar*(n:char):C.wchar.wchar_t{.inline.} =
  cast[C.wchar.wchar_t](n)

#
# Unformatted input/output functions
#

proc fgetwc*(typ:type C.wchar, stream:ptr[FILE]):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc getwc*(typ:type C.wchar, stream:ptr[FILE]):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}


proc fgetws*[T](typ:type C.wchar, str:ptr[T], count:int, stream:ptr[FILE]):ptr[T] {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc fputwc*(typ:type C.wchar, ch:C.wchar.wchar_t, stream:ptr[FILE]):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc putwc*(typ:type C.wchar, ch:C.wchar.wchar_t, stream:ptr[FILE]):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc fputws*(typ:type C.wchar, str:ptr[C.wchar.wchar_t], stream:ptr[FILE]):int {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc getwchar*(typ:type C.wchar):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc putwchar*(typ:type C.wchar, ch:C.wchar.wchar_t):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc ungetwc*(typ:type C.wchar, ch:C.wchar.wint_t, stream:ptr[FILE]):C.wchar.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}
