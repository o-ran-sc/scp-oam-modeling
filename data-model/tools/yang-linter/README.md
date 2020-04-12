# YANG linter

As much as possible automatic yang linter

## Usage

```
./src/main/bash/yang-linter [options] <directory>
```

### Example

```
./src/main/bash/yang-linter --3gpp
```

## Options

```
  -3, --3gpp            Clone and lint 3GPP SA5 yang modules and exit
  -h, --help            Show this help message and exit

  -i=IMPORTDIR, --imports=IMPORTDiR
                        Defines an import directory for standard yang modules

  -s, --status          Show app status information and exit

  -t=TARGETDIR, --target=TARGETDIR
                        Defines the target output directory

  -v, --version         Show version number and exit

  <directory>           The folder containng yang modules
```

## Open Items

Ideas for additional pyang plugins:

- pyang --format yang --yang-contact
- pyang --format yang --yang-organization
- pyang --format yang --yang-reference
- pyang --format yang --yang-revision-order
- pyang --format yang --yang-revision-default
- pyang --format yang --yang-description
