module full_adder_behavioral (
    A,
    B,
    Cin,
    sum,
    cout
);
    
    input A,B,Cin;
    output reg sum ,cout;
 
 always @(*) begin
    {cout,sum}=A+B+Cin;
 end
    
endmodule