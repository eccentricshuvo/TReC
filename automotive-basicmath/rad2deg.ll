; ModuleID = 'rad2deg.c'
target datalayout = "E-m:e-p:32:32-i8:8:8-i16:16:16-i64:32:32-f64:32:32-v64:32:32-v128:32:32-a0:0:32-n32"
target triple = "or1k"

; Function Attrs: nounwind
define hidden double @rad2deg(double %rad) #0 {
entry:
  %rad.addr = alloca double, align 8
  store double %rad, double* %rad.addr, align 8
  %0 = load double, double* %rad.addr, align 8
  %mul = fmul double 1.800000e+02, %0
  %call = call double @atan(double 1.000000e+00) #1
  %mul1 = fmul double 4.000000e+00, %call
  %div = fdiv double %mul, %mul1
  ret double %div
}

; Function Attrs: nounwind
declare double @atan(double) #0

; Function Attrs: nounwind
define hidden double @deg2rad(double %deg) #0 {
entry:
  %deg.addr = alloca double, align 8
  store double %deg, double* %deg.addr, align 8
  %call = call double @atan(double 1.000000e+00) #1
  %mul = fmul double 4.000000e+00, %call
  %0 = load double, double* %deg.addr, align 8
  %mul1 = fmul double %mul, %0
  %div = fdiv double %mul1, 1.800000e+02
  ret double %div
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="true" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 (https://github.com/m-labs/clang-or1k c25a468e470db1ecba2d74e7c0d034fc7c4bd83f) (https://github.com/m-labs/llvm-or1k ed46799ac82a3857d427e583c7378bff8c28b5fa)"}
