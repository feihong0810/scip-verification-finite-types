# SCIP verification for finite shifted edge-type cases

This repository contains the ZIMPL/SCIP verification used in Claim 3 of the paper.

The goal is to verify a finite family of optimization problems arising from
shifted 3-partite 3-graphs in the two-value case of a fractional vertex cover.

The verification is computer-assisted. For each admissible shifted edge-type set
with at most six edge-types, we formulate the corresponding optimization problem
in ZIMPL and solve it using SCIP.

---

## Mathematical setting

Let `H` be a shifted 3-partite 3-graph with partition classes

```text
V1, V2, V3.
```

Let `g` be a fractional vertex cover of `H`.

In the two-value case, for each `i = 1,2,3`, the function `g` takes exactly two
values on `Vi`. We write

```text
Vi = Vi^- union Vi^+,
```

where `g` is constant on `Vi^-` and on `Vi^+`, and the value on `Vi^-` is smaller
than the value on `Vi^+`.

Thus the sign `-` means the smaller cover value, and the sign `+` means the larger
cover value.

---

## Edge types

An edge type is a string of three signs.

For example,

```text
+--
```

means the block

```text
V1^+ x V2^- x V3^-.
```

There are eight possible edge types:

```text
---
+--
-+-
--+
++-
+-+
-++
+++
```

For a pair `(H,g)`, the edge-type set is denoted by

```text
T(H,g).
```

It records which of the eight blocks are contained in the edge set of `H`.

For example, if

```text
+-- is in T(H,g),
```

then

```text
V1^+ x V2^- x V3^- is contained in E(H).
```

---

## Shiftedness and minimal generating sets

We order the two signs by

```text
- < +.
```

This gives a coordinatewise partial order on the eight edge types.

For example,

```text
+-- <= ++-
+-- <= +-+
+-- <= +++
```

but

```text
+-- and -++ are incomparable.
```

Since `H` is shifted, the edge-type set `T(H,g)` is an up-set in this poset.
This means:

```text
if tau is in T(H,g) and tau <= sigma,
then sigma is also in T(H,g).
```

Therefore, a shifted edge-type set is completely determined by its minimal
elements.

We call this antichain the minimal generating set and denote it by

```text
G(T).
```

The generated edge-type set is

```text
<T> = all edge types sigma such that tau <= sigma for some tau in G(T).
```

In this repository, we classify cases by the minimal generating set `G(T)`,
rather than by listing all elements of `T`.

---

## Example of minimal generation

Suppose

```text
G(T) = {+--}.
```

Then `T` contains all types above `+--`, namely

```text
T = {+--, ++-, +-+, +++}.
```

Suppose

```text
G(T) = {+--, -+-}.
```

Then the generated edge-type set is

```text
T = {+--, -+-, ++-, +-+, -++, +++}.
```

Suppose

```text
G(T) = {+--, -+-, --+}.
```

Then the generated edge-type set is

```text
T = {+--, -+-, --+, ++-, +-+, -++, +++}.
```

Equivalently,

```text
T = all eight types except ---.
```

This last case has seven edge-types, so it is not part of the `|T| <= 6`
verification in Claim 3, but it is useful for later reductions.

---

## Variables used in the ZIMPL files

The cover values are represented as follows.

```text
a1 = g-value on V1^+
a2 = g-value on V1^-

b1 = g-value on V2^+
b2 = g-value on V2^-

c1 = g-value on V3^+
c2 = g-value on V3^-
```

The convention that `+` is the larger value is encoded by

```text
a1 >= a2
b1 >= b2
c1 >= c2
```

The relative sizes of the plus-parts are represented by

```text
n1 = |V1^+| / |V1|
n2 = |V2^+| / |V2|
n3 = |V3^+| / |V3|
```

The average cover weights on the three partition classes are

```text
w1 = n1*a1 + (1-n1)*a2
w2 = n2*b1 + (1-n2)*b2
w3 = n3*c1 + (1-n3)*c2
```

---

## Cover constraints

For each edge type in `T`, we add the corresponding fractional vertex cover
constraint.

The rule is:

```text
+ in coordinate 1 means use a1.
- in coordinate 1 means use a2.

+ in coordinate 2 means use b1.
- in coordinate 2 means use b2.

+ in coordinate 3 means use c1.
- in coordinate 3 means use c2.
```

Examples:

```text
edge type +-- gives the constraint

a1 + b2 + c2 >= 1.
```

```text
edge type -+- gives the constraint

a2 + b1 + c2 >= 1.
```

```text
edge type --+ gives the constraint

a2 + b2 + c1 >= 1.
```

```text
edge type ++- gives the constraint

a1 + b1 + c2 >= 1.
```

In some ZIMPL files, these inequalities are written as equalities after applying
additional reductions from the proof. For example, one may have

```text
a1 + b2 + c2 == 1
```

instead of

```text
a1 + b2 + c2 >= 1.
```

This corresponds to working on a boundary case where the relevant cover
constraint is tight.

---

## Edge-density objective

For a fixed edge-type set `T`, the normalized edge density is obtained by summing
the relative sizes of the blocks corresponding to types in `T`.

The size contribution of a sign is:

```text
in coordinate i:

+ contributes ni,
- contributes 1-ni.
```

For example, the contribution of the type `+--` is

```text
n1*(1-n2)*(1-n3).
```

The contribution of the type `++-` is

