import re
import subprocess
import os
import itertools
import numpy as np
import os
import shutil
import random
from itertools import product
import time
# Available LLVM optimizatons
# Passes used in TReC
#opt_passes_str = "-correlated-propagation -scalarrepl -lowerinvoke -strip -strip-nondebug -sccp -globalopt -gvn -jump-threading -globaldce -loop-unswitch -scalarrepl-ssa -loop-reduce -break-crit-edges -loop-deletion -reassociate -lcssa -codegenprepare -memcpyopt -functionattrs -loop-idiom -lowerswitch -constmerge -loop-rotate -partial-inliner -inline -early-cse -indvars -adce -loop-simplify -instcombine -simplifycfg -dse -loop-unroll -lower-expect -tailcallelim -licm -sink -mem2reg -prune-eh -functionattrs -ipsccp -deadargelim -sroa -loweratomic -terminate"
# Passes used in RL-TReC
opt_passes_str = "-adce -alignment-from-assumptions -alloca-hoisting -always-inline -argpromotion -basicaa -basiccg -bdce -block-freq -branch-prob -break-crit-edges -cfl-aa -codegenprepare -consthoist -constmerge -constprop -correlated-propagation -cross-dso-cfi -dce -deadargelim -delinearize -demanded-bits -die -divergence -domfrontier -domtree -dse -dwarfehprepare -early-cse -elim-avail-extern -external-aa -flattencfg -float2int -forceattrs -functionattrs -globaldce -globalopt -globals-aa -gvn -indvars -inferattrs -inline -instcombine -instsimplify -internalize -ipconstprop -ipsccp -irce -iv-users -scalarrepl -lowerinvoke -strip -strip-nondebug -sccp -jump-threading -loop-unswitch -scalarrepl-ssa -loop-reduce -loop-deletion -reassociate -lcssa -memcpyopt -loop-idiom -lowerswitch -loop-rotate -partial-inliner -loop-simplify -simplifycfg -loop-unroll -lower-expect -tailcallelim -licm -sink -mem2reg -prune-eh -sroa -loweratomic"



def qw(s):
    """
    Examples :
    >>> print(qw(" -correlated-propagation -scalarrepl -lowerinvoke"))
    ('-correlated-propagation', '-scalarrepl', '-lowerinvoke')

    Args:
    s (str):  s is a list of all the possible passes that can be used
    (the passes shoul dvbe separated by whitespace).

    Returns:
    Returns a tuple of strings where each element is a pass(used for
    optimization) from s.
    """
    if type(s) is list:
        return tuple(s)
    else:
        return tuple(s.split())


def countPasses():
    """
    Examples :
    >>> print(countPasses())
    46

    Returns:
    Returns the number of passes that opt_passes_str contains
    (opt_passes_str is declared and assigned at the beginning
    of this class and contains 47 passes).
    """

    count = len(qw(opt_passes_str))
    return count


opt_passes = qw(opt_passes_str)


# print(opt_passes)
# Get a tuple of optimizations
def getPasses(opt_indice):
    """
    Examples :
    >>> print(getPasses([0,1]))
    ('-correlated-propagation', '-scalarrepl')

    Args:
    Opt_indice (list, optional): opt_indice is a list of integers where
    each element represents the index of the pass to grab from opt_passes list.

    Returns:
    Returns a tuple of optimizations from opt_passes.
    """
    # print("Opt Indice inside getPasses : ", opt_indice)
    return tuple(map((lambda x: opt_passes[x]), opt_indice))  # modified


def passes2indice(passes):
    """
    Examples :
    >>> print(passes2indice(" -correlated-propagation -scalarrepl -lowerinvoke"))
    #>>> print(passes2indice("-prune-eh -functionattrs -ipsccp -globalopt -mem2reg         -deadargelim -sroa -early-cse -loweratomic -instcombine -loop-simplify"))
    [0, 1, 2]

    #(-correlated-propagation, -scalarrepl, -lowerinvoke)

    Args:
    passes (str): string of passes separated by whitespaces.

    Returns:
    Returns a list of all the optimization passes given in the string parameter passes if they exist in opt_passes (which is the list of passes we defined in this class).
    """
    indices = []
    # print("From get_cycle.py => ",passes)
    passes = qw(passes)
    for passs in passes:
        for i in range(len(opt_passes)):
            if passs == opt_passes[i]:
                indices.append(i)
                break
    return indices

