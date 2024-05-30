; ModuleID = 'basicmath.c'
target datalayout = "E-m:e-p:32:32-i8:8:8-i16:16:16-i64:32:32-f64:32:32-v64:32:32-v128:32:32-a0:0:32-n32"
target triple = "or1k"

%struct.int_sqrt = type { i32, i32 }

@.str = private unnamed_addr constant [39 x i8] c"********* CUBIC FUNCTIONS ***********\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"Solutions:\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c" %f\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.4 = private unnamed_addr constant [41 x i8] c"********* INTEGER SQR ROOTS ***********\0A\00", align 1
@.str.5 = private unnamed_addr constant [17 x i8] c"sqrt(%3d) = %2d\0A\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"sqrt(%lX) = %X\0A\00", align 1
@.str.7 = private unnamed_addr constant [40 x i8] c"********* ANGLE CONVERSION ***********\0A\00", align 1
@.str.8 = private unnamed_addr constant [31 x i8] c"%3.0f degrees = %.12f radians\0A\00", align 1
@.str.9 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.10 = private unnamed_addr constant [31 x i8] c"%.12f radians = %3.0f degrees\0A\00", align 1

; Function Attrs: nounwind
define hidden i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %a1 = alloca double, align 8
  %b1 = alloca double, align 8
  %c1 = alloca double, align 8
  %d1 = alloca double, align 8
  %x = alloca [3 x double], align 8
  %X = alloca double, align 8
  %solutions = alloca i32, align 4
  %i = alloca i32, align 4
  %l = alloca i32, align 4
  %q = alloca %struct.int_sqrt, align 4
  %n = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store double 1.000000e+00, double* %a1, align 8
  store double -1.050000e+01, double* %b1, align 8
  store double 3.200000e+01, double* %c1, align 8
  store double -3.000000e+01, double* %d1, align 8
  store i32 1072497001, i32* %l, align 4
  store i32 0, i32* %n, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str, i32 0, i32 0))
  %0 = load double, double* %a1, align 8
  %1 = load double, double* %b1, align 8
  %2 = load double, double* %c1, align 8
  %3 = load double, double* %d1, align 8
  %arraydecay = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %0, double %1, double %2, double %3, i32* %solutions, double* %arraydecay)
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %4 = load i32, i32* %i, align 4
  %5 = load i32, i32* %solutions, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %6 = load i32, i32* %i, align 4
  %arrayidx = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %6
  %7 = load double, double* %arrayidx, align 8
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %7)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %8 = load i32, i32* %i, align 4
  %inc = add nsw i32 %8, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %call3 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double 1.000000e+00, double* %a1, align 8
  store double -4.500000e+00, double* %b1, align 8
  store double 1.700000e+01, double* %c1, align 8
  store double -3.000000e+01, double* %d1, align 8
  %9 = load double, double* %a1, align 8
  %10 = load double, double* %b1, align 8
  %11 = load double, double* %c1, align 8
  %12 = load double, double* %d1, align 8
  %arraydecay4 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %9, double %10, double %11, double %12, i32* %solutions, double* %arraydecay4)
  %call5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc11, %for.end
  %13 = load i32, i32* %i, align 4
  %14 = load i32, i32* %solutions, align 4
  %cmp7 = icmp slt i32 %13, %14
  br i1 %cmp7, label %for.body8, label %for.end13

for.body8:                                        ; preds = %for.cond6
  %15 = load i32, i32* %i, align 4
  %arrayidx9 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %15
  %16 = load double, double* %arrayidx9, align 8
  %call10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %16)
  br label %for.inc11

for.inc11:                                        ; preds = %for.body8
  %17 = load i32, i32* %i, align 4
  %inc12 = add nsw i32 %17, 1
  store i32 %inc12, i32* %i, align 4
  br label %for.cond6

for.end13:                                        ; preds = %for.cond6
  %call14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double 1.000000e+00, double* %a1, align 8
  store double -3.500000e+00, double* %b1, align 8
  store double 2.200000e+01, double* %c1, align 8
  store double -3.100000e+01, double* %d1, align 8
  %18 = load double, double* %a1, align 8
  %19 = load double, double* %b1, align 8
  %20 = load double, double* %c1, align 8
  %21 = load double, double* %d1, align 8
  %arraydecay15 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %18, double %19, double %20, double %21, i32* %solutions, double* %arraydecay15)
  %call16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond17

