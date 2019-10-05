////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2019 highstreet technologies GmbH and others...
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

const fs = require('fs');
const args = process.argv.slice(2);
const inputFile = __dirname + '/../../' + args[0];
const target = __dirname + '/../../target';

const deleteFolderRecursive = function(path) {
  if (fs.existsSync(path)) {
    fs.readdirSync(path).forEach(function(file, index){
      var curPath = path + "/" + file;
      if (fs.lstatSync(curPath).isDirectory()) { // recurse
        deleteFolderRecursive(curPath);
      } else { // delete file
        fs.unlinkSync(curPath);
      }
    });
    fs.rmdirSync(path);
  }
};

if (!fs.existsSync(inputFile)) {
  throw new Error(['Input file:', inputFile, 'not found!'].join(' '));
}

if (fs.existsSync(target)) {
  // clean
  deleteFolderRecursive(target);
}


// start
fs.mkdirSync(target, { recursive: true });
fs.readFile(inputFile, "utf8", function (err, data) {
  if (err) {
    return console.log(err);
  }

  var collect = false;
  var file = [];
  var filename = target + '/';

  var modules = data.split(/\r?\n/).forEach(function (line) {

    if (line.startsWith("submodule ") || line.startsWith("module ")) {
      collect = true;
      filename = target + "/" + line.split(' ')[1] + '.yang';
      file = [];
    }
    if (collect === true) {
      file.push(line);
    }
    if (line.startsWith("}")) {
      collect = false;
      fs.writeFile(filename, file.join("\n"), function (err) {
        if (err) {
          return console.log(err);
        }
        console.log(["The file", filename, "was saved!"].join(' '));
      });
    }
  });
});
