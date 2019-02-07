converter arrayDecay*[N,T](arr:array[N,T]):ptr[T] {.inline.} =
  ## Implement pointer decay to match the behavior in C.
  cast[ptr[T]](unsafeAddr(arr[0]))

converter toInt*(x:int):cint {.inline.} =
  ## Bridge Nim's `int` type to `cint`.
  cint(x)