for.cond17:                                       ; preds = %for.inc22, %for.end13
  %22 = load i32, i32* %i, align 4
  %23 = load i32, i32* %solutions, align 4
  %cmp18 = icmp slt i32 %22, %23
  br i1 %cmp18, label %for.body19, label %for.end24

for.body19:                                       ; preds = %for.cond17
  %24 = load i32, i32* %i, align 4
  %arrayidx20 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %24
  %25 = load double, double* %arrayidx20, align 8
  %call21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %25)
  br label %for.inc22

for.inc22:                                        ; preds = %for.body19
  %26 = load i32, i32* %i, align 4
  %inc23 = add nsw i32 %26, 1
  store i32 %inc23, i32* %i, align 4
  br label %for.cond17

for.end24:                                        ; preds = %for.cond17
  %call25 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double 1.000000e+00, double* %a1, align 8
  store double -1.370000e+01, double* %b1, align 8
  store double 1.000000e+00, double* %c1, align 8
  store double -3.500000e+01, double* %d1, align 8
  %27 = load double, double* %a1, align 8
  %28 = load double, double* %b1, align 8
  %29 = load double, double* %c1, align 8
  %30 = load double, double* %d1, align 8
  %arraydecay26 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %27, double %28, double %29, double %30, i32* %solutions, double* %arraydecay26)
  %call27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc33, %for.end24
  %31 = load i32, i32* %i, align 4
  %32 = load i32, i32* %solutions, align 4
  %cmp29 = icmp slt i32 %31, %32
  br i1 %cmp29, label %for.body30, label %for.end35

for.body30:                                       ; preds = %for.cond28
  %33 = load i32, i32* %i, align 4
  %arrayidx31 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %33
  %34 = load double, double* %arrayidx31, align 8
  %call32 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %34)
  br label %for.inc33

for.inc33:                                        ; preds = %for.body30
  %35 = load i32, i32* %i, align 4
  %inc34 = add nsw i32 %35, 1
  store i32 %inc34, i32* %i, align 4
  br label %for.cond28

for.end35:                                        ; preds = %for.cond28
  %call36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double 3.000000e+00, double* %a1, align 8
  store double 1.234000e+01, double* %b1, align 8
  store double 5.000000e+00, double* %c1, align 8
  store double 1.200000e+01, double* %d1, align 8
  %36 = load double, double* %a1, align 8
  %37 = load double, double* %b1, align 8
  %38 = load double, double* %c1, align 8
  %39 = load double, double* %d1, align 8
  %arraydecay37 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %36, double %37, double %38, double %39, i32* %solutions, double* %arraydecay37)
  %call38 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond39

for.cond39:                                       ; preds = %for.inc44, %for.end35
  %40 = load i32, i32* %i, align 4
  %41 = load i32, i32* %solutions, align 4
  %cmp40 = icmp slt i32 %40, %41
  br i1 %cmp40, label %for.body41, label %for.end46

for.body41:                                       ; preds = %for.cond39
  %42 = load i32, i32* %i, align 4
  %arrayidx42 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %42
  %43 = load double, double* %arrayidx42, align 8
  %call43 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %43)
  br label %for.inc44

for.inc44:                                        ; preds = %for.body41
  %44 = load i32, i32* %i, align 4
  %inc45 = add nsw i32 %44, 1
  store i32 %inc45, i32* %i, align 4
  br label %for.cond39

for.end46:                                        ; preds = %for.cond39
  %call47 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double -8.000000e+00, double* %a1, align 8
  store double -6.789000e+01, double* %b1, align 8
  store double 6.000000e+00, double* %c1, align 8
  store double -2.360000e+01, double* %d1, align 8
  %45 = load double, double* %a1, align 8
  %46 = load double, double* %b1, align 8
  %47 = load double, double* %c1, align 8
  %48 = load double, double* %d1, align 8
  %arraydecay48 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %45, double %46, double %47, double %48, i32* %solutions, double* %arraydecay48)
  %call49 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond50

