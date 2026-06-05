#edge-type set:{-++, +++}
# Define variables
var a1 >= 0 <=1;
var a2 >= 0 <=1;
var b1 >= 0 <=1;
var b2 >= 0 <=1;
var c1 >= 0 <=1;
var c2 >= 0 <=1;
var w1 >= 0 <=1;
var w2 >= 0 <=1;
var w3 >= 0 <=1;
var n1 >= 0 <=1;
var n2 >= 0 <=1;
var n3 >= 0 <=1;
#var n12 >=0 <=1;
#var n23 >=0 <=1;

# Define Constraints
subto constraint1:
    2*w1 + w2 + w3 == 1.001;

subto constraint2:
    a1 + b2 + c2 <= 1;

subto constraint3:
    a2 + b1 + c2 <= 1;

subto constraint4:
    a2 + b2 + c1 <= 1;

subto constraint5:
    a1 >= a2;

subto constraint6:
    b1 >= b2;

subto constraint7:
    c1 >= c2;

subto constraint8:
    w1 == n1*a1 + (1-n1)*a2;

subto constraint9:
    w2 == n2*b1 + (1-n2)*b2;

subto constraint10:
    w3 == n3*c1 + (1-n3)*c2;

subto constraint11:
    w1 >= w2;

subto constraint12:
    w1 >= w3;

subto constraint13:
    a1 + b1 + c2 <= 1;

subto constraint14:
    a1 + b2 + c1 <= 1;

subto constraint15:
    a2 + b1 + c1 >= 1;

#subto constraint16:
#    n12 == n1*n2;

#subto constraint17:
#    n23 == n2*n3;

# Define the objective function.
maximize objective:
    n2*n3;