# opt_indice is changed =[] to nothing
def saveNonVariantProgram(c_code, top, script, opt_indice, path="."):
    ga_seq = getPasses(opt_indice)
    ga_seq_str = " ".join(ga_seq)
    main = top
    prologue_script = script
    script_new = prologue_script.replace("main", main)
    c_codes = ""
    for file in c_code:
        c_codes += file
        c_codes += " "
    script_new = script_new.replace("test_c_code", c_codes)
    script_new = script_new.replace("opt_passes", ga_seq_str)

    # Update the Makefile
    f = open(path + "/script.sh", "w")
    f.write(script_new)
    f.close()
    st = os.stat(path + "/script.sh")
    os.chmod(path + "/script.sh", st.st_mode | 0o111)
    proc = subprocess.Popen([path + "/script.sh"], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            shell=True, cwd=path)
    (out, err) = proc.communicate()
    bc_code = path + "/" + main + ".bc"
    assembly_code = path + "/" + main + ".s"
    destination_dir = path + "/" + "Non_Variant_Program"
    if os.path.exists(destination_dir) and os.path.isdir(destination_dir):
        os.remove(assembly_code)
        os.remove(bc_code)
    else:
        os.makedirs(destination_dir)
        shutil.move(bc_code, destination_dir)
        shutil.move(assembly_code, destination_dir)


def analyze_assembly_file(file):
    with open(file, 'r') as asm:
        line = asm.readlines()
        main_func_1 = {'main_operand_1': [], 'main_operation_1': [], 'branch_list_1': []}
        j_count = 0
        count_1 = 0
        count_2 = 0
        for j in range(1, len(line)):
            # if 'ret' in line[j]:
            #     continue
            # ignoring jump op
            if line[j].startswith('\tl.j') or line[j].startswith('\tl.bf'):
                j_count += 1
                continue

            if line[j].startswith('\t') and count_1 == 0 and not line[j].startswith('\t.'):
                if j_count == 1:
                    j_count -= 1
                    continue
                else:
                    name = line[j]
                    head_1, sep_1, tail_1 = name.partition('\t')
                    head_2, sep_2, tail_2 = tail_1.partition('\t')
                    head_3, sep_3, tail_3 = tail_2.partition('\n')
                    main_func_1['main_operand_1'].append(head_2)
                    main_func_1['main_operation_1'].append(head_3)

            if line[j].startswith('.L'):
                count_1 = count_1 + 1
                count_2 = count_2 + 1
                name = line[j]
                head, sep, tail = name.partition(':')
                head_1, sep_1, tail_10 = head.partition('.')
                main_func_1['branch_list_1'].append(tail_10)
                main_func_1[tail_10 + '_operand'] = []
                main_func_1[tail_10 + '_operation'] = []

            if line[j].startswith('\t') and count_2 > 0 and not line[j].startswith('\t.'):
                if j_count == 1:
                    j_count -= 1
                    continue
                else:
                    name = line[j]
                    head_1, sep_1, tail_1 = name.partition('\t')
                    head_2, sep_2, tail_2 = tail_1.partition('\t')
                    head_3, sep_3, tail_3 = tail_2.partition('\n')
                    main_func_1['main_operand_1'].append(head_2)
                    main_func_1['main_operation_1'].append(head_3)
    asm.close()
    return main_func_1



