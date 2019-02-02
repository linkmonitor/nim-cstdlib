import core
export core

converter toPointer*[N,T](arr:array[N,T]):ptr[T] {.inline.} =
  cast[ptr[T]](unsafeAddr(arr[0]))

converter toInt*(n:char):int {.inline.} =
  result = cast[int](n)

#
# Types
#

type
  FILE_private {.importc:"FILE", header:"<stdio.h>".} = object

template FILE*(typ:type C.stdio):typedesc =
  FILE_private

#
# Variables and defines
#

template NULL*(typ:type C.stdio):auto =
  var null {.
    global,
    importc:"NULL",
    header:"<stdio.h>",
    .}:pointer
  null

template IOFBF*(typ:type C.stdio):auto =
  var iofbf {.
    global,
    importc:"_IOFBF",
    header:"<stdio.h>",
    .}:int
  iofbf

template IOLBF*(typ:type C.stdio):auto =
  var iolbf {.
    global,
    importc:"_IOLBF",
    header:"<stdio.h>",
    .}:int
  iolbf

template IONBF*(typ:type C.stdio):auto =
  var ionbf {.
    global,
    importc:"_IONBF",
    header:"<stdio.h>",
    .}:int
  ionbf

#
# File access functions
#

proc fopen*(typ:type C.stdio, filename:cstring, mode:cstring):ptr[C.stdio.FILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc freopen*(typ:type C.stdio, filename:cstring, mode:cstring, stream:ptr[C.stdio.FILE]):ptr[C.stdio.FILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc fflush*(typ:type C.stdio, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}


proc fclose*(typ:type C.stdio, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc setbuf*(typ:type C.stdio, stream:ptr[C.stdio.FILE], buffer:ptr[char]) {.
  importc,
  header:"<stdio.h>"
  .}

proc setvbuf*(typ:type C.stdio, stream:ptr[C.stdio.FILE], buffer:ptr[char], mode:int, size:csize):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fwide*(typ:type C.stdio, stream:ptr[C.stdio.FILE], mode:int):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Direct input/output functions
#

proc fread*(typ:type C.stdio, buffer:pointer, size:csize, count:csize, stream:ptr[C.stdio.FILE]):csize {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fwrite*(typ:type C.stdio, buffer:pointer, size:csize, count:csize, stream:ptr[C.stdio.FILE]):csize {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Unformatted input/output functions
#

proc fgetc*(typ:type C.stdio, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc getc*(typ:type C.stdio, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fgets*[T](typ:type C.stdio, str:ptr[T], count:int, stream:ptr[C.stdio.FILE]):ptr[T] {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fputc*(typ:type C.stdio, ch:int, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc putc*(typ:type C.stdio, ch:int, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fputs*(typ:type C.stdio, str:cstring, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc getchar*(typ:type C.stdio):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc putchar*(typ:type C.stdio, ch:int):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc puts*(typ:type C.stdio, st:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc ungetc*(typ:type C.stdio, ch:int, stream:ptr[C.stdio.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Formatted input/output functions
#

proc scanf*(typ:type C.stdio, format:cstring):int {.
  importc,
  header:"<stdio.h>",
  varargs,
  discardable,
  .}

proc printf*(typ:type C.stdio, fmt:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}