```text
n1*n2*(1-n3).
```

The contribution of the type `+++` is

```text
n1*n2*n3.
```

Thus the objective for a type-set `T` is

```text
sum over all types in T of the corresponding block-size product.
```

Example:

If

```text
T = all eight types except ---,
```

then the missing block is

```text
---,
```

whose size is

```text
(1-n1)*(1-n2)*(1-n3).
```

Therefore the edge density is

```text
1 - (1-n1)*(1-n2)*(1-n3).
```

In ZIMPL, this can be written using an auxiliary variable such as

```text
n23 = (1-n2)*(1-n3)
```

and then the objective becomes

```text
maximize 1 - (1-n1)*n23.
```

---

## Case classification for Claim 3

Claim 3 concerns the case

```text
|T(H,g)| <= 6.
```

In our problem, the first class `V1` plays a different role from `V2` and `V3`,
while `V2` and `V3` are symmetric. Therefore, we identify two cases only if they
can be obtained from each other by swapping the second and third coordinates.

So we classify shifted edge-type sets up to the symmetry

```text
V2 <-> V3.
```

Under this convention, there are exactly 12 nontrivial shifted edge-type sets
with at most six edge-types.

The empty edge-type set is omitted, since it gives zero edge density.

---

## The 12 cases

In the table below:

```text
G(T)
```

is the minimal generating set.

```text
T
```

is the generated shifted edge-type set.

```text
Missing types
```

means the complement of `T` inside the eight possible types.

The eight possible types are

```text
---, +--, -+-, --+, ++-, +-+, -++, +++.
```

| Case | Minimal generating set `G(T)` | Generated edge-type set `T` | File | SCIP optimum | Status |
|---:|---|---|---|---:|---|
| 1 | `{+++}` | `{+++}` | `case1.zpl` | `0.5020` | optimal, gap 0.00% |
| 2 | `{+-+}` | `{+-+, +++}` | `case2.zpl` | `0.5020` | optimal, gap 0.00% |
| 3 | `{-++}` | `{-++, +++}` | `case3.zpl` | `0.5020` | optimal, gap 0.00% |
| 4 | `{++-, +-+}` | `{++-, +-+, +++}` | `case4.zpl` | `0.5010` | optimal, gap 0.00% |
| 5 | `{+-+, -++}` | `{+-+, -++, +++}` | `case5.zpl` | `0.5020` | optimal, gap 0.00% |
| 6 | `{+--}` | `{+--,<br>++-, +-+, +++}` | `case6.zpl` | `0.5010` | optimal, gap 0.00% |
| 7 | `{++-, +-+, -++}` | `{++-, +-+,<br>-++, +++}` | `case7.zpl` | `0.5567` | optimal, gap 0.00% |
| 8 | `{--+}` | `{--+, +-+,<br>-++, +++}` | `case8.zpl` | `0.5020` | optimal, gap 0.00% |
| 9 | `{+--, -++}` | `{+--, ++-,<br>+-+, -++, +++}` | `case9.zpl` | `0.5564` | optimal, gap 0.00% |
| 10 | `{++-, --+}` | `{++-, --+,<br>+-+, -++, +++}` | `case10.zpl` | `0.5567` | optimal, gap 0.00% |
| 11 | `{+--, --+}` | `{+--, ++-, +-+,<br>--+, -++, +++}` | `case11.zpl` | `0.5564` | optimal, gap 0.00% |
| 12 | `{-+-, --+}` | `{-+-, --+, ++-,<br>+-+, -++, +++}` | `case12.zpl` | `0.5567` | optimal, gap 0.00% |

---

## Running the files

The verification uses two programs:

```text
ZIMPL
SCIP
```

ZIMPL converts a `.zpl` model into a `.lp` file. SCIP then reads the `.lp` file
and solves the optimization problem.

For example, to run `case11.zpl`, first generate the `.lp` file:

```bash
zimpl case11.zpl
```

This should produce

```text
case11.lp
```

Then start SCIP:

```bash
scip
```

Inside SCIP, run:

```bash
read case11.lp
optimize
display solution
```

Alternatively, the SCIP part can be run in one line:

```bash
scip -c "read case11.lp" -c "optimize" -c "display solution" -c "quit"
```

A successful run should contain output like:

```text
SCIP Status        : problem is solved [optimal solution found]
Primal Bound       : ...
Dual Bound         : ...
Gap                : 0.00 %
```

For a maximization problem:

```text
Primal Bound
```

is the best feasible objective value found by SCIP.

```text
Dual Bound
```

is the bound proving that no better solution exists.

If the output says

```text
Gap : 0.00 %
```

then SCIP has proved optimality for this finite optimization problem, up to its
numerical tolerances.

---

## Recommended repository structure

A convenient structure is:

```text
.
├── README.md
├── case1.zpl
├── case2.zpl
├── case3.zpl
├── case4.zpl
├── case5.zpl
├── case6.zpl
├── case7.zpl
├── case8.zpl
├── case9.zpl
├── case10.zpl
├── case11.zpl
├── case12.zpl
├── lp-files/
│   ├── case1.lp
│   ├── case2.lp
│   └── ...
└── logs/
    ├── case1.log
    ├── case2.log
    └── ...
```

The `.zpl` files are the human-readable ZIMPL models.

The `.lp` files are generated by ZIMPL.

The `.log` files should contain the SCIP output, including the final primal
bound, dual bound, and gap.

---
