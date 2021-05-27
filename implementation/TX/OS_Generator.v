module OS_GENERATOR (pclk, reset_n, os_type, lane_number, link_number, rate, loopback , detected_lanes, gen, start, finish, Os_Out, DataK, busy, DataValid);
parameter pipewidth=8;
parameter no_of_lanes=16;
input [1:0] os_type;
input [1:0]lane_number;
input [7:0]link_number;
input [2:0] rate;
input loopback;
input [15:0]detected_lanes;
input [2:0] gen;
input start;
input pclk;
input reset_n;
output reg busy;
output reg finish;
output reg [511:0] Os_Out;
output reg [63:0]DataK;
output reg [63:0]DataValid;
reg [pipewidth*no_of_lanes-1:0] os_out;
reg [((pipewidth/8)*no_of_lanes)-1:0]datak;
reg [((pipewidth/8)*no_of_lanes)-1:0]datavalid;
reg send;
reg [1:0] os_type_reg;
reg [1:0] lane_number_reg;
reg [no_of_lanes-1:0]detected_lanes_reg;
reg [2:0] gen_reg;
reg [3:0] symbol;
reg [4:0] count;
reg D;
reg K;
reg valid;
reg not_valid;
reg [31:0] skp;
reg [31:0] EIOS;
reg [127:0] TS1;
reg [127:0] TS2;
integer i;
always@(posedge pclk) begin
 if ( reset_n == 1'b0)
   send = 1'b0;  // in order to know that there won't be an order set to send
   valid = 1'b1;//represents that data is valid
   not_valid = 1'b0;//represents that data isn't valid
 if (start) begin 
   os_type_reg = os_type; // storing the type of the order set
   lane_number_reg = lane_number; // storing the type of lanes 
   detected_lanes_reg <= detected_lanes; //storing the detected lanes
   gen_reg = gen; // storing the PCIe generation 
   symbol = 4'b0000; // flag which detects which symbol to be sent 
   send = 1'b1; // in order to know that there will be an order to send
   count = 5'b00000; // counter which countes the number of lanes detected
   D = 1'b0;//reperesents the order sets is D character
   K = 1'b1;//represents that the order set is K character
   // preparation of the order set based on the inputs coming from the Tx LTSSM
   skp = 32'h1C1C1CBC;
   EIOS = 32'h7C7C7CBC;
   TS1[7:0] = 8'hBC;
   
   if (link_number==8'b00000000)
    TS1[15:8] = 8'hF7;
	
   else 
    TS1[15:8] = link_number;
	
   TS1[31:24] = 8'b0000000;
   if ( rate == 3'b001) 
     TS1[39:32] = 8'b00000010;
	
   else if ( rate == 3'b010) 
     TS1[39:32] = 8'b00000100;
	 
   else if ( rate == 3'b011) 
     TS1[39:32] = 8'b00001000;
	 
   else if ( rate == 3'b100) 
     TS1[39:32] = 8'b00010000;
	 
   else  
     TS1[39:32] = 8'b00100000;
	 
   if(loopback)
     TS1[47:40] = 8'b00000100;
	 
   else
     TS1[47:40] = 8'b00000000;
	
   TS1[127:48] = 80'h4A4A4A4A4A4A4A4A4A4A;
   
   TS2[7:0] = 8'hBC;
   if (link_number==8'b00000000)
    TS2[15:8] = 8'hF7;
   else 
    TS2[15:8] = link_number;
	
   TS2[31:24] = 8'b0000000;
   if ( rate == 3'b001) 
     TS2[39:32] = 8'b00000010;
	
   else if ( rate == 3'b010) 
     TS2[39:32] = 8'b00000100;
	 
   else if ( rate == 3'b011) 
     TS2[39:32] = 8'b00001000;
	 
   else if ( rate == 3'b100) 
     TS2[39:32] = 8'b00010000;
	 
   else  
     TS2[39:32] = 8'b00100000;
	 
   if(loopback)
     TS2[47:40] = 8'b00000100;
	 
   else
     TS2[47:40] = 8'b00000000;
	
   TS2[127:48] = 80'h4545454545454545454A;
   
   for (i=0;i<no_of_lanes;i=i+1)begin // counting the number of lanes
    if(detected_lanes_reg==1'b1)
	  count=count+1;
	end
	
  end
   
	if(send)begin//if there are order sets available to be sent
	  busy = 1'b1;
	  finish=1'b0;
	  datavalid = {((pipewidth/8)*no_of_lanes){valid}};
	  // ******************************************************checking if TS1 order sets to be sent********************************************
	  if (os_type_reg==2'b00)begin
	    if(gen_reg==3'b001 | gen_reg == 3'b010)begin// checking if the device wants to work at generation one
		
		  if(symbol==4'b0000)begin // checking if symbol 0 is to be sent
		    os_out ={no_of_lanes{TS1[7:0]}};
			datak ={((pipewidth/8)*no_of_lanes){K}};
			end
			
		  else if(symbol==4'b001) begin // checking if symbol 1 is to be sent
		    os_out ={no_of_lanes{TS1[15:8]}};
			
			if (TS1[15:8] == 8'hF7)
              datak ={((pipewidth/8)*no_of_lanes){K}};
			  
	        else 
			   datak ={((pipewidth/8)*no_of_lanes){D}};
		     
			end
				
		  else if(symbol==4'b0010)begin // checking if symbol 2 is to be sent
		     if(lane_number_reg==2'b00)begin 
			   if (count==5'b00001)begin
			     os_out = 8'hF7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
				 
			   else if (count==00100)begin
			     os_out = 32'hF7F7F7F7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
				 
			   else if (count==01000)begin
			     os_out = 64'hF7F7F7F7F7F7F7F7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
				 
			  else begin
			     os_out = 128'hF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
			 end
			 
			 else if(lane_number_reg==2'b01)begin // checking if lanes number are sequential
			   if (count==5'b00001)begin
			     os_out = 8'h01;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==00100)begin
			     os_out = 32'h04030201;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==01000)begin
			     os_out = 64'h0807060504030201;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			 else begin
			     os_out = 128'h100F0E0D0C0B0A090807060504030201;
				 datak = {((pipewidth/8)*no_of_lanes){D}};
				 end
			 end
			 
			 else begin // checking if lanes number are sequentially reversed
			   if (count==5'b00001)begin
			     os_out = 8'h01;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==00100)begin
			     os_out = 32'h01020304;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==01000)begin
			     os_out = 64'h0102030405060708;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else begin
			     os_out = 128'h0102030405060708090A0B0C0D0E0F10;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
			 end
			end
			
	       else if(symbol==4'b0011) begin // checking if symbol 3 is to be sent
		    os_out ={no_of_lanes{TS1[31:24]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else if(symbol==4'b0100) begin // checking if symbol 4 is to be sent
		    os_out ={no_of_lanes{TS1[39:32]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
		
	    else if(symbol==4'b0101) begin // checking if symbol 5 is to be sent
		    os_out ={no_of_lanes{TS1[47:40]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else if(symbol==4'b0110|symbol==4'b0111|symbol==4'b1000|symbol==4'b1001|symbol==4'b1010|symbol==4'b1011|symbol==4'b1100|symbol==4'b1101|symbol==4'b1110) begin // checking if symbol 6 or 7 or 8 or 9 or 10 or 11 or 12 or 13 or 14  is to be sent
		    os_out ={no_of_lanes{TS1[55:48]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else  begin
		    os_out ={no_of_lanes{TS1[127:120]}};// checking if symbol 15 is to be sent
			datak ={((pipewidth/8)*no_of_lanes){D}};
			send =1'b0;
			finish =1'b1;
			busy =1'b0;
		    end
			 symbol=symbol+1; 
		   end
		  end 
		 
		  // ******************************************************checking if TS2 order sets to be sent********************************************
      else if (os_type_reg==2'b01)begin
	    if(gen_reg==3'b001 | gen_reg == 3'b010)begin// checking if the device wants to work at generation one
		
		  if(symbol==4'b0000)begin // checking if symbol 0 is to be sent
		    os_out ={no_of_lanes{TS2[7:0]}};
			datak ={((pipewidth/8)*no_of_lanes){K}};
			end
			
		  else if(symbol==4'b001) begin // checking if symbol 1 is to be sent
		    os_out ={no_of_lanes{TS2[15:8]}};
			
			if (TS2[15:8] == 8'hF7)
              datak ={((pipewidth/8)*no_of_lanes){K}};
			  
	        else 
			   datak ={((pipewidth/8)*no_of_lanes){D}};
			
			end
				
		  else if(symbol==4'b0010)begin // checking if symbol 2 is to be sent
		     if(lane_number_reg==2'b00)begin 
			   if (count==5'b00001)begin
			     os_out = 8'hF7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
				 
			   else if (count==00100)begin
			     os_out = 32'hF7F7F7F7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
				 
			   else if (count==01000)begin
			     os_out = 64'hF7F7F7F7F7F7F7F7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
				 
			  else begin
			     os_out = 128'hF7F7F7F7F7F7F7F7F7F7F7F7F7F7F7F7;
				 datak ={((pipewidth/8)*no_of_lanes){K}};
				 end
			 end
			 
			 else if(lane_number_reg==2'b01)begin // checking if lanes number are sequential
			   if (count==5'b00001)begin
			     os_out = 8'h01;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==00100)begin
			     os_out = 32'h04030201;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==01000)begin
			     os_out = 64'h0807060504030201;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			 else begin
			     os_out = 128'h100F0E0D0C0B0A090807060504030201;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
			 end
			 
			 else begin // checking if lanes number are sequentially reversed
			   if (count==5'b00001)begin
			     os_out = 8'h01;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==00100)begin
			     os_out = 32'h01020304;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else if (count==01000)begin
			     os_out = 64'h0102030405060708;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
				 
			   else begin
			     os_out = 128'h0102030405060708090A0B0C0D0E0F10;
				 datak ={((pipewidth/8)*no_of_lanes){D}};
				 end
			 end
			end
			
	       else if(symbol==4'b0011) begin // checking if symbol 3 is to be sent
		    os_out ={no_of_lanes{TS2[31:24]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else if(symbol==4'b0100) begin // checking if symbol 4 is to be sent
		    os_out ={no_of_lanes{TS2[39:32]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
		
	    else if(symbol==4'b0101) begin // checking if symbol 5 is to be sent
		    os_out={no_of_lanes{TS2[47:40]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else if(symbol==4'b0110) begin // checking if symbol 6 is to be sent
		    os_out ={no_of_lanes{TS2[55:48]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else if(symbol==4'b0111|symbol==4'b1000|symbol==4'b1001|symbol==4'b1010|symbol==4'b1011|symbol==4'b1100|symbol==4'b1101|symbol==4'b1110) begin // checking if symbol  7 or 8 or 9 or 10 or 11 or 12 or 13 or 14  is to be sent
		    os_out ={no_of_lanes{TS2[63:56]}};
			datak ={((pipewidth/8)*no_of_lanes){D}};
			end
			
		else  begin // checking if symbol 15 is to be sent
		    os_out={no_of_lanes{TS2[127:120]}};
			datak={((pipewidth/8)*no_of_lanes){D}};
			send=1'b0;
			finish=1'b1;
			busy=1'b0;
		    end
			 symbol<=symbol+1; 
		   end
		  end 
		   // ******************************************************checking if skip order sets to be sent********************************************
      else if (os_type_reg==2'b10)begin
	    if(gen_reg==3'b001 | gen_reg == 3'b010)begin// checking if the device wants to work at generation one
		
		  if(symbol==4'b0000)begin // checking if symbol 0 is to be sent
		    os_out={no_of_lanes{skp[7:0]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			end
			
		  else if(symbol==4'b001) begin // checking if symbol 1 is to be sent
		    os_out={no_of_lanes{skp[15:8]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			end
			
			else if(symbol==4'b0010) begin // checking if symbol 1 is to be sent
		    os_out={no_of_lanes{skp[23:16]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			end
			
			else if(symbol==4'b0011) begin // checking if symbol 1 is to be sent
		    os_out={no_of_lanes{skp[31:24]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			send =1'b0;
			finish=1'b1;
			busy=1'b0;
			end
			symbol=symbol+1; 
		   end
		  end 
		  // ******************************************************checking if EIOS order sets to be sent********************************************
      else begin
	    if(gen_reg==3'b001 | gen_reg == 3'b010)begin// checking if the device wants to work at generation one
		
		  if(symbol==4'b0000)begin // checking if symbol 0 is to be sent
		    os_out={no_of_lanes{EIOS[7:0]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			end
			
		  else if(symbol==4'b001) begin // checking if symbol 1 is to be sent
		    os_out={no_of_lanes{EIOS[15:8]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			end
			
			else if(symbol==4'b0010) begin // checking if symbol 1 is to be sent
		    os_out={no_of_lanes{EIOS[23:16]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			end
			
			else if(symbol==4'b0011) begin // checking if symbol 1 is to be sent
		    os_out={no_of_lanes{EIOS[31:24]}};
			datak={((pipewidth/8)*no_of_lanes){K}};
			send=1'b0;
			finish=1'b1;
			busy=1'b0;
			end
			symbol<=symbol+1; 
		   end
		  end 
		 end
		else begin  //if there are no order sets available to be sent
		  datavalid = {((pipewidth/8)*no_of_lanes){not_valid}};
		  os_out={no_of_lanes*pipewidth{not_valid}};
		  datak= {((pipewidth/8)*no_of_lanes){not_valid}};
		  finish=1'b0;
		  busy= 1'b0;
		 end
		if (count==5'b00001)begin
		 Os_Out={504'b0,os_out};
		 DataK ={63'b0,datak};
		 DataValid={63'b0,datavalid};
		 end
		else if (count==5'b00100)begin
		 Os_Out={480'b0,os_out};
		 DataK ={60'b0,datak};
		 DataValid={60'b0,datavalid};
		 end
		else if (count==5'b01000)begin
		 Os_Out={448'b0,os_out};
		 DataK={56'b0,datak};
		 DataValid={56'b0,datavalid};
		 end
		 else begin
		 Os_Out={384'b0,os_out};
		 DataK={48'b0,datak};
		 DataValid={48'b0,datavalid};
		 end
	  end
	endmodule	  
