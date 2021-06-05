#!/bin/bash

git clone https://github.com/asmagill/hs._asm.undocumented.spaces hammerspoon/_asm/spaces
cd hammerspoon/_asm/spaces
HS_APPLICATION=~/Applications PREFIX=`cwd`/../../ make install