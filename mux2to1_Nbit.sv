module mux2to1_Nbit #(parameter N = 8) (
    input logic [N - 1:0] A,
    input logic [N - 1:0] B,
    input logic s,
    output logic [N - 1:0] OUT
);
    genvar i;
    generate
        for (i = 0; i < N; i++)
        begin : generate_2to1_muxes
            mux2to1 mux2to1 (
                .a(A[i]),
                .b(B[i]),
                .s(s),
                .out(OUT[i])
                );
        end
    endgenerate
endmodule
