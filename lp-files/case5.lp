\ SCIP STATISTICS
\   Problem name     : case5.zpl
\   Variables        : 15 (0 binary, 0 integer, 0 implicit integer, 15 continuous)
\   Constraints      : 18
Maximize
 Obj: +1 objvar
Subject to
 constraint1_1: +2 w1 +1 w2 +1 w3 = +1.001
 constraint2_1: +1 a1 +1 b2 +1 c2 <= +1
 constraint3_1: +1 a2 +1 b1 +1 c2 <= +1
 constraint4_1: +1 a2 +1 b2 +1 c1 <= +1
 constraint5_1: +1 a1 -1 a2 >= +0
 constraint6_1: +1 b1 -1 b2 >= +0
 constraint7_1: +1 c1 -1 c2 >= +0
 constraint8_1: +1 w1 -1 a2 + [ -1 n1 * a1 +1 n1 * a2 ] = +0
 constraint9_1: +1 w2 -1 b2 + [ -1 n2 * b1 +1 b2 * n2 ] = +0
 constraint10_1: +1 w3 -1 c2 + [ -1 n3 * c1 +1 c2 * n3 ] = +0
 constraint11_1: +1 w1 -1 w2 >= +0
 constraint12_1: +1 w1 -1 w3 >= +0
 constraint13_1: +1 a1 +1 b1 +1 c2 >= +1
 constraint14_1: +1 a1 +1 b2 +1 c1 <= +1
 constraint15_1: +1 a2 +1 b1 +1 c1 >= +1
 constraint16_1: +1 n12 + [ -1 n1 * n2 ] = +0
 constraint17_1: +1 n23 + [ -1 n2 * n3 ] = +0
 obj: +1 n12 -1 objvar +1 n23 + [ -1 n23 * n1 ] >= +0
Bounds
 0 <= a1 <= 1
 0 <= a2 <= 1
 0 <= b1 <= 1
 0 <= b2 <= 1
 0 <= c1 <= 1
 0 <= c2 <= 1
 0 <= w1 <= 1
 0 <= w2 <= 1
 0 <= w3 <= 1
 0 <= n1 <= 1
 0 <= n2 <= 1
 0 <= n3 <= 1
 0 <= n12 <= 1
 0 <= n23 <= 1
 objvar free
End