def similarity_score_between_fast(main_func_1, main_func_2):
    op_list_2 = list(map(lambda s: s.strip(), main_func_2['main_operand_1']))
    op_list_1 = list(map(lambda s: s.strip(), main_func_1['main_operand_1']))

    oprt_list_2 = list(map(lambda s: s.strip(), main_func_2['main_operation_1']))
    oprt_list_1 = list(map(lambda s: s.strip(), main_func_1['main_operation_1']))

    x = list(dict.fromkeys(op_list_2))
    op_list_sort_2 = sorted(x)

    y = list(dict.fromkeys(op_list_1))
    op_list_sort_1 = sorted(y)

    freq_table2 = {key: {inner_key: 0 for inner_key in op_list_sort_2} for key in op_list_sort_2}
    # Populate the frequency table
    for i in range(len(op_list_2) - 1):
        current_op = op_list_2[i]
        next_op = op_list_2[i + 1]
        if current_op in freq_table2 and next_op in freq_table2[current_op]:
            freq_table2[current_op][next_op] += 1

    freq_table1 = {key: {inner_key: 0 for inner_key in op_list_sort_1} for key in op_list_sort_1}
    # Populate the frequency table
    for i in range(len(op_list_1) - 1):
        current_op = op_list_1[i]
        next_op = op_list_1[i + 1]
        if current_op in freq_table1 and next_op in freq_table1[current_op]:
            freq_table1[current_op][next_op] += 1

    similarity_table_opcode = {}

    # Iterate through the keys present in both frequency tables
    for key in set(freq_table1.keys()) & set(freq_table2.keys()):
        # Use dictionary comprehension to find the minimum values for matching keys
        similarity_table_opcode[key] = {inner_key: min(freq_table1[key].get(inner_key, float('inf')), freq_table2[key].get(inner_key, float('inf')))
                                           for inner_key in set(freq_table1[key].keys()) & set(freq_table2[key].keys())}

    score_opcode = sum(sum(inner_dict.values()) for inner_dict in similarity_table_opcode.values())

    x1 = list(dict.fromkeys(oprt_list_2))
    op_list_sort_2 = sorted(x1)

    y1 = list(dict.fromkeys(oprt_list_1))
    op_list_sort_1 = sorted(y1)

    freq_table2 = {key: {inner_key: 0 for inner_key in op_list_sort_2} for key in op_list_sort_2}
    # Populate the frequency table
    for i in range(len(oprt_list_2) - 1):
        current_op = oprt_list_2[i]
        next_op = oprt_list_2[i + 1]
        if current_op in freq_table2 and next_op in freq_table2[current_op]:
            freq_table2[current_op][next_op] += 1

    freq_table1 = {key: {inner_key: 0 for inner_key in op_list_sort_1} for key in op_list_sort_1}
    # Populate the frequency table
    for i in range(len(oprt_list_1) - 1):
        current_op = oprt_list_1[i]
        next_op = oprt_list_1[i + 1]
        if current_op in freq_table1 and next_op in freq_table1[current_op]:
            freq_table1[current_op][next_op] += 1

    similarity_table_operand = {}

    # Iterate through the keys present in both frequency tables
    for key in set(freq_table1.keys()) & set(freq_table2.keys()):
        # Use dictionary comprehension to find the minimum values for matching keys
        similarity_table_operand[key] = {inner_key: min(freq_table1[key].get(inner_key, float('inf')), freq_table2[key].get(inner_key, float('inf')))
                                           for inner_key in set(freq_table1[key].keys()) & set(freq_table2[key].keys())}

    score_oprand = sum(sum(inner_dict.values()) for inner_dict in similarity_table_operand.values())
    score = score_opcode + score_oprand
    return score



