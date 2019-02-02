## Tests for `cstdlib`

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
]

type
  FILE = stdio.FILE(C.stdio)

proc main =
  var a = C.stdio.fopen("main.nim", "r")
  var b = C.stdio.freopen("main.nim", "r", a)
  C.stdio.fflush(b)
  C.stdio.setbuf(b, nil)
  C.stdio.setvbuf(b, nil, C.stdio.IOFBF, 0)
  C.stdio.setvbuf(b, nil, C.stdio.IOLBF, 0)
  C.stdio.setvbuf(b, nil, C.stdio.IONBF, 0)
  C.stdio.fwide(b, 0)
  C.stdio.fclose(b)

  var c:ptr[FILE]
  discard c

  var d = C.stdio.fopen("main.nim", "r")
  var e:array[3,int]
  C.stdio.fread(addr(e[0]), sizeof(int), len(e), d)
  C.stdio.fclose(d)

  var f = C.stdio.fopen("fwrite.tmp", "w+")
  var g:array[3,int] = [1,2,3]
  C.stdio.fwrite(addr(g[0]), sizeof(int), len(g), f)
  C.stdio.fclose(f)

  C.stdio.printf("Hello, World!\n")

main()
