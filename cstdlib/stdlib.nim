import core
export core

#
# Type conversion functions
#

proc atof*(typ:type C, str:cstring):cdouble {.
  importc,
  header:"<stdlib.h>",
  .}

proc atoi*(typ:type C, std:cstring):int {.
  importc,
  header:"<stdlib.h>",
  .}

proc atol*(typ:type C, std:cstring):clong {.
  importc,
  header:"<stdlib.h>",
  .}

proc atoll*(typ:type C, std:cstring):clonglong {.
  importc,
  header:"<stdlib.h>",
  .}

proc strtod*(typ:type C, str:cstring, endptr:ptr[cstring]):cdouble {.
  importc,
  header:"<stdlib.h>",
  .}

proc strtof*(typ:type C, str:cstring, endptr:ptr[cstring]):cfloat {.
  importc,
  header:"<stdlib.h>",
  .}

proc strtol*(typ:type C, str:cstring, endptr:ptr[cstring], base:cint):clong {.
  importc,
  header:"<stdlib.h>",
  .}
