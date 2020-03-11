# Template

This folder contains a template yang modules with dependencies to published
YANG modules and O-RAN-SC common yang modules.

Please rename "TEMPLATE" by your O-RAN component.

Please use the option "-L, --dereference" of the bash "cp" command to follow
the symbolic link if needed.

To validate our yang modules pyang is recommended, following the 
O-RAN Alliance data modelling guidlines.

```
pyang --lint o-ran-sc-*.yang
```