## Tests for `cstdlib`

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
  wchar,
]

type
  FILE = stdio.FILE(C.stdio)
    ## TODO: Find a way to avoid this.

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

  var h = C.stdio.fopen("main.nim", "r")
  var i = C.stdio.fgetc(h)
  var j = C.stdio.getc(h)
  discard i
  discard j
  C.stdio.fclose(h)

  var k:C.wchar.wint_t
  discard k

  var l = C.stdio.fopen("main.nim", "r")
  var m = C.wchar.fgetwc(l)
  var n = C.wchar.getwc(l)
  discard m
  discard n
  C.stdio.fclose(l)

  var o = C.stdio.fopen("main.nim", "r")
  var p:array[4,char]
  C.stdio.fgets(p, len(p), o)
  var q:array[4,C.wchar.wint_t]
  C.wchar.fgetws(q, len(q), o)
  C.stdio.fclose(o)

  var s = C.stdio.fopen("fputc.tmp", "w+");
  C.stdio.fputc('a', s)
  C.stdio.putc('b', s)
  C.wchar.fputwc('c', s)
  C.wchar.putwc('d', s)
  C.stdio.fputs("dcba", s)
  var t:array[2,C.wchar.wchar_t]
  t[0] = 'a'
  t[1] = '\0'
  C.wchar.fputws(t, s)
  C.stdio.fclose(s)

  when defined(interactive):
    # NOTE: Use Ctrl-d to avoid putting a newline in `stdin`.
    C.stdio.printf("Enter a charcter:\n")
    var u = C.stdio.getchar()
    C.stdio.printf("You entered %c\n", u)
    C.stdio.printf("Enter a charcter:\n")
    var v = C.wchar.getwchar()
    C.stdio.printf("You entered %c\n", v)

  C.stdio.putchar('a')
  C.stdio.putchar('\n')
  C.wchar.putwchar('b')
  C.wchar.putwchar('\n')
  C.stdio.puts("ab")

  var w = C.stdio.fopen("ungetc.tmp", "w+")
  C.stdio.ungetc('a', w)
  var x = C.stdio.fgetc(w)
  C.stdio.printf("%c\n", x)
  C.wchar.ungetwc('b', w)
  var y = C.wchar.fgetwc(w)
  C.stdio.printf("%c\n", y)
  C.stdio.fclose(w)

  when defined(interactive):
    C.stdio.printf("Enter an integer:\n")
    var z:int
    C.stdio.scanf("%d", addr(z))
    C.stdio.printf("You entered: %d\n", z)

  C.stdio.printf("Hello, World!\n")

main()
