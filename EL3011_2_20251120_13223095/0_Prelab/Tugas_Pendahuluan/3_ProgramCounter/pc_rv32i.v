module pc_rv32i #(
    parameter WIDTH = 32
) (
    input wire clk, reset,
    input wire signed [WIDTH-1:0] PCin,
    output reg signed [WIDTH-1:0] PCout
);
    always @(posedge clk or negedge reset) begin
        if (clk) 
            PCout <= PCin;
        else
            PCout <= 0;
    end
endmodule