module Gen_ctrl_tb();
wire [63:0]valid;
reg [2:0]gen;    
Gen_ctrl#(
     .GEN1_PIPEWIDTH (8 ) ,	
	 .GEN2_PIPEWIDTH (12) ,	
	 .GEN3_PIPEWIDTH (3) ,								
	 .GEN4_PIPEWIDTH (8 ) ,	
	 .GEN5_PIPEWIDTH (8 )
) DUT
 (
    
    // input hld_pd_gen,
    .gen(gen),
    // input rst,
    // input clk,
    // output sel,
    .valid(valid)
    // output w

);

localparam gen1_sel = 3'b000;
localparam gen2_sel = 3'b001;
localparam gen3_sel = 3'b010;
localparam gen4_sel = 3'b011;
localparam gen5_sel = 3'b100;
initial begin
    gen = gen1_sel;
    #20
    gen = gen2_sel;
    #20
    gen = 3'b111;
    #20
    $stop();
end
endmodule