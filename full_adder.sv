module full_adder (
    input logic a, b, cin,
    output logic cout, sum
);
    // behavioral modeling of full adder
    assign cout = (a & b) | (cin & a) | (cin & b);
    assign sum = a ^ b ^ cin;
endmodule
