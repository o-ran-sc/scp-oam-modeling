# Data models under discussion and development

A directory to share ideas for data model development and to experiment with 
the new model artifacts. 

Please use pyang to validate the proposed yang modules and to generate 
the yang tree.

```
pyang -f tree -o all-in-one.tree *.yang
```

Note: The yang module "o-ran-sc-TEMPLATE-v1.yang" should be used as templated 
for project specific configuration management.