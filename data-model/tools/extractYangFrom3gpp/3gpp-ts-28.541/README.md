# 3gpp-ts-28.541

A node.js script to extract yang modules from 3GPP TS 28.541.

## Prerequisits

### node.js

https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu/

```
$ node --version
v10.16.3
```

### pyang

https://anukulverma.wordpress.com/2016/03/26/pyang-installation/

```
$ pyang --version
pyang 2.0.1
```


## Usage

Download latest version from [3GPP Specifications](https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=3400).

```
$ wget http://www.3gpp.org/ftp//Specs/archive/28_series/28.541/28541-g20.zip --output-document=./src/resources/28541-g20.zip
```

Extract the zip file.

```
$ unzip ./src/resources/*.zip -d ./src/resources/
```

The word document (*.doc) must be converted to a text fromat. Please use Office Libre or MS Word for manual converstion, and then use the node.js script to extract the yang modules from the text file. The last parameter is the relative path to the text file. 

```
$ node ./src/js/extractYang.js src/resources/v16.2.0.txt 
```

Verifiy the extracted yang modules with pyang.

```
$ pyang --strict --path ./import/ ./target/*.yang
```