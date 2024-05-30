from get_similarity import saveNonVariantProgram
from get_similarity import getSimilarityCount
from get_similarity import getSimilarityCountfromFiles
risc_gcc = '/home/m588h354/projects/autophasew/openrisc/or1k-elf/bin/or1k-elf-gcc'
prologue_script = """
#!/bin/bash
set -e
opt_path="/usr/local/llvm-or1k/bin"
main_prog=main
FILE="test_c_code"
rm -rf *.ll
${opt_path}/clang $FILE -target or1k -emit-llvm -S -Xclang -disable-llvm-passes -O3
FILE_ll=$(ls -ltr *.ll | awk '{print $9}' | awk '{print}' ORS=' ')
${opt_path}/llvm-link $FILE_ll -o ${main_prog}_b4.ll
${opt_path}/opt -S opt_passes ${main_prog}_b4.ll -o ${main_prog}_a4.ll
${opt_path}/llvm-as ${main_prog}_a4.ll -o ${main_prog}.bc
${opt_path}/llc ${main_prog}.bc -o ${main_prog}.s
"""

prologue_script_t = """
#!/bin/bash
set -e
opt_path="/usr/local/llvm-or1k/bin"
main_prog=main
FILE="test_c_code"
rm -rf *.ll
${opt_path}/clang $FILE -target or1k -emit-llvm -S -Xclang -disable-llvm-passes -O3
FILE_ll=$(ls -ltr *.ll | awk '{print $9}' | awk '{print}' ORS=' ')
${opt_path}/llvm-link $FILE_ll -o ${main_prog}_b4.ll
"""

#pgm_name = ["basicmath.c", "cubic.c", "isqrt.c", "rad2deg.c"]
pgm_name = ["aes.c"]
e_passes = []
#passes = [[], [], []]
#passes = [[1,2,3], [2,3,4], [3,4,5]]
passes = [[48, 69, 45, 32, 48, 72, 54, 1, 25, 12, 54, 42, 1, 72, 44, 62, 18, 39, 61, 7, 17, 44, 45, 75, 20, 31, 27, 19, 73, 6, 26, 21, 70, 42, 30], [68, 76, 64, 54, 65, 53, 29, 37, 45, 3, 6, 65, 19, 38, 67, 13, 69, 6, 18, 0, 2, 16, 53, 51, 51, 22, 46, 29, 6, 1, 62, 9, 65, 68, 75], [19, 69, 34, 44, 60, 12, 30, 24, 23, 17, 61, 53, 38, 68, 25, 50, 3, 66, 66, 48, 38, 10, 11, 34, 56, 76, 45, 28, 69, 24, 38, 34, 13, 15, 2]]

top = "aes"
#run_dir = "/home/m588h354/projects/autophasew/variant/example/MiBench/test_automotive-basicmath"
run_dir = "/home/m588h354/projects/autophasew/variant/example/chstone/test_aes"
saveNonVariantProgram(pgm_name, top, prologue_script, e_passes, run_dir)
prev_sim_score, _ = getSimilarityCount(pgm_name, top, prologue_script_t, passes, run_dir)
print(prev_sim_score)

avg, _ = getSimilarityCountfromFiles(top, risc_gcc, run_dir)
print(avg)


