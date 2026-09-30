`timescale 1ns / 1ps

module tb_mult_MNbit_signed;

    parameter N=8;
    parameter M=8;

    logic [M-1:0] A;
    logic [N-1:0] B;
    logic [N+M-1:0] Prod;
    int x,y;
    shortint ans;
    int count = 0;

    mult_mnbit_signed #(M, N) dut (
                    .A(A),
                    .B(B),
                    .Prod(Prod)
                );

   initial begin
       for (x = -128; x < 128; x++) begin
           for (y = -128; y < 128; y++) begin 
               A = x;
               B = y;
               ans = x * y;
               #30;
               assert (Prod == ( ans )) else $fatal(1, "FUCKED UP %d: %d * %d = %d", ++count, A, B, Prod);
           end
       end
        $stop;


    end
endmodule
