module LPIF_RX_Control_DataFlow(input clk, input reset, input [63:0]tlpstart, input [63:0]dllpstart, input [63:0]tlpend, input [63:0]dllpend, 
								input [63:0]edb, input [63:0]packetValid, input [511:0]packetData, input lp_force_detect, input [2:0]GEN, 
								input [3:0]state, output reg [63:0]pl_tlpstart, output reg [63:0]pl_dllpstart, output reg [63:0]pl_tlpend,
								output reg [63:0]pl_dllpend, output reg [63:0]pl_tlpedb, output reg [63:0]pl_valid, output reg [511:0]pl_data,
								output reg [2:0]pl_speedmode, output reg [3:0]pl_state_sts, output reg ltssmForceDetect);
			

	integer i;
	localparam STP = 8'hFB, SDP = 8'h5C, END = 8'hFD, EDB = 8'hFE;
	reg ltssmForceDetect_next;
	reg [2:0]pl_speedmode_next;
	reg [3:0]pl_state_sts_next;
	reg [511:0]data, pl_data_next;
	reg [63:0]register[0:5];
	reg [63:0]pl_valid_next, pl_tlpedb_next, pl_tlpend_next, pl_dllpend_next, pl_tlpstart_next, pl_dllpstart_next;
	
	always@(posedge clk or negedge reset)
		if(!reset)
			begin
			pl_data <= 0;
			pl_valid <= 0;
			pl_tlpedb <= 0;
			pl_tlpend <= 0;
			pl_dllpend <= 0;
			pl_dllpstart <= 0;
			pl_tlpstart <= 0;
			pl_speedmode <= 0;
			pl_state_sts <= 0;
			ltssmForceDetect <= 0;
			end
		else
			begin
			pl_data <= pl_data_next;
			pl_valid <= pl_valid_next;
			pl_tlpedb <= {pl_tlpedb_next[63:1], pl_tlpedb_next[0] | pl_tlpedb[63]};
			pl_tlpend <= {pl_tlpend_next[63:1], pl_tlpend_next[0] | pl_tlpend[63]};
			pl_dllpend <= {pl_dllpend_next[63:1], pl_dllpend_next[0] | pl_dllpend[63]};
			pl_tlpstart <= {pl_tlpstart_next[63:1]>>1, pl_tlpstart_next[0]};
			pl_dllpstart <= {pl_dllpstart_next[63:1]>>1, pl_dllpstart_next[0]};
			pl_state_sts <= pl_state_sts_next;
			pl_speedmode <= pl_speedmode_next;
			ltssmForceDetect <= ltssmForceDetect_next;
			end
			
	always@*
		begin
		register[0] = packetValid; register[1]=tlpstart; register[2]=tlpend; register[3]=edb; register[4]=dllpstart; register[5]=dllpend;
		pl_tlpstart_next = 0; pl_tlpend_next = 0; pl_tlpedb_next = 0; pl_dllpstart_next = 0; pl_dllpend_next = 0; pl_valid_next = 0;
		data = packetData;
		pl_data_next = 0;
		
		for(i=0; i<=504; i = i+8)
			begin
			pl_tlpstart_next[i/8] = register[1][i/8];
			pl_tlpend_next[i/8] = register[2][i/8];
			pl_tlpedb_next[i/8] = register[3][i/8];
			pl_dllpstart_next[i/8] = register[4][i/8];
			pl_dllpend_next[i/8] = register[5][i/8];
			
			if(register[0][i/8] == 0) //note: this won't work well if there is 2 control char after each other but the valid for second one will be 0.
				begin
				data = data>>8;
				register[0] = register[0]>>1;	//valid
				register[1] = register[1]>>1;	//tlpstart
				register[2] = register[2]>>1;	//tlpend
				register[3] = register[3]>>1;	//edb
				register[4] = register[4]>>1;	//dllpstart
				register[5] = register[5]>>1;	//dllpend
				end
				
			pl_data_next[i+:8] = data[i+:8];
			pl_valid_next[i/8] = register[0][i/8];
			end
		
		pl_tlpedb_next[63] = (((~pl_valid_next)&pl_tlpedb_next)==0)? 0:1;
		pl_tlpend_next[63] = (((~pl_valid_next)&pl_tlpend_next)==0)? 0:1;
		pl_dllpend_next[63] = (((~pl_valid_next)&pl_dllpend_next)==0)? 0:1;
		end
		
	always@*
		begin
		pl_state_sts_next <= state;
		ltssmForceDetect_next <= lp_force_detect;
		if(GEN == 1)
			pl_speedmode_next <= 3'b0;
		else if(GEN == 2)
			pl_speedmode_next <= 3'b1;
		else if(GEN == 3)
			pl_speedmode_next <= 3'b010;
		else if(GEN == 4)
			pl_speedmode_next <= 3'b011;
		else if(GEN == 5)
			pl_speedmode_next <= 3'b100;
		else
			pl_speedmode_next <= 3'b111;
		end
		
		
endmodule
