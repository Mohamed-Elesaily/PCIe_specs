<<<<<<< HEAD
module LFSR_32(scrambler_reset, reset_n, pclk, data_out);

  input scrambler_reset, reset_n, pclk;
  
  output wire [31:0] data_out;

  reg [15:0] lfsr_q, lfsr_c;
  reg [31:0] data_c;

  always @(*) begin
  
	if(scrambler_reset)
		lfsr_q = 16'hFFFF;

    lfsr_c[0]  = lfsr_q[0] ^ lfsr_q[6] ^ lfsr_q[ 8] ^ lfsr_q[10];
    lfsr_c[1]  = lfsr_q[1] ^ lfsr_q[7] ^ lfsr_q[ 9] ^ lfsr_q[11];
    lfsr_c[2]  = lfsr_q[2] ^ lfsr_q[8] ^ lfsr_q[10] ^ lfsr_q[12];
    lfsr_c[3]  = lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13];
    lfsr_c[4]  = lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14];
    lfsr_c[5]  = lfsr_q[5] ^ lfsr_q[6] ^ lfsr_q[ 7] ^ lfsr_q[ 9] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15];
    lfsr_c[6]  = lfsr_q[0] ^ lfsr_q[6] ^ lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[10] ^ lfsr_q[13] ^ lfsr_q[14];
    lfsr_c[7]  = lfsr_q[1] ^ lfsr_q[7] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[11] ^ lfsr_q[14] ^ lfsr_q[15];
    lfsr_c[8]  = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[15];
    lfsr_c[9]  = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13];
    lfsr_c[10] = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[ 4] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14];
    lfsr_c[11] = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[ 5] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15];
    lfsr_c[12] = lfsr_q[2] ^ lfsr_q[4] ^ lfsr_q[ 6] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14];
    lfsr_c[13] = lfsr_q[3] ^ lfsr_q[5] ^ lfsr_q[ 7] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15];
    lfsr_c[14] = lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[ 8] ^ lfsr_q[14] ^ lfsr_q[15];
    lfsr_c[15] = lfsr_q[5] ^ lfsr_q[7] ^ lfsr_q[ 9] ^ lfsr_q[15];


    data_c[0]  = lfsr_q[15];
    data_c[1]  = lfsr_q[14];
    data_c[2]  = lfsr_q[13];
    data_c[3]  = lfsr_q[12];
    data_c[4]  = lfsr_q[11];
    data_c[5]  = lfsr_q[10];
    data_c[6]  = lfsr_q[ 9];
    data_c[7]  = lfsr_q[ 8];
    data_c[8]  = lfsr_q[ 7];
    data_c[9]  = lfsr_q[ 6];
    data_c[10] = lfsr_q[ 5];
    data_c[11] = lfsr_q[ 4] ^ lfsr_q[15];
    data_c[12] = lfsr_q[ 3] ^ lfsr_q[14] ^ lfsr_q[15];
    data_c[13] = lfsr_q[ 2] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15];
    data_c[14] = lfsr_q[ 1] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14];
    data_c[15] = lfsr_q[ 0] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13];
    data_c[16] = lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[15];
    data_c[17] = lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[14];
    data_c[18] = lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[13];
    data_c[19] = lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[12];
    data_c[20] = lfsr_q[ 6] ^ lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[11];
    data_c[21] = lfsr_q[ 5] ^ lfsr_q[ 6] ^ lfsr_q[ 7] ^ lfsr_q[10];
    data_c[22] = lfsr_q[ 4] ^ lfsr_q[ 5] ^ lfsr_q[ 6] ^ lfsr_q[ 9] ^ lfsr_q[15];
    data_c[23] = lfsr_q[ 3] ^ lfsr_q[ 4] ^ lfsr_q[ 5] ^ lfsr_q[ 8] ^ lfsr_q[14];
    data_c[24] = lfsr_q[ 2] ^ lfsr_q[ 3] ^ lfsr_q[ 4] ^ lfsr_q[ 7] ^ lfsr_q[13] ^ lfsr_q[15];
    data_c[25] = lfsr_q[ 1] ^ lfsr_q[ 2] ^ lfsr_q[ 3] ^ lfsr_q[ 6] ^ lfsr_q[12] ^ lfsr_q[14];
    data_c[26] = lfsr_q[ 0] ^ lfsr_q[ 1] ^ lfsr_q[ 2] ^ lfsr_q[ 5] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[15];
    data_c[27] = lfsr_q[ 0] ^ lfsr_q[ 1] ^ lfsr_q[ 4] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[14];
    data_c[28] = lfsr_q[ 0] ^ lfsr_q[ 3] ^ lfsr_q[ 9] ^ lfsr_q[11] ^ lfsr_q[13];
    data_c[29] = lfsr_q[ 2] ^ lfsr_q[ 8] ^ lfsr_q[10] ^ lfsr_q[12];
    data_c[30] = lfsr_q[ 1] ^ lfsr_q[ 7] ^ lfsr_q[ 9] ^ lfsr_q[11];
    data_c[31] = lfsr_q[ 0] ^ lfsr_q[ 6] ^ lfsr_q[ 8] ^ lfsr_q[10];
	
  end

  always @(posedge pclk or negedge reset_n) 
	begin
		if(!reset_n)
			lfsr_q <= 16'hFFFF;
		else
			lfsr_q <= lfsr_c ;
	end

  assign data_out = data_c;