def getSimilarityCount(c_code, top, script, opt_indice, path="."):
    done = False
    script_lines = []
    main = top
    prologue_script_t = script
    script_new = prologue_script_t.replace("main", main)
    c_codes = ""
    for file in c_code:
        c_codes += file
        c_codes += " "
    script_new = script_new.replace("test_c_code", c_codes)

    for i in range(0, len(opt_indice)):
        ga_seq = " ".join(getPasses(opt_indice[i]))
        script_lines.append(f"${{opt_path}}/opt -S {ga_seq}  ${{main_prog}}_b4.ll -o ${{main_prog}}_a4_{i+1}.ll")
        script_lines.append(f"${{opt_path}}/llvm-as ${{main_prog}}_a4_{i+1}.ll -o ${{main_prog}}_{i+1}.bc")
        script_lines.append(f"${{opt_path}}/llc ${{main_prog}}_{i+1}.bc -o ${{main_prog}}_{i+1}.s")
    script_new += '\n'.join(script_lines)
    script_new += '\n'
    script_new = script_new.replace("main", main) #why commented mibench TODO
    f = open(path + "/script_t.sh", "w")
    f.write(script_new)
    f.close()
    st = os.stat(path + "/script_t.sh")
    os.chmod(path + "/script_t.sh", st.st_mode | 0o111)

    proc = subprocess.Popen([path + f"/script_t.sh"], stdout=subprocess.PIPE, stderr=subprocess.PIPE,
                            shell=True, cwd=path)
    (out, err) = proc.communicate()

    main_func = {}
    score = {}
    # print("ERR: ", err)
    if proc.returncode == 0:
        s_files = [f for f in os.listdir(path) if f.endswith('.s') and main in f]
        s_files.append("Non_Variant_Program/" +  main + ".s")
        for i, s_file in enumerate(s_files, start=1):
            if check_main_at_line_start(path + "/" + s_file):
                if i == len(s_files):
                    main_func["main"] = analyze_assembly_file(path + "/" + s_file)
                else:
                    main_func["v"+str(i)] = analyze_assembly_file(path + "/" + s_file)
            else:
                done = False
                return 100000, done
        # import time
        for combo in itertools.combinations(main_func, 2):
            start_time = time.time()
            score[combo[0]+"-"+combo[1]] = similarity_score_between_fast(main_func[combo[0]], main_func[combo[1]])
            print("Executed Time: ",time.time() - start_time)
        highest_value = max(score.values())
        ten_percent_of_highest = 0.1 * highest_value
        # print("10% of the highest value: ", ten_percent_of_highest)
        values_below_ten_percent = {key: value for key, value in score.items() if value < ten_percent_of_highest}

        if len(values_below_ten_percent) > 0:
            done = False
            return 100000, done
        else:
            done = True
            average = round(sum(score.values()) / len(score))
            print(score)
            print(f"Weighted Average: {average}")
            print("PASS: ", opt_indice)
            return average, done
    else:
        done = False
        return 100000, done





def getSimilarityCountfromFiles(c_code, risc_gcc, dir=None):
    if dir is None:
        raise ValueError("The directory is empty")
    else:
        main = c_code.split('.')[0]
        files = [f for f in os.listdir(dir) if f.endswith('.s') and main in f]
        files.append("Non_Variant_Program/" +  main + ".s")
        main_func = {}
        score = {}
        for i, s_file in enumerate(files, start=1):
            if i == len(files):
                main_func["main"] = analyze_assembly_file(dir + "/" + s_file)
            else:
                main_func["v" + str(i)] = analyze_assembly_file(dir + "/" + s_file)
            modified_content = []
            file_path = dir + "/" + s_file
            print("s_files: ", s_file)
            with open(dir + "/" + s_file, 'r') as file:
                lines = file.readlines()

            # Process lines
            count = 0
            for i, line in enumerate(lines):
                if count == 0 and lines[i + 2] == "main:                                   # @main\n":
                    if lines[i - 1] != "        .globl  main\n" and lines[i - 2] != "        .hidden  main\n":
                        modified_content.append("        .hidden main\n")
                        modified_content.append("        .globl  main\n")
                    count += 1
                modified_content.append(line)

            # Write the modified content back to the file or to a new file
            with open(file_path, 'w') as file:
                file.writelines(modified_content)
            file.close()
            print("File has been modified successfully.")
            compile_c_code(dir, risc_gcc, s_file)
        for combo in itertools.combinations(main_func, 2):
            score[combo[0] + "-" + combo[1]] = similarity_score_between_fast(main_func[combo[0]], main_func[combo[1]])
        average = round(sum(score.values()) / len(score))
        return average, True

# Function to check if 'main:' is at the start of a line in the assembly file
def check_main_at_line_start(file_path):
    try:

        with open(file_path, 'r') as file:
            # Read the file line by line
            lines = file.readlines()
            import re
            pattern = re.compile(r'\.' + re.escape("globl") + r'\s+aes_main')
            #pattern = re.compile(r'\.' + re.escape("globl") + r'\s+main')
            for line in lines:
                if pattern.search(line):
                    return True
            return True

    except FileNotFoundError:
        print(f"The file {file_path} was not found.")
        return False

def compile_c_code(file_path,risc_gcc, asm):
    file = file_path + "/" + asm
    process = subprocess.run([risc_gcc, '-o', file_path+"/"+ asm +'.o', file],
                         stderr=subprocess.PIPE,
                         text=True)

    return process.returncode




