import core
export core

proc printf*(typ:type C.stdio, fmt:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}
