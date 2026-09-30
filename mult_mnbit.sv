module mult_mnbit #(parameter M = 4, parameter N = 4) (
    input logic[M-1:0] A,
    input logic [N-1:0] B,
    output logic [M+N-1:0] Prod
);

    // en till i A ger en extra komumn
    logic [N-1:0][M-1:0] prod_terms;

    // M = 4 ger alltså att det ska vara 3 rader => 3 adderare
    // N = 4 ger att det finns 4 element per rad alltså 4 tal som ska adderas
    logic [N-2:0][M-1:0] A_matrix, B_matrix;
    logic [N-1:0][M-1:0] SUM;

    // carry för varje adderare cin = C[0] = 0
    // cout för sista blir C[N-1]??
    // beror på antalet adderare
    logic [N-1:0] C;

    assign C[0] = 0;
    assign SUM[0] = prod_terms[0];

    assign Prod[N+M-2:N-1] = SUM[N-1];
    assign Prod[N+M-1] = C[N-1];

    // Generate block to create the 4 product terms
    genvar i, j, k;
    generate
        for (i = 0; i < M; i++) begin : B_loop
            for (j = 0; j < N; j++) begin : A_loop
                and2_delay u_and (
                    .a(A[i]), 
                    .b(B[j]), 
                    .y(prod_terms[j][i])
                    );
            end
        end

        for (k = 0; k < N - 1; k++) begin : adders
            assign A_matrix[k][M-2:0] = SUM[k][M-1:1];    // previous sum needs to be added
            assign A_matrix[k][M-1] = C[k];               // and the last cout
            assign B_matrix[k] = prod_terms[k+1];         // to the next terms in product
            RCA_nbit #(M) adder (
                .A(A_matrix[k]),
                .B(B_matrix[k]),        // A+B
                .cin(0),                // no cin
                .cout(C[k+1]),          // save cout
                .SUM(SUM[k+1])          // save sum to transfer next time
                );
            assign Prod[k] = SUM[k][0]; // the least significant bit of sum is part of the product
        end
    endgenerate
endmodule
