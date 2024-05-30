from get_similarity import saveNonVariantProgram
from get_similarity import getSimilarityCount
from get_similarity import getSimilarityCountfromFiles
risc_gcc = '<your_mor1kx_path>/openrisc/or1k-elf/bin/or1k-elf-gcc'
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
e_passes = [] # for regular variant
#passes = [[], [], []]
#passes = [[1,2,3], [2,3,4], [3,4,5]]
# most 3 diverse variants for aes
passes = [[48, 69, 45, 32, 48, 72, 54, 1, 25, 12, 54, 42, 1, 72, 44, 62, 18, 39, 61, 7, 17, 44, 45, 75, 20, 31, 27, 19, 73, 6, 26, 21, 70, 42, 30], [68, 76, 64, 54, 65, 53, 29, 37, 45, 3, 6, 65, 19, 38, 67, 13, 69, 6, 18, 0, 2, 16, 53, 51, 51, 22, 46, 29, 6, 1, 62, 9, 65, 68, 75], [19, 69, 34, 44, 60, 12, 30, 24, 23, 17, 61, 53, 38, 68, 25, 50, 3, 66, 66, 48, 38, 10, 11, 34, 56, 76, 45, 28, 69, 24, 38, 34, 13, 15, 2]]
# most 3 diverse variants for automativ-basicmath
#passes = [[46, 37, 36, 74, 19, 71, 11, 35, 29, 69, 10, 54, 65, 59, 23, 48, 45, 61, 15, 60, 74, 16, 46, 64, 10, 40, 17, 34, 17, 30, 1, 13, 59, 39, 30, 75, 39], [47, 71, 33, 16, 8, 60, 0, 24, 53, 1, 37, 66, 28, 27, 21, 44, 38, 27, 24, 0, 31, 47, 19, 61, 71, 50, 24, 8, 66, 37, 75, 0, 72, 11, 71, 63, 28], [14, 8, 7, 25, 46, 16, 7, 34, 41, 16, 29, 66, 3, 27, 7, 31, 52, 63, 29, 27, 22, 71, 10, 18, 15, 24, 2, 40, 52, 64, 61, 18, 67, 21, 10, 0, 62]]


#top = "basicmath"
top = "aes"
#run_dir = "./automotive-basicmath"
run_dir = "/home/m588h354/projects/autophasew/variant/variant_gen/TReC/TReC/aes" # always use absolute/full path
# create "main" variant without any passes
saveNonVariantProgram(pgm_name, top, prologue_script, e_passes, run_dir)
# # Calculate similarity scores among variants i.e, for 3-variant system there will be 3C2 combination
sim_score, _ = getSimilarityCount(pgm_name, top, prologue_script_t, passes, run_dir)
print(sim_score)
# # Once you generate all the assembly files you can  skip running  saveNonVariantProgram and getSimilarityCount function. Just simply run getSimilarityCountfromFiles which will go through all the assembly files in the directory and calculate the score.
sim_score, _ = getSimilarityCountfromFiles(top, risc_gcc, run_dir) # compiling the program making executable
print(sim_score)