endmodule
=======
module LFSR_32(scrambler_reset, reset_n, pclk, data_out);

  input scrambler_reset, reset_n, pclk;
  
  output wire [31:0] data_out;

  reg [15:0] lfsr_q, lfsr_c;
  reg [31:0] data_c;

  always @(*) begin
  
	if(scrambler_reset)
		lfsr_q = 16'hFFFF;

    lfsr_c[0]  = lfsr_q[0] ^ lfsr_q[6] ^ lfsr_q[ 8] ^ lfsr_q[10];
    lfsr_c[1]  = lfsr_q[1] ^ lfsr_q[7] ^ lfsr_q[ 9] ^ lfsr_q[11];
    lfsr_c[2]  = lfsr_q[2] ^ lfsr_q[8] ^ lfsr_q[10] ^ lfsr_q[12];
    lfsr_c[3]  = lfsr_q[3] ^ lfsr_q[6] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13];
    lfsr_c[4]  = lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14];
    lfsr_c[5]  = lfsr_q[5] ^ lfsr_q[6] ^ lfsr_q[ 7] ^ lfsr_q[ 9] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15];
    lfsr_c[6]  = lfsr_q[0] ^ lfsr_q[6] ^ lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[10] ^ lfsr_q[13] ^ lfsr_q[14];
    lfsr_c[7]  = lfsr_q[1] ^ lfsr_q[7] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[11] ^ lfsr_q[14] ^ lfsr_q[15];
    lfsr_c[8]  = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[15];
    lfsr_c[9]  = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[13];
    lfsr_c[10] = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[ 4] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[14];
    lfsr_c[11] = lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[ 5] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[15];
    lfsr_c[12] = lfsr_q[2] ^ lfsr_q[4] ^ lfsr_q[ 6] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14];
    lfsr_c[13] = lfsr_q[3] ^ lfsr_q[5] ^ lfsr_q[ 7] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15];
    lfsr_c[14] = lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[ 8] ^ lfsr_q[14] ^ lfsr_q[15];
    lfsr_c[15] = lfsr_q[5] ^ lfsr_q[7] ^ lfsr_q[ 9] ^ lfsr_q[15];


    data_c[0]  = lfsr_q[15];
    data_c[1]  = lfsr_q[14];
    data_c[2]  = lfsr_q[13];
    data_c[3]  = lfsr_q[12];
    data_c[4]  = lfsr_q[11];
    data_c[5]  = lfsr_q[10];
    data_c[6]  = lfsr_q[ 9];
    data_c[7]  = lfsr_q[ 8];
    data_c[8]  = lfsr_q[ 7];
    data_c[9]  = lfsr_q[ 6];
    data_c[10] = lfsr_q[ 5];
    data_c[11] = lfsr_q[ 4] ^ lfsr_q[15];
    data_c[12] = lfsr_q[ 3] ^ lfsr_q[14] ^ lfsr_q[15];
    data_c[13] = lfsr_q[ 2] ^ lfsr_q[13] ^ lfsr_q[14] ^ lfsr_q[15];
    data_c[14] = lfsr_q[ 1] ^ lfsr_q[12] ^ lfsr_q[13] ^ lfsr_q[14];
    data_c[15] = lfsr_q[ 0] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[13];
    data_c[16] = lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[12] ^ lfsr_q[15];
    data_c[17] = lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[11] ^ lfsr_q[14];
    data_c[18] = lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[10] ^ lfsr_q[13];
    data_c[19] = lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[ 9] ^ lfsr_q[12];
    data_c[20] = lfsr_q[ 6] ^ lfsr_q[ 7] ^ lfsr_q[ 8] ^ lfsr_q[11];
    data_c[21] = lfsr_q[ 5] ^ lfsr_q[ 6] ^ lfsr_q[ 7] ^ lfsr_q[10];
    data_c[22] = lfsr_q[ 4] ^ lfsr_q[ 5] ^ lfsr_q[ 6] ^ lfsr_q[ 9] ^ lfsr_q[15];
    data_c[23] = lfsr_q[ 3] ^ lfsr_q[ 4] ^ lfsr_q[ 5] ^ lfsr_q[ 8] ^ lfsr_q[14];
    data_c[24] = lfsr_q[ 2] ^ lfsr_q[ 3] ^ lfsr_q[ 4] ^ lfsr_q[ 7] ^ lfsr_q[13] ^ lfsr_q[15];
    data_c[25] = lfsr_q[ 1] ^ lfsr_q[ 2] ^ lfsr_q[ 3] ^ lfsr_q[ 6] ^ lfsr_q[12] ^ lfsr_q[14];
    data_c[26] = lfsr_q[ 0] ^ lfsr_q[ 1] ^ lfsr_q[ 2] ^ lfsr_q[ 5] ^ lfsr_q[11] ^ lfsr_q[13] ^ lfsr_q[15];
    data_c[27] = lfsr_q[ 0] ^ lfsr_q[ 1] ^ lfsr_q[ 4] ^ lfsr_q[10] ^ lfsr_q[12] ^ lfsr_q[14];
    data_c[28] = lfsr_q[ 0] ^ lfsr_q[ 3] ^ lfsr_q[ 9] ^ lfsr_q[11] ^ lfsr_q[13];
    data_c[29] = lfsr_q[ 2] ^ lfsr_q[ 8] ^ lfsr_q[10] ^ lfsr_q[12];
    data_c[30] = lfsr_q[ 1] ^ lfsr_q[ 7] ^ lfsr_q[ 9] ^ lfsr_q[11];
    data_c[31] = lfsr_q[ 0] ^ lfsr_q[ 6] ^ lfsr_q[ 8] ^ lfsr_q[10];
	
  end

  always @(posedge pclk or negedge reset_n) 
	begin
		if(!reset_n)
			lfsr_q <= 16'hFFFF;
		else
			lfsr_q <= lfsr_c ;
	end

  assign data_out = data_c;

endmodule

>>>>>>> 80143badf3492b3e7c783d04501d295c8ecae442
