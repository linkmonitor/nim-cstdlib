## Tests for `cstdlib`

import system

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
  wchar,
  quirk,
]

proc main =
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
    var c:ptr[C.FILE]
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

main()
