import core
export core

#
# Formatted input/output
#

proc printf*(typ:type C.stdio, fmt:cstring):int {.
  importc,
  header:"<stdio.h>",
  discardable,
  varargs,
  .}
