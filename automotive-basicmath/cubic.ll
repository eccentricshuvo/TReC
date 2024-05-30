; ModuleID = 'cubic.c'
target datalayout = "E-m:e-p:32:32-i8:8:8-i16:16:16-i64:32:32-f64:32:32-v64:32:32-v128:32:32-a0:0:32-n32"
target triple = "or1k"

; Function Attrs: nounwind
define hidden void @SolveCubic(double %a, double %b, double %c, double %d, i32* %solutions, double* %x) #0 {
entry:
  %a.addr = alloca double, align 8
  %b.addr = alloca double, align 8
  %c.addr = alloca double, align 8
  %d.addr = alloca double, align 8
  %solutions.addr = alloca i32*, align 4
  %x.addr = alloca double*, align 4
  %a1 = alloca double, align 4
  %a2 = alloca double, align 4
  %a3 = alloca double, align 4
  %Q = alloca double, align 4
  %R = alloca double, align 4
  %R2_Q3 = alloca double, align 8
  %theta = alloca double, align 8
  store double %a, double* %a.addr, align 8
  store double %b, double* %b.addr, align 8
  store double %c, double* %c.addr, align 8
  store double %d, double* %d.addr, align 8
  store i32* %solutions, i32** %solutions.addr, align 4
  store double* %x, double** %x.addr, align 4
  %0 = load double, double* %b.addr, align 8
  %1 = load double, double* %a.addr, align 8
  %div = fdiv double %0, %1
  store double %div, double* %a1, align 4
  %2 = load double, double* %c.addr, align 8
  %3 = load double, double* %a.addr, align 8
  %div1 = fdiv double %2, %3
  store double %div1, double* %a2, align 4
  %4 = load double, double* %d.addr, align 8
  %5 = load double, double* %a.addr, align 8
  %div2 = fdiv double %4, %5
  store double %div2, double* %a3, align 4
  %6 = load double, double* %a1, align 4
  %7 = load double, double* %a1, align 4
  %mul = fmul double %6, %7
  %8 = load double, double* %a2, align 4
  %mul3 = fmul double 3.000000e+00, %8
  %sub = fsub double %mul, %mul3
  %div4 = fdiv double %sub, 9.000000e+00
  store double %div4, double* %Q, align 4
  %9 = load double, double* %a1, align 4
  %mul5 = fmul double 2.000000e+00, %9
  %10 = load double, double* %a1, align 4
  %mul6 = fmul double %mul5, %10
  %11 = load double, double* %a1, align 4
  %mul7 = fmul double %mul6, %11
  %12 = load double, double* %a1, align 4
  %mul8 = fmul double 9.000000e+00, %12
  %13 = load double, double* %a2, align 4
  %mul9 = fmul double %mul8, %13
  %sub10 = fsub double %mul7, %mul9
  %14 = load double, double* %a3, align 4
  %mul11 = fmul double 2.700000e+01, %14
  %add = fadd double %sub10, %mul11
  %div12 = fdiv double %add, 5.400000e+01
  store double %div12, double* %R, align 4
  %15 = load double, double* %R, align 4
  %16 = load double, double* %R, align 4
  %mul13 = fmul double %15, %16
  %17 = load double, double* %Q, align 4
  %18 = load double, double* %Q, align 4
  %mul14 = fmul double %17, %18
  %19 = load double, double* %Q, align 4
  %mul15 = fmul double %mul14, %19
  %sub16 = fsub double %mul13, %mul15
  store double %sub16, double* %R2_Q3, align 8
  %20 = load double, double* %R2_Q3, align 8
  %cmp = fcmp ole double %20, 0.000000e+00
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %21 = load i32*, i32** %solutions.addr, align 4
  store i32 3, i32* %21, align 4
  %22 = load double, double* %R, align 4
  %23 = load double, double* %Q, align 4
  %24 = load double, double* %Q, align 4
  %mul17 = fmul double %23, %24
  %25 = load double, double* %Q, align 4
  %mul18 = fmul double %mul17, %25
  %call = call double @sqrt(double %mul18) #2
  %div19 = fdiv double %22, %call
  %call20 = call double @acos(double %div19) #2
  store double %call20, double* %theta, align 8
  %26 = load double, double* %Q, align 4
  %call21 = call double @sqrt(double %26) #2
  %mul22 = fmul double -2.000000e+00, %call21
  %27 = load double, double* %theta, align 8
  %div23 = fdiv double %27, 3.000000e+00
  %call24 = call double @cos(double %div23) #2
  %mul25 = fmul double %mul22, %call24
  %28 = load double, double* %a1, align 4
  %div26 = fdiv double %28, 3.000000e+00
  %sub27 = fsub double %mul25, %div26
  %29 = load double*, double** %x.addr, align 4
  %arrayidx = getelementptr inbounds double, double* %29, i32 0
  store double %sub27, double* %arrayidx, align 4
  %30 = load double, double* %Q, align 4
  %call28 = call double @sqrt(double %30) #2
  %mul29 = fmul double -2.000000e+00, %call28
  %31 = load double, double* %theta, align 8
  %call30 = call double @atan(double 1.000000e+00) #2
  %mul31 = fmul double 4.000000e+00, %call30
  %mul32 = fmul double 2.000000e+00, %mul31
  %add33 = fadd double %31, %mul32
  %div34 = fdiv double %add33, 3.000000e+00
  %call35 = call double @cos(double %div34) #2
  %mul36 = fmul double %mul29, %call35
  %32 = load double, double* %a1, align 4
  %div37 = fdiv double %32, 3.000000e+00
  %sub38 = fsub double %mul36, %div37
  %33 = load double*, double** %x.addr, align 4
  %arrayidx39 = getelementptr inbounds double, double* %33, i32 1
  store double %sub38, double* %arrayidx39, align 4
  %34 = load double, double* %Q, align 4
  %call40 = call double @sqrt(double %34) #2
  %mul41 = fmul double -2.000000e+00, %call40
  %35 = load double, double* %theta, align 8
  %call42 = call double @atan(double 1.000000e+00) #2
  %mul43 = fmul double 4.000000e+00, %call42
  %mul44 = fmul double 4.000000e+00, %mul43
  %add45 = fadd double %35, %mul44
  %div46 = fdiv double %add45, 3.000000e+00
  %call47 = call double @cos(double %div46) #2
  %mul48 = fmul double %mul41, %call47
  %36 = load double, double* %a1, align 4
  %div49 = fdiv double %36, 3.000000e+00
  %sub50 = fsub double %mul48, %div49
  %37 = load double*, double** %x.addr, align 4
  %arrayidx51 = getelementptr inbounds double, double* %37, i32 2
  store double %sub50, double* %arrayidx51, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %38 = load i32*, i32** %solutions.addr, align 4
  store i32 1, i32* %38, align 4
  %39 = load double, double* %R2_Q3, align 8
  %call52 = call double @sqrt(double %39) #2
  %40 = load double, double* %R, align 4
  %call53 = call double @fabs(double %40) #3
  %add54 = fadd double %call52, %call53
  %call55 = call double @pow(double %add54, double 0x3FD5555555555555) #2
  %41 = load double*, double** %x.addr, align 4
  %arrayidx56 = getelementptr inbounds double, double* %41, i32 0
  store double %call55, double* %arrayidx56, align 4
  %42 = load double, double* %Q, align 4
  %43 = load double*, double** %x.addr, align 4
  %arrayidx57 = getelementptr inbounds double, double* %43, i32 0
  %44 = load double, double* %arrayidx57, align 4
  %div58 = fdiv double %42, %44
  %45 = load double*, double** %x.addr, align 4
  %arrayidx59 = getelementptr inbounds double, double* %45, i32 0
  %46 = load double, double* %arrayidx59, align 4
  %add60 = fadd double %46, %div58
  store double %add60, double* %arrayidx59, align 4
  %47 = load double, double* %R, align 4
  %cmp61 = fcmp olt double %47, 0.000000e+00
  %cond = select i1 %cmp61, i32 1, i32 -1
  %conv = sitofp i32 %cond to double
  %48 = load double*, double** %x.addr, align 4
  %arrayidx62 = getelementptr inbounds double, double* %48, i32 0
  %49 = load double, double* %arrayidx62, align 4
  %mul63 = fmul double %49, %conv
  store double %mul63, double* %arrayidx62, align 4
  %50 = load double, double* %a1, align 4
  %div64 = fdiv double %50, 3.000000e+00
  %51 = load double*, double** %x.addr, align 4
  %arrayidx65 = getelementptr inbounds double, double* %51, i32 0
  %52 = load double, double* %arrayidx65, align 4
  %sub66 = fsub double %52, %div64
  store double %sub66, double* %arrayidx65, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: nounwind
declare double @acos(double) #0

; Function Attrs: nounwind
declare double @sqrt(double) #0

; Function Attrs: nounwind
declare double @cos(double) #0

; Function Attrs: nounwind
declare double @atan(double) #0

; Function Attrs: nounwind
declare double @pow(double, double) #0

; Function Attrs: nounwind readnone
declare double @fabs(double) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="true" }
attributes #1 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="true" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 (https://github.com/m-labs/clang-or1k c25a468e470db1ecba2d74e7c0d034fc7c4bd83f) (https://github.com/m-labs/llvm-or1k ed46799ac82a3857d427e583c7378bff8c28b5fa)"}
