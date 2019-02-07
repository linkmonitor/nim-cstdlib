import core
export core

converter toInt*(n:char):cint {.inline.} =
  result = cast[cint](n)

#
# Types
#

type
  FILE_private {.importc:"FILE", header:"<stdio.h>".} = object
  fpos_t_private {.importc:"fpos_t", header:"<stdio.h>".} = object

template CFILE*(typ:type C):typedesc =
  ## C's `FILE` type. Unable to use `FILE` because it conflicts with
  ## `system.FILE`.
  FILE_private

template fpos_t*(typ:type C):typedesc =
  fpos_t_private

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
    .}:cint
  iofbf

template IOLBF*(typ:type C):auto =
  var iolbf {.
    global,
    importc:"_IOLBF",
    header:"<stdio.h>",
    .}:cint
  iolbf

template IONBF*(typ:type C):auto =
  var ionbf {.
    global,
    importc:"_IONBF",
    header:"<stdio.h>",
    .}:cint
  ionbf

template SEEK_SET*(typ:type C):auto =
  var seek_set {.
    global,
    importc:"SEEK_SET",
    header:"<stdio.h>",
    .}:cint
  seek_set

template SEEK_CUR*(typ:type C):auto =
  var seek_cur {.
    global,
    importc:"SEEK_CUR",
    header:"<stdio.h>",
    .}:cint
  seek_cur

template SEEK_END*(typ:type C):auto =
  var seek_end {.
    global,
    importc:"SEEK_END",
    header:"<stdio.h>",
    .}:cint
  seek_end

#
# File access functions
#

proc fopen*(typ:type C, filename:cstring, mode:cstring):ptr[C.CFILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc freopen*(typ:type C, filename:cstring, mode:cstring, stream:ptr[C.CFILE]):ptr[C.CFILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc fflush*(typ:type C, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}


proc fclose*(typ:type C, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc setbuf*(typ:type C, stream:ptr[C.CFILE], buffer:ptr[char]) {.
  importc,
  header:"<stdio.h>"
  .}

proc setvbuf*(typ:type C, stream:ptr[C.CFILE], buffer:ptr[char], mode:cint, size:csize):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fwide*(typ:type C, stream:ptr[C.CFILE], mode:cint):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Direct input/output functions
#

proc fread*[T](typ:type C, buffer:ptr[T], size:csize, count:csize, stream:ptr[C.CFILE]):csize {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fwrite*[T](typ:type C, buffer:ptr[T], size:csize, count:csize, stream:ptr[C.CFILE]):csize {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Unformatted input/output functions
#

proc fgetc*(typ:type C, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc getc*(typ:type C, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fgets*[T](typ:type C, str:ptr[T], count:cint, stream:ptr[C.CFILE]):ptr[T] {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fputc*(typ:type C, ch:cint, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc putc*(typ:type C, ch:cint, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fputs*(typ:type C, str:cstring, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc getchar*(typ:type C):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc putchar*(typ:type C, ch:cint):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc puts*(typ:type C, st:cstring):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc ungetc*(typ:type C, ch:cint, stream:ptr[C.CFILE]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

#
# Formatted input/output functions
#

proc scanf*(typ:type C, format:cstring):cint {.
  importc,
  header:"<stdio.h>",
  varargs,
  discardable,
  .}

proc fscanf*(typ:type C, stream:ptr[C.CFILE], format:cstring):cint {.
  importc,
  header:"<stdio.h>",
  varargs,
  discardable,
  .}

proc sscanf*(typ:type C, buffer:pointer, format:cstring):cint {.
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

proc printf*(typ:type C, format:cstring):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}

proc fprintf*(typ:type C, stream:ptr[C.CFILE], format:cstring):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}

proc sprintf*[T](typ:type C, buffer:ptr[T], format:cstring):cint {.
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

#
# File positioning functions
#

proc ftell*(typ:type C, stream:ptr[C.CFILE]):clong {.
  importc,
  header:"<stdio.h>",
  .}

proc fseek*(typ:type C, stream:ptr[C.CFILE], offset:clong, origin:cint):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fgetpos*(typ:type C, stream:ptr[C.CFILE], pos:ptr[C.fpos_t]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc fsetpos*(typ:type C, stream:ptr[C.CFILE], pos:ptr[C.fpos_t]):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc rewind*(typ:type C, stream:ptr[C.CFILE]) {.
  importc,
  header:"<stdio.h>",
  .}

#
# Error handling functions
#

proc clearerr*(typ:type C, stream:ptr[C.CFILE]) {.
  importc,
  header:"<stdio.h>",
  .}

#
# Functions that perform opeations on files
#

proc remove*(typ:type C, fname:cstring):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc rename*(typ:type C, old_filename:cstring, new_filename:cstring):cint {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc tmpfile*(typ:type C):ptr[C.CFILE] {.
  importc,
  header:"<stdio.h>",
  .}

# TODO: Add tmpnam()
