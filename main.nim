## Tests for `cstdlib`

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
]

proc main =
  var a = C.stdio.fopen("main.nim", "r")
  var b = C.stdio.freopen("main.nim", "r", a)
  C.stdio.fflush(b)
  C.stdio.setbuf(b, nil)
  C.stdio.fclose(b)
  C.stdio.printf("Hello, World!")

main()
