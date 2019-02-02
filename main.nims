# Make it small
--opt:size
--gc:none
--os:standalone
--define:noSignalHandler
--define:release
--passC:"-fdata-sections"
--passC:"-ffunction-sections"
--passC:"-flto"
--passL:"-flto"
when defined(clang):
  --passL:"-dead-strip"
else:
  --passL:"-Wl,--gc-sections"

# Reduce spew
--define:verbosity:0

# Make temporary files local
--nimCache:nimcache
