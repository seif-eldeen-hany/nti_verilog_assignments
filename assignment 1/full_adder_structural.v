module full_adder_structural (
    A,
    B,
    Cin,
    sum,
    cout
);
input A,B,Cin;
output sum ,cout;

wire sum1, carry1, carry2;

half_adder HF1(
    .A(A),
    .B(B),
    .sum(sum1),
    .cout(carry1)
);

half_adder HF2(
    .A(sum1),
    .B(Cin),
    .sum(sum),
    .cout(carry2)
);

or(cout,carry1,carry2);

endmodule