module pc_4_adder_rv32i #(
    parameter WIDTH = 32
) (
    input wire [WIDTH-1:0] PCold,
    output wire [WIDTH-1:0] PC_4_inc
);
    assign PC_4_inc = PCold + 4;
endmodule