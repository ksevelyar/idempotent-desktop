#!/bin/sh
${dpkg}/bin/dpkg -x $src unpacked

cp -r unpacked/* $out/
