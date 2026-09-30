module mult_mnbit_signed #(parameter M = 4, parameter N = 4) (
    input logic [M-1:0] A,
    input logic [N-1:0] B,
    output logic [N+M-1:0] Prod
);

    logic [M-1:0] A_complement, A_in_to_mult; // lines for complement and lines out of mux
    logic [N-1:0] B_complement, B_in_to_mult; // lines for complement and lines out of mux
    logic [N+M-1:0] Ans_mag, Ans_mag_complement; // lines out of multipiler and the complement of answer

    logic xor_sign_bit;             // used to chose the correct of the answer
                                    // if A[M-1] ^ B[N-1] == 0 (both pos/neg)
                                    // ans is positive
                                    // if 1 then the answer should be negative

    xor2_delay ans_sign_logic (
        .a(A[M-1]),
        .b(B[N-1]),
        .y(xor_sign_bit)
        );

    twos_complementor_Nbit #(M) comp_A (
        .B(A),
        .BC(A_complement),
        .cin(1)
        );

    twos_complementor_Nbit #(M) comp_B (
        .B(B),
        .BC(B_complement),
        .cin(1)
        );

    mux2to1_Nbit #(M) mux_A (
        .A(A),
        .B(A_complement),
        .OUT(A_in_to_mult),
        .s(A[M-1])
        );

    mux2to1_Nbit #(N) mux_B (
        .A(B),
        .B(B_complement),
        .OUT(B_in_to_mult),
        .s(B[N-1])
        );

    mult_mnbit #(M,N) multiplier (
        .A(A_in_to_mult),
        .B(B_in_to_mult),
        .Prod(Ans_mag)
        );

    twos_complementor_Nbit #(M+N) comp_Ans (
        .B(Ans_mag),
        .BC(Ans_mag_complement),
        .cin(1)
        );

    mux2to1_Nbit #(M+N) mux_Ans (
        .A(Ans_mag),
        .B(Ans_mag_complement),
        .OUT(Prod),
        .s(xor_sign_bit)
        );


endmodule
