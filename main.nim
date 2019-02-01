## Tests for `cstdlib`

# NOTE: Can import everything at once with `import cstdlib`.
import cstdlib/[
  stdio,
]

proc main =
  C.stdio.printf("Hello, World!")

main()
