module Gen_ctrl
 #(
    parameter GEN1_PIPEWIDTH = 8 ,	
	parameter GEN2_PIPEWIDTH = 16 ,	
	parameter GEN3_PIPEWIDTH = 32 ,								
	parameter GEN4_PIPEWIDTH = 8 ,	
	parameter GEN5_PIPEWIDTH = 8 
)(
    
    input valid_pd,
    input [2:0]gen,
    input linkup,
    output sel,
    output [63:0]valid,
    output w

);

localparam gen1_sel = 3'b000;
localparam gen2_sel = 3'b001;
localparam gen3_sel = 3'b010;
localparam gen4_sel = 3'b011;
localparam gen5_sel = 3'b100;


localparam N = 64;

reg [63:0]valid_reg;


// gen decoder
always @*
begin
    case (gen)
    gen1_sel: 
        valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*16){1'b0}},{(GEN1_PIPEWIDTH/8)*16{1'b1}}};
    gen2_sel: 
        valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*16){1'b0}},{(GEN2_PIPEWIDTH/8)*16{1'b1}}};
    gen3_sel: 
        valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*16){1'b0}},{(GEN3_PIPEWIDTH/8)*16{1'b1}}};
    gen4_sel: 
        valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*16){1'b0}},{(GEN4_PIPEWIDTH/8)*16{1'b1}}};
    gen5_sel: 
        valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*16){1'b0}},{(GEN5_PIPEWIDTH/8)*16{1'b1}}};
    default:
    valid_reg = 64'b0;
        
    endcase
end


assign sel = 1'b0;
assign w = valid_pd & linkup;
assign valid = valid_reg;  
endmodule