for.cond50:                                       ; preds = %for.inc55, %for.end46
  %49 = load i32, i32* %i, align 4
  %50 = load i32, i32* %solutions, align 4
  %cmp51 = icmp slt i32 %49, %50
  br i1 %cmp51, label %for.body52, label %for.end57

for.body52:                                       ; preds = %for.cond50
  %51 = load i32, i32* %i, align 4
  %arrayidx53 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %51
  %52 = load double, double* %arrayidx53, align 8
  %call54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %52)
  br label %for.inc55

for.inc55:                                        ; preds = %for.body52
  %53 = load i32, i32* %i, align 4
  %inc56 = add nsw i32 %53, 1
  store i32 %inc56, i32* %i, align 4
  br label %for.cond50

for.end57:                                        ; preds = %for.cond50
  %call58 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double 4.500000e+01, double* %a1, align 8
  store double 8.670000e+00, double* %b1, align 8
  store double 7.500000e+00, double* %c1, align 8
  store double 3.400000e+01, double* %d1, align 8
  %54 = load double, double* %a1, align 8
  %55 = load double, double* %b1, align 8
  %56 = load double, double* %c1, align 8
  %57 = load double, double* %d1, align 8
  %arraydecay59 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %54, double %55, double %56, double %57, i32* %solutions, double* %arraydecay59)
  %call60 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond61

for.cond61:                                       ; preds = %for.inc66, %for.end57
  %58 = load i32, i32* %i, align 4
  %59 = load i32, i32* %solutions, align 4
  %cmp62 = icmp slt i32 %58, %59
  br i1 %cmp62, label %for.body63, label %for.end68

for.body63:                                       ; preds = %for.cond61
  %60 = load i32, i32* %i, align 4
  %arrayidx64 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %60
  %61 = load double, double* %arrayidx64, align 8
  %call65 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %61)
  br label %for.inc66

for.inc66:                                        ; preds = %for.body63
  %62 = load i32, i32* %i, align 4
  %inc67 = add nsw i32 %62, 1
  store i32 %inc67, i32* %i, align 4
  br label %for.cond61

for.end68:                                        ; preds = %for.cond61
  %call69 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double -1.200000e+01, double* %a1, align 8
  store double -1.700000e+00, double* %b1, align 8
  store double 5.300000e+00, double* %c1, align 8
  store double 1.600000e+01, double* %d1, align 8
  %63 = load double, double* %a1, align 8
  %64 = load double, double* %b1, align 8
  %65 = load double, double* %c1, align 8
  %66 = load double, double* %d1, align 8
  %arraydecay70 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %63, double %64, double %65, double %66, i32* %solutions, double* %arraydecay70)
  %call71 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond72

for.cond72:                                       ; preds = %for.inc77, %for.end68
  %67 = load i32, i32* %i, align 4
  %68 = load i32, i32* %solutions, align 4
  %cmp73 = icmp slt i32 %67, %68
  br i1 %cmp73, label %for.body74, label %for.end79

for.body74:                                       ; preds = %for.cond72
  %69 = load i32, i32* %i, align 4
  %arrayidx75 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %69
  %70 = load double, double* %arrayidx75, align 8
  %call76 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %70)
  br label %for.inc77

for.inc77:                                        ; preds = %for.body74
  %71 = load i32, i32* %i, align 4
  %inc78 = add nsw i32 %71, 1
  store i32 %inc78, i32* %i, align 4
  br label %for.cond72

for.end79:                                        ; preds = %for.cond72
  %call80 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store double 1.000000e+00, double* %a1, align 8
  br label %for.cond81

for.cond81:                                       ; preds = %for.inc111, %for.end79
  %72 = load double, double* %a1, align 8
  %cmp82 = fcmp olt double %72, 1.000000e+01
  br i1 %cmp82, label %for.body83, label %for.end113

for.body83:                                       ; preds = %for.cond81
  store double 1.000000e+01, double* %b1, align 8
  br label %for.cond84

for.cond84:                                       ; preds = %for.inc108, %for.body83
  %73 = load double, double* %b1, align 8
  %cmp85 = fcmp ogt double %73, 0.000000e+00
  br i1 %cmp85, label %for.body86, label %for.end110

for.body86:                                       ; preds = %for.cond84
  store double 5.000000e+00, double* %c1, align 8
  br label %for.cond87

