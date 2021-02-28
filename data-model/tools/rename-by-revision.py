#!/usr/bin/env python
#
# Copyright 2016 Einar Nilsen-Nygaard [https://gist.github.com/einarnn]
# Update Copyright 2021 highstreet technologies GmbH
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# The script renames yang modules with filename with schema "<module-name>.yang"
# to filenames with schema name "<module-name>@<revision>.yang" as used by 
# netconf-server and netconf-client impelementstions to distingligh the
# yang modules already by its filename avoiding parsing the yang module getting
# its revision.
#
from pyang import repository, context
import argparse
import os

parser = argparse.ArgumentParser(description='rename a list of yang model files by the revision information')
parser.add_argument('yang_files', type=str, nargs='+',
                    help='list of yang files')
args = parser.parse_args()

repos = repository.FileRepository(".")
for fname in args.yang_files:
    targ_module = os.path.basename(fname).split(".")[0]
    if '@' in targ_module:
        targ_module = targ_module.split('@')[0]
    ctx = context.Context(repos)
    fd = open(fname, 'r')
    text = fd.read()
    ctx.add_module(fname, text)
    for ((m,r), v) in ctx.modules.items():
        if m==targ_module:
            targ_dir = os.path.dirname(fname)
            if len(targ_dir)==0:
                os.rename(fname,targ_module+'@'+r+'.yang')
            else:
                os.rename(fname,targ_dir+'/'+targ_module+'@'+r+'.yang')
            break