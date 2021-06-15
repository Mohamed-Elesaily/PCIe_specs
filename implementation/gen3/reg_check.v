module reg_check(
    input clk,
    input rst,
    input [26:0]data_in,
    output [26:0]data_out
);
reg [26:0] data_out_reg;

always @(posedge clk,negedge rst) begin
    if(!rst)begin
    data_out_reg <= 26'd0;
    end
    else 
    data_out_reg <= data_in;
    begin
    end

    
end 
assign  data_out = data_out_reg;
endmodule