for.cond87:                                       ; preds = %for.inc106, %for.body86
  %74 = load double, double* %c1, align 8
  %cmp88 = fcmp olt double %74, 1.500000e+01
  br i1 %cmp88, label %for.body89, label %for.end107

for.body89:                                       ; preds = %for.cond87
  store double -1.000000e+00, double* %d1, align 8
  br label %for.cond90

for.cond90:                                       ; preds = %for.inc104, %for.body89
  %75 = load double, double* %d1, align 8
  %cmp91 = fcmp ogt double %75, -5.000000e+00
  br i1 %cmp91, label %for.body92, label %for.end105

for.body92:                                       ; preds = %for.cond90
  %76 = load double, double* %a1, align 8
  %77 = load double, double* %b1, align 8
  %78 = load double, double* %c1, align 8
  %79 = load double, double* %d1, align 8
  %arraydecay93 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 0
  call void @SolveCubic(double %76, double %77, double %78, double %79, i32* %solutions, double* %arraydecay93)
  %call94 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond95

for.cond95:                                       ; preds = %for.inc100, %for.body92
  %80 = load i32, i32* %i, align 4
  %81 = load i32, i32* %solutions, align 4
  %cmp96 = icmp slt i32 %80, %81
  br i1 %cmp96, label %for.body97, label %for.end102

for.body97:                                       ; preds = %for.cond95
  %82 = load i32, i32* %i, align 4
  %arrayidx98 = getelementptr inbounds [3 x double], [3 x double]* %x, i32 0, i32 %82
  %83 = load double, double* %arrayidx98, align 8
  %call99 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i32 0, i32 0), double %83)
  br label %for.inc100

for.inc100:                                       ; preds = %for.body97
  %84 = load i32, i32* %i, align 4
  %inc101 = add nsw i32 %84, 1
  store i32 %inc101, i32* %i, align 4
  br label %for.cond95

for.end102:                                       ; preds = %for.cond95
  %call103 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  br label %for.inc104

for.inc104:                                       ; preds = %for.end102
  %85 = load double, double* %d1, align 8
  %sub = fsub double %85, 4.510000e-01
  store double %sub, double* %d1, align 8
  br label %for.cond90

for.end105:                                       ; preds = %for.cond90
  br label %for.inc106

for.inc106:                                       ; preds = %for.end105
  %86 = load double, double* %c1, align 8
  %add = fadd double %86, 6.100000e-01
  store double %add, double* %c1, align 8
  br label %for.cond87

for.end107:                                       ; preds = %for.cond87
  br label %for.inc108

for.inc108:                                       ; preds = %for.end107
  %87 = load double, double* %b1, align 8
  %sub109 = fsub double %87, 2.500000e-01
  store double %sub109, double* %b1, align 8
  br label %for.cond84

for.end110:                                       ; preds = %for.cond84
  br label %for.inc111

for.inc111:                                       ; preds = %for.end110
  %88 = load double, double* %a1, align 8
  %add112 = fadd double %88, 1.000000e+00
  store double %add112, double* %a1, align 8
  br label %for.cond81

for.end113:                                       ; preds = %for.cond81
  %call114 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.4, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond115

for.cond115:                                      ; preds = %for.inc119, %for.end113
  %89 = load i32, i32* %i, align 4
  %cmp116 = icmp slt i32 %89, 100000
  br i1 %cmp116, label %for.body117, label %for.end121

for.body117:                                      ; preds = %for.cond115
  %90 = load i32, i32* %i, align 4
  call void @usqrt(i32 %90, %struct.int_sqrt* %q)
  %91 = load i32, i32* %i, align 4
  %sqrt = getelementptr inbounds %struct.int_sqrt, %struct.int_sqrt* %q, i32 0, i32 0
  %92 = load i32, i32* %sqrt, align 4
  %call118 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.5, i32 0, i32 0), i32 %91, i32 %92)
  br label %for.inc119

for.inc119:                                       ; preds = %for.body117
  %93 = load i32, i32* %i, align 4
  %add120 = add nsw i32 %93, 2
  store i32 %add120, i32* %i, align 4
  br label %for.cond115

for.end121:                                       ; preds = %for.cond115
  %call122 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0))
  store i32 1072497001, i32* %l, align 4
  br label %for.cond123

