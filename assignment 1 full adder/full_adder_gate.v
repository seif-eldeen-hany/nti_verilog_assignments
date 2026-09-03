module full_adder_gate(
    A,
    B,
    Cin,
    sum,
    cout
);
input A,B,Cin;
output sum ,cout;

wire  w1,w2,w3;

// sum= A xor B xor Cin

xor(w1,A,B);
xor(sum,w1,Cin);

// cout = A.B+Cin.(A xor B)

and(w2,A,B);
and(w3,Cin,w1);
or(cout,w2,w3);
endmodule