# Make it small
--opt:size
--gc:none
--os:standalone
--define:noSignalHandler
--define:release
--passC:"-fdata-sections"
--passC:"-ffunction-sections"
--passC:"-flto"
--passL:"-Wl,--gc-sections"
--passL:"-flto"

# Reduce spew
--define:verbosity:0

# Make temporary files local
--nimCache:nimcache