for.cond123:                                      ; preds = %for.inc128, %for.end121
  %94 = load i32, i32* %l, align 4
  %cmp124 = icmp ult i32 %94, 1072513385
  br i1 %cmp124, label %for.body125, label %for.end130

for.body125:                                      ; preds = %for.cond123
  %95 = load i32, i32* %l, align 4
  call void @usqrt(i32 %95, %struct.int_sqrt* %q)
  %96 = load i32, i32* %l, align 4
  %sqrt126 = getelementptr inbounds %struct.int_sqrt, %struct.int_sqrt* %q, i32 0, i32 0
  %97 = load i32, i32* %sqrt126, align 4
  %call127 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i32 0, i32 0), i32 %96, i32 %97)
  br label %for.inc128

for.inc128:                                       ; preds = %for.body125
  %98 = load i32, i32* %l, align 4
  %inc129 = add i32 %98, 1
  store i32 %inc129, i32* %l, align 4
  br label %for.cond123

for.end130:                                       ; preds = %for.cond123
  %call131 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.7, i32 0, i32 0))
  store double 0.000000e+00, double* %X, align 8
  br label %for.cond132

for.cond132:                                      ; preds = %for.inc138, %for.end130
  %99 = load double, double* %X, align 8
  %cmp133 = fcmp ole double %99, 3.600000e+02
  br i1 %cmp133, label %for.body134, label %for.end140

for.body134:                                      ; preds = %for.cond132
  %100 = load double, double* %X, align 8
  %101 = load double, double* %X, align 8
  %call135 = call double @atan(double 1.000000e+00) #2
  %mul = fmul double 4.000000e+00, %call135
  %mul136 = fmul double %101, %mul
  %div = fdiv double %mul136, 1.800000e+02
  %call137 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.8, i32 0, i32 0), double %100, double %div)
  br label %for.inc138

for.inc138:                                       ; preds = %for.body134
  %102 = load double, double* %X, align 8
  %add139 = fadd double %102, 1.000000e-03
  store double %add139, double* %X, align 8
  br label %for.cond132

for.end140:                                       ; preds = %for.cond132
  %call141 = call i32 @puts(i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.9, i32 0, i32 0))
  store double 0.000000e+00, double* %X, align 8
  br label %for.cond142

for.cond142:                                      ; preds = %for.inc154, %for.end140
  %103 = load double, double* %X, align 8
  %call143 = call double @atan(double 1.000000e+00) #2
  %mul144 = fmul double 4.000000e+00, %call143
  %mul145 = fmul double 2.000000e+00, %mul144
  %add146 = fadd double %mul145, 1.000000e-06
  %cmp147 = fcmp ole double %103, %add146
  br i1 %cmp147, label %for.body148, label %for.end159

for.body148:                                      ; preds = %for.cond142
  %104 = load double, double* %X, align 8
  %105 = load double, double* %X, align 8
  %mul149 = fmul double %105, 1.800000e+02
  %call150 = call double @atan(double 1.000000e+00) #2
  %mul151 = fmul double 4.000000e+00, %call150
  %div152 = fdiv double %mul149, %mul151
  %call153 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.10, i32 0, i32 0), double %104, double %div152)
  br label %for.inc154

for.inc154:                                       ; preds = %for.body148
  %call155 = call double @atan(double 1.000000e+00) #2
  %mul156 = fmul double 4.000000e+00, %call155
  %div157 = fdiv double %mul156, 5.760000e+03
  %106 = load double, double* %X, align 8
  %add158 = fadd double %106, %div157
  store double %add158, double* %X, align 8
  br label %for.cond142

for.end159:                                       ; preds = %for.cond142
  ret i32 0
}

declare i32 @printf(i8*, ...) #1

declare void @SolveCubic(double, double, double, double, i32*, double*) #1

declare void @usqrt(i32, %struct.int_sqrt*) #1

; Function Attrs: nounwind
declare double @atan(double) #0

declare i32 @puts(i8*) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="true" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="true" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 (https://github.com/m-labs/clang-or1k c25a468e470db1ecba2d74e7c0d034fc7c4bd83f) (https://github.com/m-labs/llvm-or1k ed46799ac82a3857d427e583c7378bff8c28b5fa)"}
