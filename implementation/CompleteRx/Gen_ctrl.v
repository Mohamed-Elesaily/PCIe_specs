<<<<<<< HEAD:implementation/esaily/hdl/Packet_Identifier/Gen_ctrl.v
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
    input [4:0]numberOfDetectedLanes,

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
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*1){1'b0}},{(GEN1_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*2){1'b0}},{(GEN1_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*4){1'b0}},{(GEN1_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*8){1'b0}},{(GEN1_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*16){1'b0}},{(GEN1_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    gen2_sel:
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*1){1'b0}},{(GEN2_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*2){1'b0}},{(GEN2_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*4){1'b0}},{(GEN2_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*8){1'b0}},{(GEN2_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*16){1'b0}},{(GEN2_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
       
    gen3_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*1){1'b0}},{(GEN3_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*2){1'b0}},{(GEN3_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*4){1'b0}},{(GEN3_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*8){1'b0}},{(GEN3_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*16){1'b0}},{(GEN3_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    gen4_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*1){1'b0}},{(GEN4_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*2){1'b0}},{(GEN4_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*4){1'b0}},{(GEN4_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*8){1'b0}},{(GEN4_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*16){1'b0}},{(GEN4_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    gen5_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*1){1'b0}},{(GEN5_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*2){1'b0}},{(GEN5_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*4){1'b0}},{(GEN5_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*8){1'b0}},{(GEN5_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*16){1'b0}},{(GEN5_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    default:
    valid_reg = 64'b0;
        
    endcase
end


assign sel = 1'b0;
assign w = valid_pd & linkup;
assign valid = valid_reg;  
=======
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
    input [4:0]numberOfDetectedLanes,

    output sel,
    output [63:0]valid,
    output w

);

localparam gen1_sel = 3'd1;
localparam gen2_sel = 3'd2;
localparam gen3_sel = 3'd3;
localparam gen4_sel = 3'd4;
localparam gen5_sel = 3'd5;


localparam N = 64;

reg [63:0]valid_reg;



// gen decoder
always @*
begin
    case (gen)
    gen1_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*1){1'b0}},{(GEN1_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*2){1'b0}},{(GEN1_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*4){1'b0}},{(GEN1_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*8){1'b0}},{(GEN1_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN1_PIPEWIDTH/8)*16){1'b0}},{(GEN1_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    gen2_sel:
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*1){1'b0}},{(GEN2_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*2){1'b0}},{(GEN2_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*4){1'b0}},{(GEN2_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*8){1'b0}},{(GEN2_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN2_PIPEWIDTH/8)*16){1'b0}},{(GEN2_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
       
    gen3_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*1){1'b0}},{(GEN3_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*2){1'b0}},{(GEN3_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*4){1'b0}},{(GEN3_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*8){1'b0}},{(GEN3_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN3_PIPEWIDTH/8)*16){1'b0}},{(GEN3_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    gen4_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*1){1'b0}},{(GEN4_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*2){1'b0}},{(GEN4_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*4){1'b0}},{(GEN4_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*8){1'b0}},{(GEN4_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN4_PIPEWIDTH/8)*16){1'b0}},{(GEN4_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    gen5_sel: 
        case (numberOfDetectedLanes)
            5'b00001: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*1){1'b0}},{(GEN5_PIPEWIDTH/8)*1{1'b1}}};
            5'b00010: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*2){1'b0}},{(GEN5_PIPEWIDTH/8)*2{1'b1}}};
            5'b00100: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*4){1'b0}},{(GEN5_PIPEWIDTH/8)*4{1'b1}}};
            5'b01000: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*8){1'b0}},{(GEN5_PIPEWIDTH/8)*8{1'b1}}};
            default: valid_reg = {{(64 - (GEN5_PIPEWIDTH/8)*16){1'b0}},{(GEN5_PIPEWIDTH/8)*16{1'b1}}}; 
        endcase 
    default:
    valid_reg = 64'b0;
        
    endcase
end


assign sel = 1'b0;
assign w = valid_pd & linkup;
assign valid = valid_reg;  
>>>>>>> e940bfd27635d07b70b4448eb0595327daf53168:implementation/CompleteRx/Gen_ctrl.v
endmodule