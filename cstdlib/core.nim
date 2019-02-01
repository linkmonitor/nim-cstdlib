## All modules must import and export this module.
##
## TODO: Explain why.

type
  # `stdio` types.
  FILE {.importc, header:"<stdio.h>".} = object

  Stdio = object
    ## TODO: Explain why Stdio isn't public.
    FILE*:FILE

type
  C* = object
    ## The root type used to access all C variables/functions/defines.
    ##
    ## TODO: Provide examples to show why this type exists.
    stdio*:Stdio
