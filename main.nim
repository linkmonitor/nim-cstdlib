## Tests for `cstdlib`

import system

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
  wchar,
]

type
  FILE = stdio.FILE(C.stdio)
    ## TODO: Find a way to avoid this.

proc main =
  block:
    var a = C.stdio.fopen("main.nim", "r")
    var b = C.stdio.freopen("main.nim", "r", a)
    C.stdio.fflush(b)
    C.stdio.setbuf(b, nil)
    C.stdio.setvbuf(b, nil, C.stdio.IOFBF, 0)
    C.stdio.setvbuf(b, nil, C.stdio.IOLBF, 0)
    C.stdio.setvbuf(b, nil, C.stdio.IONBF, 0)
    C.stdio.fwide(b, 0)
    C.stdio.fclose(b)

  block:
    var c:ptr[FILE]
    discard c

  block:
    var a = C.stdio.fopen("main.nim", "r")
    var b:array[3,int]
    C.stdio.fread(addr(b[0]), sizeof(int), len(b), a)
    C.stdio.fclose(a)

  block:
    var a = C.stdio.fopen("fwrite.tmp", "w+")
    var b:array[3,int] = [1,2,3]
    C.stdio.fwrite(addr(b[0]), sizeof(int), len(b), a)
    C.stdio.fclose(a)

  block:
    var a = C.stdio.fopen("main.nim", "r")
    var b = C.stdio.fgetc(a)
    var c = C.stdio.getc(a)
    discard b
    discard c
    C.stdio.fclose(a)

  block:
    var a:C.wchar.wint_t
    discard a

  block:
    var a = C.stdio.fopen("main.nim", "r")
    var b = C.wchar.fgetwc(a)
    var c = C.wchar.getwc(a)
    discard b
    discard c
    C.stdio.fclose(a)

  block:
    var a = C.stdio.fopen("main.nim", "r")
    var b:array[4,char]
    C.stdio.fgets(b, len(b), a)
    var c:array[4,C.wchar.wint_t]
    C.wchar.fgetws(c, len(c), a)
    C.stdio.fclose(a)

  block:
    var a = C.stdio.fopen("fputc.tmp", "w+");
    C.stdio.fputc('a', a)
    C.stdio.putc('b', a)
    C.wchar.fputwc('c', a)
    C.wchar.putwc('d', a)
    C.stdio.fputs("dcba", a)
    var b:array[2,C.wchar.wchar_t]
    b[0] = 'a'
    b[1] = '\0'
    C.wchar.fputws(b, a)
    C.stdio.fclose(a)

  block:
    when defined(interactive):
      # NOTE: Use Ctrl-d to avoid putting a newline in `stdin`.
      C.stdio.printf("Enter a charcter:\n")
      var a = C.stdio.getchar()
      C.stdio.printf("You entered %c\n", a)
      C.stdio.printf("Enter a charcter:\n")
      var b = C.wchar.getwchar()
      C.stdio.printf("You entered %c\n", b)

  C.stdio.putchar('a')
  C.stdio.putchar('\n')
  C.wchar.putwchar('b')
  C.wchar.putwchar('\n')
  C.stdio.puts("ab")

  block:
    var a = C.stdio.fopen("ungetc.tmp", "w+")
    C.stdio.ungetc('a', a)
    var b = C.stdio.fgetc(a)
    C.stdio.printf("%c\n", b)
    C.wchar.ungetwc('b', a)
    var c = C.wchar.fgetwc(a)
    C.stdio.printf("%c\n", c)
    C.stdio.fclose(a)

  block:
    when defined(interactive):
      C.stdio.printf("Enter an integer:\n")
      var a:int
      C.stdio.scanf("%d", addr(a))
      C.stdio.printf("You entered: %d\n", a)

  block:
    var a = C.stdio.fopen("fscanf.tmp", "w+")
    C.stdio.fputs("123", a)
    C.stdio.fclose(a)
    a = C.stdio.fopen("fscanf.tmp", "r")
    var b:int
    C.stdio.fscanf(a, "%d", addr(b))
    C.stdio.printf("fscanf() read %d\n", b)
    C.stdio.fclose(a)

  block:
    var a:cstring = "321"
    var b:int
    C.stdio.sscanf(a, "%d", addr(b))
    C.stdio.printf("sscanf() read %d\n", b)

  block:
    when defined(interactive):
      C.stdio.printf("Enter an integer:\n")
      var a:int
      # NOTE: May need a few of these to get it to work.
      # C.stdio.getchar()
      # C.stdio.getchar()
      var format:array[3, C.wchar.wchar_t]
      format[0] = '%'
      format[1] = 'd'
      format[2] = '\0'
      C.wchar.wscanf(format, addr(a))
      C.stdio.printf("You entered: %d\n", a)

  block:
    var a = C.stdio.fopen("fwscanf.tmp", "w+")
    C.stdio.fputs("246", a)
    C.stdio.fclose(a)
    var b:int
    var format:array[3, C.wchar.wchar_t]
    format[0] = '%'
    format[1] = 'd'
    format[2] = '\0'
    a = C.stdio.fopen("fwscanf.tmp", "r")
    C.wchar.fwscanf(a, format, addr(b))
    C.stdio.printf("fwscanf() read %d\n", b)
    C.stdio.fclose(a)

  block:
    var a:array[4,C.wchar.wchar_t] = [
      toWchar('1'),'2','3','\0']
    var format:array[3, C.wchar.wchar_t]
    format[0] = '%'
    format[1] = 'd'
    format[2] = '\0'
    var c:int
    # TODO: Make `swscanf()` accept `wchar_t` buffers.
    C.wchar.swscanf(addr(a), format, addr(c))
    C.stdio.printf("swcanf() read %d\n", c)

  block:
    C.stdio.printf("Hello from printf()\n")
    var a:array[23,C.wchar.wchar_t] = [
      toWchar('H'), 'e', 'l', 'l', 'o', ',', ' ',
      'f', 'r', 'o', 'm', ' ',
      'w', 'p', 'r', 'i', 'n', 't', 'f', '(', ')', '\n', '\0' ]
    C.wchar.wprintf(a)

  block:
    var a = C.stdio.fopen("fwprintf.tmp", "w")
    var format:array[3, C.wchar.wchar_t] = [toWchar('%'), 'd', '\0']
    C.wchar.fwprintf(a, format, 1)
    C.stdio.fclose(a)

  block:
    var a:array[5, C.wchar.wchar_t]
    var format:array[3, C.wchar.wchar_t] = [toWchar('%'), 'd', '\0']
    C.wchar.swprintf(addr(a), len(a), format, 135)
    a[3] = '\n'
    a[4] = '\0'
    C.wchar.wprintf(a)

  block:
    var a = C.stdio.fopen("fprintf.tmp", "w")
    C.stdio.fprintf(a, "%d\n", 789)
    C.stdio.fclose(a)

  block:
    var a:array[100, char]
    C.stdio.sprintf(addr(a), "%d", 987)
    C.stdio.printf("%c%c%c\n", a[0], a[1], a[2])

  block:
    C.stdio.perror("Hello from perror()")

main()
