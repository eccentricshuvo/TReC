#!/bin/bash
set -e
source info.sh
opt_path="/usr/local/llvm-or1k/bin"
parallel --tty --jobs=1 ${opt_path}/clang -target or1k \
	-emit-llvm -S -Xclang -disable-llvm-passes {} ::: "${source_files[@]}"
lnk_name="${bench_name}.ll"
${opt_path}/llvm-link *.ll -o $lnk_name


