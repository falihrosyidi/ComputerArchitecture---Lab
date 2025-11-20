module mux2to1 #(
    parameter WIDTH = 32
) (
    input wire sel,
    input wire [WIDTH-1:0] A,
    input wire [WIDTH-1:0] B,
    output wire [WIDTH-1:0] Y
);
    assign Y = (sel) ? B: A;
endmodule