import stdio

import core
export core

# TODO: This is an aggressive way to make WideCString available.
import system
export system

#
# Local type aliases
#

type
  FILE = stdio.FILE(C)
    ## TODO: Find a way to avoid this.

#
# Types
#

type
  wint_t_private {.importc:"wint_t", header:"<wchar.h>".} = object
  wchar_t_private {.importc:"wchar_t", header:"<wchar.h>".} = object

template wint_t*(typ:type C):typedesc =
  wint_t_private

template wchar_t*(typ:type C):typedesc =
  wchar_t_private

#
# Converters
#

converter toPointer*[N,T](arr:array[N,T]):ptr[T] {.inline.} =
  cast[ptr[T]](unsafeAddr(arr[0]))

converter toWint*(n:char):C.wint_t {.inline.} =
  cast[C.wint_t](n)

converter toWchar*(n:char):C.wchar_t{.inline.} =
  cast[C.wchar_t](n)

#
# Unformatted input/output functions
#

proc fgetwc*(typ:type C, stream:ptr[FILE]):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc getwc*(typ:type C, stream:ptr[FILE]):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}


proc fgetws*[T](typ:type C, str:ptr[T], count:int, stream:ptr[FILE]):ptr[T] {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc fputwc*(typ:type C, ch:C.wchar_t, stream:ptr[FILE]):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc putwc*(typ:type C, ch:C.wchar_t, stream:ptr[FILE]):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc fputws*(typ:type C, str:ptr[C.wchar_t], stream:ptr[FILE]):int {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc getwchar*(typ:type C):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc putwchar*(typ:type C, ch:C.wchar_t):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

proc ungetwc*(typ:type C, ch:C.wint_t, stream:ptr[FILE]):C.wint_t {.
  importc,
  header:"<wchar.h>",
  discardable,
  .}

#
# Formatted input/output functions
#

proc wscanf*(typ:type C, format:ptr[C.wchar_t]):int {.
  importc,
  header:"<wchar.h>",
  varargs,
  discardable,
  .}

proc fwscanf*(typ:type C, stream:ptr[FILE], format:ptr[C.wchar_t]):int {.
  importc,
  header:"<wchar.h>",
  varargs,
  discardable,
  .}

proc swscanf*[T](typ:type C, buffer:ptr[T], format:ptr[C.wchar_t]):int {.
  importc,
  header:"<wchar.h>",
  varargs,
  discardable,
  .}

# TODO: Implement
#
# - vscanf()
# - vfscanf()
# - vsscanf()

proc wprintf*(typ:type C, format:ptr[C.wchar_t]):int {.
  importc,
  header:"<wchar.h>",
  varargs,
  discardable,
  .}

proc fwprintf*(typ:type C, stream:ptr[FILE], format:ptr[C.wchar_t]):int {.
  importc,
  header:"<wchar.h>",
  varargs,
  discardable,
  .}

proc swprintf*[T](typ:type C, buffer:ptr[T], bufsz:csize, format:ptr[C.wchar_t]):int {.
  importc,
  header:"<wchar.h>",
  varargs,
  discardable,
  .}

# TODO: Implement
#
# - vwprintf()
# - vfwprintf()
# - vswprintf()
