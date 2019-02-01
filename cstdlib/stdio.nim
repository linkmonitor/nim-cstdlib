import core
export core

#
# Local type aliases.
#

type
  FILE = typeof C.stdio.FILE

#
# File access functions
#

proc fopen*(typ:type C.stdio, filename:cstring, mode:cstring):ptr[FILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc freopen*(typ:type C.stdio, filename:cstring, mode:cstring, stream:ptr[FILE]):ptr[FILE] {.
  importc,
  header:"<stdio.h>",
  .}

proc fflush*(typ:type C.stdio, stream:ptr[FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}


proc fclose*(typ:type C.stdio, stream:ptr[FILE]):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  .}

proc setbuf*(typ:type C.stdio, stream:ptr[FILE], buffer:ptr[char]) {.
  importc,
  header:"<stdio.h>"
  .}

#
# Formatted input/output functions
#

proc printf*(typ:type C.stdio, fmt:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}
