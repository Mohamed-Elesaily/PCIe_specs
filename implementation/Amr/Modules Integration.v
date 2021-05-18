module RX #(parameter GEN1_PIPEWIDTH = 8, parameter GEN2_PIPEWIDTH = 16, parameter GEN3_PIPEWIDTH = 32, parameter GEN4_PIPEWIDTH = 8,
			parameter GEN5_PIPEWIDTH = 8)(input reset, input clk, input [2:0]GEN, input [15:0]PhyStatus, input [15:0]RxValid,
										input [15:0]RxStartBlock, input [47:0]RxStatus, input [31:0]RxSyncHeader, input [15:0]RxElectricalIdle,
										input [511:0]RxData, input [63:0]RxDataK, input turnOff);
	
	wire [5:0]PIPEWIDTH;
	wire [511:0]PIPEData, descramblerData, LMCData;
	wire [63:0]PIPEDataK, descramblerDataK, LMCDataK;
	wire [15:0]PIPEDataValid, descramblerDataValid, LMCValid;
	wire [31:0]PIPESyncHeader, descramblerSyncHeader;
	reg [4:0]LANESNUMBER = 16;
	
	genvar i;
	
	generate
		for(i=0; i<16; i=i+1)
			begin
			localparam integer j = i*2;
			localparam integer k = i*3;
			localparam integer l = i*4;
			localparam integer m = i*32;
			PIPE_Rx_Data #(.GEN1_PIPEWIDTH(GEN1_PIPEWIDTH), .GEN2_PIPEWIDTH(GEN2_PIPEWIDTH), .GEN3_PIPEWIDTH(GEN3_PIPEWIDTH), .GEN4_PIPEWIDTH(GEN4_PIPEWIDTH),
						.GEN5_PIPEWIDTH(GEN5_PIPEWIDTH)) 
						PIPE(.reset(reset), .clk(clk), .GEN(GEN), .RxValid(RxValid[i]), .RxStatus(RxStatus[k+:3]), .PhyStatus(PhyStatus[i]),
							.RxData(RxData[m+:32]), .RxDataK(RxDataK[l+:4]), .RxStartBlock(RxStartBlock[i]), .RxSyncHeader(RxSyncHeader[j+:2]), .PIPEWIDTH(PIPEWIDTH),
							.PIPESyncHeader(PIPESyncHeader[j+:2]), .PIPEDataValid(PIPEDataValid[i]), .PIPEData(PIPEData[m+:32]), .PIPEDataK(PIPEDataK[l+:4]));
							
			Descrambler descrambler(.clk(clk), .reset(reset), .turnOff(turnOff), .PIPEDataValid(PIPEDataValid[i]), .PIPEWIDTH(PIPEWIDTH), 
								.PIPESyncHeader(PIPESyncHeader[j+:2]), .seedValue(24'b0), .PIPEData(PIPEData[m+:32]), .PIPEDataK(PIPEDataK[l+:4]), 
								.descramblerDataValid(descramblerDataValid[i]), .descramblerData(descramblerData[m+:32]), .descramblerDataK(descramblerDataK[l+:4]), 
								.descramblerSyncHeader(descramblerSyncHeader[j+:2]));	
			end
	endgenerate
	
	LMC #(.GEN1_PIPEWIDTH(GEN1_PIPEWIDTH), .GEN2_PIPEWIDTH(GEN2_PIPEWIDTH), .GEN3_PIPEWIDTH(GEN3_PIPEWIDTH), .GEN4_PIPEWIDTH(GEN4_PIPEWIDTH), .GEN5_PIPEWIDTH(GEN5_PIPEWIDTH))  
		lmc (.clk(clk), .reset(reset), .GEN(GEN), .descramblerSyncHeader(descramblerSyncHeader), .descramblerDataValid(descramblerDataValid),
			.LANESNUMBER(LANESNUMBER), .LMCIn(descramblerData), .descramblerDataK(descramblerDataK), .LMCValid(LMCValid), .LMCDataK(LMCDataK),.LMCData(LMCData));
										
endmodule
