module half_adder (
    A,
    B,
    sum,
    cout
);

input A,B;
output sum,cout;

xor(sum,A,B);
and(cout,A,B);
    
endmodule