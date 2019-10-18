import core
export core

#
# Types
#

type
  div_t_private {.importc:"div_t", header:"<stdlib.h>".} = object
    quot*:cint
    rem*:cint
  ldiv_t_private {.importc:"ldiv_t", header:"<stdlib.h>".} = object
    quot*:clong
    rem*:clong
  lldiv_t_private {.importc:"lldiv_t", header:"<stdlib.h>".} = object
    quot*:clonglong
    rem*:clonglong
  size_t_private {.importc:"size_t", header:"<stdlib.h>".} = object

template div_t*(typ:type C):typedesc =
  div_t_private

template ldiv_t*(typ:type C):typedesc =
  ldiv_t_private

template lldiv_t*(typ:type C):typedesc =
  lldiv_t_private

template size_t*(typ:type C):typedesc =
  size_t_private

#
# Variables and defines
#

template EXIT_FAILURE*(typ:type C):auto =
  var exit_failure {.
    global,
    importc:"EXIT_FAILURE",
    header:"<stdlib.h>",
    .}:cint
  exit_failure

template EXIT_SUCCESS*(typ:type C):auto =
  var exit_success {.
    global,
    importc:"EXIT_SUCCESS",
    header:"<stdlib.h>",
    .}:cint
  exit_success

template MB_CUR_MAX*(typ:type C):auto =
  var mb_cur_max {.
    global,
    importc:"MB_CUR_MAX",
    header:"<stdlib.h>",
    .}:cint
  mb_cur_max

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

#
# Environment functions
#

proc abort*(typ:type C) {.
  importc,
  header:"<stdlib.h>",
  .}

proc atexit*(typ:type C, fn:proc):cint {.
  importc,
  header:"<stdlib.h>",
  discardable,
  .}

# NOTE: Doesn't work on my Mac laptop.
# proc at_quit_exit*(typ:type C, fn:proc):cint {.
#   importc,
#   header:"<stdlib.h>",
#   discardable,
# .}

proc exit*(typ:type C, status:cint) {.
  importc,
  header:"<stdlib.h>",
  .}

proc getenv*(typ:type C, name:cstring):cstring {.
  importc,
  header:"<stdlib.h>",
  .}

proc quick_exit*(typ:type C, status:cint) {.
  importc,
  header:"<stdlib.h>",
  .}

proc system*(typ:type C, command:cstring):cint {.
  importc,
  header:"<stdlib.h>",
  .}

proc underscore_exit*(typ:type C, status:cint) {.
  importc:"_Exit",
  header:"<stdlib.h>",
  .}

#
# Searching and sorting
#

proc bsearch*[T](typ:type C, key:ptr[T], base:ptr[T], num:csize, size:csize, compar:proc):ptr[T] {.
  importc,
  header:"<stdlib.h>",
  .}

proc qsort*[T](typ:type C, base:ptr[T], num:csize, size:csize, compar:proc) {.
  importc,
  header:"<stdlib.h>",
  .}

#
# Integer arithmetics
#

proc abs*(typ:type C, n:cint):cint {.
  importc,
  header:"<stdlib.h>",
  .}

proc `div`*(typ:type C, numer:cint, denom:cint):C.div_t {.
  importc,
  header:"<stdlib.h>",
  .}

proc labs*(typ:type C, n:clong):clong {.
  importc,
  header:"<stdlib.h>",
  .}

proc ldiv*(typ:type C, numer:clong, denom:clong):C.ldiv_t {.
  importc,
  header:"<stdlib.h>",
  .}

proc llabs*(typ:type C, n:clonglong):clonglong {.
  importc,
  header:"<stdlib.h>",
  .}

proc lldiv*(typ:type C, numer:clonglong, denom:clonglong):C.lldiv_t {.
  importc,
  header:"<stdlib.h>",
  .}
