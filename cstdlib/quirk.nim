converter arrayDecay*[N,T](arr:array[N,T]):ptr[T] {.inline.} =
  ## Implement pointer decay to match the behavior in C.
  cast[ptr[T]](unsafeAddr(arr[0]))
