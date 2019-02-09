import parseutils

template staticExecNoCache(cmd:string):string =
  ##
  ## Like staticExec() but runs every time the program is compiled.
  ##
  ## This is based on abusing the `cache` input of `staticExec()` with a value
  ## that always changes.
  ##
  ## NOTE: Some cache is collecting all previous values, but I'm confident my 
  ## harddrive will prevail.
  ##
  staticExec(cmd, cache=CompileTime)

template readCInt*(cvar):int =
  ##
  ## There is no straightforward way to importc a constant value like BUFSIZ
  ## from <stdio.h> into a Nim `const`.
  ##
  ## This function does it the long way. Namely:
  ## 1. Make a C program that prints the value of a variable.
  ## 2. Compile and run that program.
  ## 3. Parse the output string as an integer.
  ## 4. Convert the results from a compileTime context to a `const` one.
  ##
  var num_ct {.compileTime.}:int
  static:
    const program = """
    #include <stdio.h>
    int main(void) {
      printf("%d", """ & cvar & """);
      return 0;
    }
    """
    var escapedProgram {.compileTime.} = ""
    for ch in program:
      addEscapedChar(escapedProgram, ch)
    const cfile = cvar & ".c"
    discard staticExecNoCache("echo \"" & escapedProgram & "\" > " & cfile)
    var num_str = staticExecNoCache("gcc " & cfile & " && ./a.out")
    discard parseInt(num_str, num_ct)
  const num = num_ct
  num

when isMainModule:
  const BUFSIZ = readCInt("BUFSIZ")
  const FOPEN_MAX = readCInt("FOPEN_MAX")
  echo BUFSIZ
  echo FOPEN_MAX
