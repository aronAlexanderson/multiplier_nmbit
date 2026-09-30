module twos_complementor_Nbit #(parameter N=8) 
   (
    input  logic [N-1:0] B,
    input  logic cin,
    output logic [N-1:0] BC
    );
    logic [N-1:0] BC_partial;

    RCA_nbit #(N) adder(
        .A(BC_partial),
        .B({N{1'b0}}),
        .cin(cin),
        .SUM(BC)
        );

   genvar i;
   generate
      for (i = 0; i < N; i++) begin : complementor
         xor2_delay comp (
            .a(B[i]),
            .b(cin),
            .y(BC_partial[i])
            );
      end
   endgenerate



endmodule
