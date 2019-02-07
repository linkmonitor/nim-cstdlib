converter arrayDecay*[N,T](arr:array[N,T]):ptr[T] {.inline.} =
  ## Add pointer decay for arrays to mimic C.
  cast[ptr[T]](unsafeAddr(arr[0]))
