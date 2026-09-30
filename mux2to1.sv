module mux2to1 (
    input a,
    input b,
    input s,
    output out
);
    logic s_inv, nand1_out, nand2_out;

    // out =  (~s & a) or (s & b)

    nand2_delay inverter(
        .a(s),
        .b(s),
        .y(s_inv)
        );

    nand2_delay u0 (
        .a(s_inv),
        .b(a),
        .y(nand1_out)
        );

    nand2_delay u1 (
        .a(s),
        .b(b),
        .y(nand2_out)
        );

    nand2_delay u2 (
        .a(nand1_out),
        .b(nand2_out),
        .y(out)
        );

endmodule
