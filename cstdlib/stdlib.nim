import core
export core

#
# Variables and defines
#

template RAND_MAX*(typ:type C):auto =
  var rand_max {.
    global,
    importc:"RAND_MAX",
    header:"<stdlib.h>",
    .}:cint
  rand_max

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

proc strtold*(typ:type C, std:cstring, endptr:ptr[cstring]):clongdouble {.
  importc,
  header:"<stdlib.h>",
  .}

proc strtoll*(typ:type C, std:cstring, endptr:ptr[cstring], base:cint):clonglong {.
  importc,
  header:"<stdlib.h>",
  .}

proc strtoul*(typ:type C, std:cstring, endptr:ptr[cstring], base:cint):culong {.
  importc,
  header:"<stdlib.h>",
  .}

proc strtoull*(typ:type C, std:cstring, endptr:ptr[cstring], base:cint):culonglong {.
  importc,
  header:"<stdlib.h>",
  .}

#
# Random functions
#

proc rand*(typ:type C):cint {.
  importc,
  header:"<stdlib.h>",
  .}

proc srand*(typ:type C, seed:cuint) {.
  importc,
  header:"<stdlib.h>",
  .}

#
# Dynamic memory management
#

proc calloc*(typ:type C, num:csize, size:csize):ptr[cchar] {.
  importc,
  header:"<stdlib.h>",
  .}

proc free*[T](typ:type C, p:ptr[T]) {.
  importc,
  header:"<stdlib.h>",
  .}

proc malloc*(typ:type C, size:csize):ptr[cchar] {.
  importc,
  header:"<stdlib.h>",
  .}

proc realloc*[T](typ:type C, p:ptr[T], size:csize):ptr[T] {.
  importc,
  header:"<stdlib.h>",
  .}
