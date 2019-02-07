import core
export core

converter toInt*(n:char):int {.inline.} =
  result = cast[int](n)

#
# Types
#

type
  FILE_private {.importc:"FILE", header:"<stdio.h>".} = object

template FILE*(typ:type C):typedesc =
  FILE_private

#
# Variables and defines
#

template NULL*(typ:type C):auto =
  var null {.
    global,
    importc:"NULL",
    header:"<stdio.h>",
    .}:pointer
  null

template IOFBF*(typ:type C):auto =
  var iofbf {.
    global,
    importc:"_IOFBF",
    header:"<stdio.h>",
    .}:int
  iofbf

template IOLBF*(typ:type C):auto =
  var iolbf {.
    global,
    importc:"_IOLBF",
    header:"<stdio.h>",
    .}:int
  iolbf

template IONBF*(typ:type C):auto =
  var ionbf {.
    global,
    importc:"_IONBF",
    header:"<stdio.h>",
    .}:int
  ionbf

#
# File access functions
#

proc fopen*(typ:type C, filename:cstring, mode:cstring):ptr[C.FILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc freopen*(typ:type C, filename:cstring, mode:cstring, stream:ptr[C.FILE]):ptr[C.FILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc fflush*(typ:type C, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}


proc fclose*(typ:type C, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc setbuf*(typ:type C, stream:ptr[C.FILE], buffer:ptr[char]) {.
  importc,
  header:"<stdio.h>"
  .}

proc setvbuf*(typ:type C, stream:ptr[C.FILE], buffer:ptr[char], mode:int, size:csize):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fwide*(typ:type C, stream:ptr[C.FILE], mode:int):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Direct input/output functions
#

proc fread*[T](typ:type C, buffer:ptr[T], size:csize, count:csize, stream:ptr[C.FILE]):csize {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fwrite*[T](typ:type C, buffer:ptr[T], size:csize, count:csize, stream:ptr[C.FILE]):csize {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Unformatted input/output functions
#

proc fgetc*(typ:type C, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc getc*(typ:type C, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fgets*[T](typ:type C, str:ptr[T], count:int, stream:ptr[C.FILE]):ptr[T] {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fputc*(typ:type C, ch:int, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc putc*(typ:type C, ch:int, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fputs*(typ:type C, str:cstring, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc getchar*(typ:type C):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc putchar*(typ:type C, ch:int):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc puts*(typ:type C, st:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc ungetc*(typ:type C, ch:int, stream:ptr[C.FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Formatted input/output functions
#

proc scanf*(typ:type C, format:cstring):int {.
  importc,
  header:"<stdio.h>",
  varargs,
  discardable,
  .}

proc fscanf*(typ:type C, stream:ptr[C.FILE], format:cstring):int {.
  importc,
  header:"<stdio.h>",
  varargs,
  discardable,
  .}

proc sscanf*(typ:type C, buffer:pointer, format:cstring):int {.
  importc,
  header:"<stdio.h>",
  varargs,
  discardable,
  .}

# TODO: Implement
#
# - vscanf()
# - vfscanf()
# - vsscanf()

proc printf*(typ:type C, format:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}

proc fprintf*(typ:type C, stream:ptr[C.FILE], format:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}

proc sprintf*[T](typ:type C, buffer:ptr[T], format:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}

# TODO: Implement
#
# - vprintf()
# - vfprintf()
# - vsprintf()

proc perror*(typ:type C, s:cstring) {.
  importc,
  header:"<stdio.h>",
  varargs,
  .}
