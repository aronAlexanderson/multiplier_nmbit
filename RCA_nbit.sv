module RCA_nbit #(parameter N = 4) (
    input logic [N-1:0] A, B,
    input logic cin,
    output logic cout,
    output logic [N-1:0] SUM
);
    logic [N:0] C;
    assign C[0] = cin;
    assign cout = C[N];

    genvar i;
    generate
        for (i = 0; i < N; i++) 
        begin : generate_adders
            full_adder adder (
                .a(A[i]),
                .b(B[i]),
                .cin(C[i]),
                .sum(SUM[i]),
                .cout(C[i+1])
                );
        end
    endgenerate

endmodule
