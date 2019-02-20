## Tests for `cstdlib`

import system

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
  stdlib,
  wchar,
  quirk,
]

proc main =

  #
  # sdtio and wchar
  #

  block:
    var a = C.fopen("main.nim", "r")
    var b = C.freopen("main.nim", "r", a)
    C.fflush(b)
    C.setbuf(b, nil)
    C.setvbuf(b, nil, C.IOFBF, 0)
    C.setvbuf(b, nil, C.IOLBF, 0)
    C.setvbuf(b, nil, C.IONBF, 0)
    C.fwide(b, 0)
    C.fclose(b)

  block:
    var c:ptr[C.CFILE]
    discard c

  block:
    var a = C.fopen("main.nim", "r")
    var b:array[3,int]
    C.fread(b, sizeof(int), len(b), a)
    C.fclose(a)

  block:
    var a = C.fopen("fwrite.tmp", "w+")
    var b:array[3,int] = [1,2,3]
    C.fwrite(b, sizeof(int), len(b), a)
    C.fclose(a)

  block:
    var a = C.fopen("main.nim", "r")
    var b = C.fgetc(a)
    var c = C.getc(a)
    discard b
    discard c
    C.fclose(a)

  block:
    var a:C.wint_t
    discard a

  block:
    var a = C.fopen("main.nim", "r")
    var b = C.fgetwc(a)
    var c = C.getwc(a)
    discard b
    discard c
    C.fclose(a)

  block:
    var a = C.fopen("main.nim", "r")
    var b:array[4,char]
    C.fgets(b, len(b), a)
    var c:array[4,C.wint_t]
    C.fgetws(c, len(c), a)
    C.fclose(a)

  block:
    var a = C.fopen("fputc.tmp", "w+");
    C.fputc('a', a)
    C.putc('b', a)
    C.fputwc('c', a)
    C.putwc('d', a)
    C.fputs("dcba", a)
    var b:array[2,C.wchar_t]
    b[0] = 'a'
    b[1] = '\0'
    C.fputws(b, a)
    C.fclose(a)

  block:
    when defined(interactive):
      # NOTE: Use Ctrl-d to avoid putting a newline in `stdin`.
      C.printf("Enter a charcter:\n")
      var a = C.getchar()
      C.printf("You entered %c\n", a)
      C.printf("Enter a charcter:\n")
      var b = C.getwchar()
      C.printf("You entered %c\n", b)

  C.putchar('a')
  C.putchar('\n')
  C.putwchar('b')
  C.putwchar('\n')
  C.puts("ab")

  block:
    var a = C.fopen("ungetc.tmp", "w+")
    C.ungetc('a', a)
    var b = C.fgetc(a)
    C.printf("%c\n", b)
    C.ungetwc('b', a)
    var c = C.fgetwc(a)
    C.printf("%c\n", c)
    C.fclose(a)

  block:
    when defined(interactive):
      C.printf("Enter an integer:\n")
      var a:int
      C.scanf("%d", addr(a))
      C.printf("You entered: %d\n", a)

  block:
    var a = C.fopen("fscanf.tmp", "w+")
    C.fputs("123", a)
    C.fclose(a)
    a = C.fopen("fscanf.tmp", "r")
    var b:int
    C.fscanf(a, "%d", addr(b))
    C.printf("fscanf() read %d\n", b)
    C.fclose(a)

  block:
    var a:cstring = "321"
    var b:int
    C.sscanf(a, "%d", addr(b))
    C.printf("sscanf() read %d\n", b)

  block:
    when defined(interactive):
      C.printf("Enter an integer:\n")
      var a:int
      # NOTE: May need a few of these to get it to work.
      # C.getchar()
      # C.getchar()
      var format:array[3, C.wchar_t]
      format[0] = '%'
      format[1] = 'd'
      format[2] = '\0'
      C.wscanf(format, a)
      C.printf("You entered: %d\n", a)

  block:
    var a = C.fopen("fwscanf.tmp", "w+")
    C.fputs("246", a)
    C.fclose(a)
    var b:int
    var format:array[3, C.wchar_t]
    format[0] = '%'
    format[1] = 'd'
    format[2] = '\0'
    a = C.fopen("fwscanf.tmp", "r")
    C.fwscanf(a, format, addr(b))
    C.printf("fwscanf() read %d\n", b)
    C.fclose(a)

  block:
    var a:array[4,C.wchar_t] = [
      toWchar('1'),'2','3','\0']
    var format:array[3, C.wchar_t]
    format[0] = '%'
    format[1] = 'd'
    format[2] = '\0'
    var c:int
    # TODO: Make `swscanf()` accept `wchar_t` buffers.
    C.swscanf(a, format, addr(c))
    C.printf("swcanf() read %d\n", c)

  block:
    C.printf("Hello from printf()\n")
    var a:array[23,C.wchar_t] = [
      toWchar('H'), 'e', 'l', 'l', 'o', ',', ' ',
      'f', 'r', 'o', 'm', ' ',
      'w', 'p', 'r', 'i', 'n', 't', 'f', '(', ')', '\n', '\0' ]
    C.wprintf(a)

  block:
    var a = C.fopen("fwprintf.tmp", "w")
    var format:array[3, C.wchar_t] = [toWchar('%'), 'd', '\0']
    C.fwprintf(a, format, 1)
    C.fclose(a)

  block:
    var a:array[5, C.wchar_t]
    var format:array[3, C.wchar_t] = [toWchar('%'), 'd', '\0']
    C.swprintf(a, len(a), format, 135)
    a[3] = '\n'
    a[4] = '\0'
    C.wprintf(a)

  block:
    var a = C.fopen("fprintf.tmp", "w")
    C.fprintf(a, "%d\n", 789)
    C.fclose(a)

  block:
    var a:array[100, char]
    C.sprintf(a, "%d", 987)
    C.printf("%c%c%c\n", a[0], a[1], a[2])

  block:
    C.perror("Hello from perror()")

  block:
    var a = C.fopen("main.nim", "rb")
    var b = C.ftell(a)
    C.printf("ftell() returned %ld\n", b)
    C.fclose(a)

  block:
    var a = C.fopen("main.nim", "r")
    C.fseek(a, 0, C.SEEK_SET)
    C.fseek(a, 0, C.SEEK_CUR)
    C.fseek(a, 0, C.SEEK_END)
    C.fclose(a)

  block:
    var a = C.fopen("main.nim", "r")
    var b:C.fpos_t
    C.fgetpos(a, addr(b))
    C.fsetpos(a, addr(b))
    C.rewind(a)
    C.fclose(a)

  block:
    var a = C.fopen("remove.tmp.tmp", "w+")
    C.fclose(a)
    C.rename("remove.tmp.tmp", "remove.tmp")
    C.remove("remove.tmp")

  block:
    var a = C.fopen("main.nim", "r")
    C.clearerr(a)
    discard C.feof(a)
    discard C.ferror(a)
    C.fclose(a)

  block:
    var a = C.tmpfile()
    C.fclose(a)
    var b:array[C.L_tmpnam,char]
    C.tmpnam(addr(b))
    C.printf("tmpname() returned %s\n", b)

  block:
    discard C.EOF
    discard C.BUFSIZ
    discard C.FILENAME_MAX
    discard C.FOPEN_MAX
    discard C.TMP_MAX

  #
  # stdlib
  #

  block:
    var a = C.atof("1.23")
    C.printf("atof() returned %f\n", a)
    var b = C.atoi("1")
    C.printf("atoi() returned %d\n", b)
    var c = C.atol("2")
    C.printf("atol() returned %ld\n", c)
    var d = C.atoll("3")
    C.printf("atoll() returned %lld\n", d)
    var e:cstring
    var f = C.strtod("3.21", addr(e))
    C.printf("strtod() returned %f\n", f, e)
    var g = C.strtof("1.11", addr(e))
    C.printf("strtof() returned %f\n", g)
    var h = C.strtol("123", addr(e), 10)
    C.printf("strtol() returned %ld\n", h)
    var i = C.strtold("1.234", addr(e))
    C.printf("strtold() returned %lf\n", i)
    var j = C.strtoll("1234", addr(e), 10)
    C.printf("strtoll() returned %lld\n", j)
    var k = C.strtoul("1234", addr(e), 10)
    C.printf("strtoul() returned %lld\n", k)
    var l = C.strtoull("1234", addr(e), 10)
    C.printf("strtoull() returned %lld\n", l)

  block:
    C.printf("RAND_MAX=%d\n", C.RAND_MAX)
    C.srand(0)
    C.printf("rand() returns %d\n", C.rand())
    C.srand(high(cuint))
    C.printf("rand() returns %d\n", C.rand())

  block:
    var a = C.calloc(sizeof(cint), 1)
    C.free(a)
    var b = C.malloc(1)
    var c = C.realloc(b, 2)
    C.free(c)

  block:
    var a:C.div_t
    discard a
    var b:C.ldiv_t
    discard b
    var c:C.lldiv_t
    discard c
    var d:C.size_t
    discard d
    discard C.EXIT_FAILURE
    discard C.EXIT_SUCCESS
    discard C.MB_CUR_MAX
    discard C.RAND_MAX

  block:
    when defined(abort):
      C.abort()

  block:
    proc greet_exit() =
      C.printf("That's all folks\n")
    C.atexit(greet_exit)
    C.printf("Should expect a closing line\n")

  # TODO(jjaoudi):
  # - [ ] Add the `incompleteStruct` pragma to type declarations.

main()
