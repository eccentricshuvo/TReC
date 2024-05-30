; ModuleID = 'isqrt.c'
target datalayout = "E-m:e-p:32:32-i8:8:8-i16:16:16-i64:32:32-f64:32:32-v64:32:32-v128:32:32-a0:0:32-n32"
target triple = "or1k"

%struct.int_sqrt = type { i32, i32 }

; Function Attrs: nounwind
define hidden void @usqrt(i32 %x, %struct.int_sqrt* %q) #0 {
entry:
  %x.addr = alloca i32, align 4
  %q.addr = alloca %struct.int_sqrt*, align 4
  %a = alloca i32, align 4
  %r = alloca i32, align 4
  %e = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store %struct.int_sqrt* %q, %struct.int_sqrt** %q.addr, align 4
  store i32 0, i32* %a, align 4
  store i32 0, i32* %r, align 4
  store i32 0, i32* %e, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 32
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %r, align 4
  %shl = shl i32 %1, 2
  %2 = load i32, i32* %x.addr, align 4
  %and = and i32 %2, -1073741824
  %shr = lshr i32 %and, 30
  %add = add i32 %shl, %shr
  store i32 %add, i32* %r, align 4
  %3 = load i32, i32* %x.addr, align 4
  %shl1 = shl i32 %3, 2
  store i32 %shl1, i32* %x.addr, align 4
  %4 = load i32, i32* %a, align 4
  %shl2 = shl i32 %4, 1
  store i32 %shl2, i32* %a, align 4
  %5 = load i32, i32* %a, align 4
  %shl3 = shl i32 %5, 1
  %add4 = add i32 %shl3, 1
  store i32 %add4, i32* %e, align 4
  %6 = load i32, i32* %r, align 4
  %7 = load i32, i32* %e, align 4
  %cmp5 = icmp uge i32 %6, %7
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %8 = load i32, i32* %e, align 4
  %9 = load i32, i32* %r, align 4
  %sub = sub i32 %9, %8
  store i32 %sub, i32* %r, align 4
  %10 = load i32, i32* %a, align 4
  %inc = add i32 %10, 1
  store i32 %inc, i32* %a, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %11 = load i32, i32* %i, align 4
  %inc6 = add nsw i32 %11, 1
  store i32 %inc6, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %12 = load %struct.int_sqrt*, %struct.int_sqrt** %q.addr, align 4
  %13 = bitcast %struct.int_sqrt* %12 to i8*
  %14 = bitcast i32* %a to i8*
  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %13, i8* %14, i32 4, i32 4, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i32(i8* nocapture, i8* nocapture readonly, i32, i32, i1) #1

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="true" }
attributes #1 = { argmemonly nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.1 (https://github.com/m-labs/clang-or1k c25a468e470db1ecba2d74e7c0d034fc7c4bd83f) (https://github.com/m-labs/llvm-or1k ed46799ac82a3857d427e583c7378bff8c28b5fa)"}
