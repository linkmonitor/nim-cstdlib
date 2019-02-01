type
  ## The root type used to access all C variables/functions/defines.
  ##
  ## TODO(jj): Provide examples to show why this type exists.
  C* = object
    stdio:Stdio

  ## TODO(jj): Explain why Stdio isn't public.
  Stdio = object
