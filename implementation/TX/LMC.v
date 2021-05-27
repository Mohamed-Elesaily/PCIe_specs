module LMC #(parameter pipe_width_gen1 = 8,
parameter pipe_width_gen2 = 16,
parameter pipe_width_gen3 = 16,
parameter pipe_width_gen4 = 32,
parameter pipe_width_gen5 = 32,
parameter number_of_lanes= 4
) (reset_n, pclk, generation, data_valid, data, d_k_in, PIPEWIDTH, data_valid_out_1, data_valid_out_2, data_valid_out_3, data_valid_out_4, data_valid_out_5, data_valid_out_6, data_valid_out_7, data_valid_out_8, data_valid_out_9, data_valid_out_10, data_valid_out_11, data_valid_out_12, data_valid_out_13, data_valid_out_14, data_valid_out_15, data_valid_out_16, d_k_out_1, d_k_out_2, d_k_out_3, d_k_out_4, d_k_out_5, d_k_out_6, d_k_out_7, d_k_out_8, d_k_out_9, d_k_out_10, d_k_out_11, d_k_out_12, d_k_out_13, d_k_out_14, d_k_out_15, d_k_out_16, dataout_1, dataout_2, dataout_3, dataout_4, dataout_5, dataout_6, dataout_7, dataout_8, dataout_9, dataout_10, dataout_11, dataout_12, dataout_13, dataout_14, dataout_15, dataout_16);



input reset_n, pclk;
input [2:0] generation;
input [63:0] data_valid;
input [511 : 0] data;
input [63:0] d_k_in;

output reg [3 : 0] data_valid_out_1, data_valid_out_2, data_valid_out_3, data_valid_out_4, data_valid_out_5, data_valid_out_6, data_valid_out_7, data_valid_out_8, data_valid_out_9, data_valid_out_10, data_valid_out_11, data_valid_out_12, data_valid_out_13, data_valid_out_14, data_valid_out_15, data_valid_out_16;
output reg [31 : 0] dataout_1, dataout_2, dataout_3, dataout_4, dataout_5, dataout_6, dataout_7, dataout_8, dataout_9, dataout_10, dataout_11, dataout_12, dataout_13, dataout_14, dataout_15, dataout_16;
output reg [3 : 0] d_k_out_1, d_k_out_2, d_k_out_3, d_k_out_4, d_k_out_5, d_k_out_6, d_k_out_7, d_k_out_8, d_k_out_9, d_k_out_10, d_k_out_11, d_k_out_12, d_k_out_13, d_k_out_14, d_k_out_15, d_k_out_16;
output reg [5:0] PIPEWIDTH;

reg [5:0] pipe_width;

always@(generation) begin
    if(generation==1)
        pipe_width = pipe_width_gen1; 
    else if (generation==2)
        pipe_width = pipe_width_gen2; 
    else if (generation==3)
        pipe_width = pipe_width_gen3; 
    else if (generation==4)
        pipe_width = pipe_width_gen4;                 
    else if (generation==5)
        pipe_width = pipe_width_gen5;

    PIPEWIDTH= pipe_width; 
end

always @(posedge pclk or negedge reset_n) begin
  if (~reset_n) begin
    dataout_1=0;
    dataout_2=0; 
    dataout_3=0;
    dataout_4=0; 
    dataout_5=0;
    dataout_6=0;
    dataout_7=0;
    dataout_8=0;
    dataout_9=0;
    dataout_10=0;
    dataout_11=0;
    dataout_12=0;
    dataout_13=0;
    dataout_14=0;
    dataout_15=0;
    dataout_16=0;

    d_k_out_1=0;
    d_k_out_2=0;
    d_k_out_3=0;
    d_k_out_4=0;
    d_k_out_5=0;
    d_k_out_6=0;
    d_k_out_7=0;
    d_k_out_8=0;
    d_k_out_9=0;
    d_k_out_10=0;
    d_k_out_11=0;
    d_k_out_12=0;
    d_k_out_13=0;
    d_k_out_14=0;
    d_k_out_15=0;
    d_k_out_16=0;

    data_valid_out_1=0;
    data_valid_out_2=0;
    data_valid_out_3=0;
    data_valid_out_4=0;
    data_valid_out_5=0;
    data_valid_out_6=0;
    data_valid_out_7=0;
    data_valid_out_8=0;
    data_valid_out_9=0;
    data_valid_out_10=0;
    data_valid_out_11=0;
    data_valid_out_12=0;
    data_valid_out_13=0;
    data_valid_out_14=0;
    data_valid_out_15=0;
    data_valid_out_16=0;

  end

 else if (data_valid[0] == 0) begin
    dataout_1=0;
    dataout_2=0; 
    dataout_3=0;
    dataout_4=0; 
    dataout_5=0;
    dataout_6=0;
    dataout_7=0;
    dataout_8=0;
    dataout_9=0;
    dataout_10=0;
    dataout_11=0;
    dataout_12=0;
    dataout_13=0;
    dataout_14=0;
    dataout_15=0;
    dataout_16=0;

    d_k_out_1=0;
    d_k_out_2=0;
    d_k_out_3=0;
    d_k_out_4=0;
    d_k_out_5=0;
    d_k_out_6=0;
    d_k_out_7=0;
    d_k_out_8=0;
    d_k_out_9=0;
    d_k_out_10=0;
    d_k_out_11=0;
    d_k_out_12=0;
    d_k_out_13=0;
    d_k_out_14=0;
    d_k_out_15=0;
    d_k_out_16=0;

    data_valid_out_1=0;
    data_valid_out_2=0;
    data_valid_out_3=0;
    data_valid_out_4=0;
    data_valid_out_5=0;
    data_valid_out_6=0;
    data_valid_out_7=0;
    data_valid_out_8=0;
    data_valid_out_9=0;
    data_valid_out_10=0;
    data_valid_out_11=0;
    data_valid_out_12=0;
    data_valid_out_13=0;
    data_valid_out_14=0;
    data_valid_out_15=0;
    data_valid_out_16=0;
  end


  else if (pipe_width == 8 && number_of_lanes == 1) begin
            if (data_valid[0] == 1) begin
                dataout_1= data[7:0];
                d_k_out_1= d_k_in;
                data_valid_out_1=data_valid;
            end
  end

  else if (pipe_width == 16 && number_of_lanes == 1) begin
            if (data_valid[1] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[15:8]};
                d_k_out_1= {d_k_in[0] , d_k_in[1]};
                data_valid_out_1= {data_valid[0] , data_valid[1]};                
            end
  end

  else if (pipe_width == 32 && number_of_lanes == 1) begin

            data_valid_out_1= {data_valid[0] , data_valid[1] , data_valid[2] , data_valid[3]}; 

            if(data_valid[3] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[15:8] , data[23:16] , data[31:24]};
                d_k_out_1= {d_k_in[0] , d_k_in[1] , d_k_in[2] , d_k_in[3]};                               
            end
            else if (data_valid[1] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0 };
                d_k_out_1= {d_k_in[0] , 3'b0 };
            end
            else if (data_valid[2] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[15:8] , 16'b0};
                d_k_out_1= {d_k_in[0] , d_k_in[1] , 2'b0};
            end
            else if (data_valid[3] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[15:8] , data[23:16] , 8'b0};
                d_k_out_1= {d_k_in[0] , d_k_in[1] , d_k_in[2] , 1'b0};
            end
  end    

  else if (pipe_width == 8 && number_of_lanes == 4) begin

                data_valid_out_1= data_valid[0];
                data_valid_out_2= data_valid[1];
                data_valid_out_3= data_valid[2];
                data_valid_out_4= data_valid[3];

            if( data_valid[3] == 1 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[32:24];

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
            end            
  end

  else if (pipe_width == 16 && number_of_lanes == 4) begin

                data_valid_out_1= {data_valid[0] , data_valid[4]};
                data_valid_out_2= {data_valid[1] , data_valid[5]};
                data_valid_out_3= {data_valid[2] , data_valid[6]};
                data_valid_out_4= {data_valid[3] , data_valid[7]};

            if( data_valid[7] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[39:32]};
                dataout_2= {data[15:8] , data[47:40]}; 
                dataout_3= {data[23:16] , data[55:48]};
                dataout_4= {data[31:24] , data[63:56]};

                d_k_out_1= {d_k_in[0] , d_k_in[4]};
                d_k_out_2= {d_k_in[1] , d_k_in[5]};
                d_k_out_3= {d_k_in[2] , d_k_in[6]};
                d_k_out_4= {d_k_in[3] , d_k_in[7]};
            end
            else if( data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] , 8'b0};
                dataout_4= {data[31:24] , 8'b0};

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
            end
  end

  else if (pipe_width == 32 && number_of_lanes == 4) begin

                data_valid_out_1= {data_valid[0] , data_valid[4] , data_valid[8] , data_valid[12]};
                data_valid_out_2= {data_valid[1] , data_valid[5] , data_valid[9] , data_valid[13]};
                data_valid_out_3= {data_valid[2] , data_valid[6] , data_valid[10] , data_valid[14]};
                data_valid_out_4= {data_valid[3] , data_valid[7] , data_valid[11] , data_valid[15]};

            if( data_valid[15] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[39:32] , data[71:64] , data[103:96]};
                dataout_2= {data[15:8] , data[47:40] , data[79:72] , data[111:104]}; 
                dataout_3= {data[23:16] , data[55:48] , data[87:80] , data[119:112]};
                dataout_4= {data[31:24] , data[63:56] , data[95:88] , data[127:120]};

                d_k_out_1= {d_k_in[0] , d_k_in[4] , d_k_in[8] , d_k_in[12]};
                d_k_out_2= {d_k_in[1] , d_k_in[5] , d_k_in[9] , d_k_in[13]};
                d_k_out_3= {d_k_in[2] , d_k_in[6] , d_k_in[10] , d_k_in[14]};
                d_k_out_4= {d_k_in[3] , d_k_in[7] , d_k_in[11] , d_k_in[15]};
            end      
            else if( data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
            end 
            else if( data_valid[8] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[39:32] , 16'b0};
                dataout_2= {data[15:8] , data[47:40] , 16'b0}; 
                dataout_3= {data[23:16] , data[55:48] , 16'b0};
                dataout_4= {data[31:24] , data[63:56] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[4] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[5] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[6] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[7] , 2'b0};
            end 
            else if( data_valid[12] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[39:32] , data[71:64] , 8'b0};
                dataout_2= {data[15:8] , data[47:40] , data[79:72] , 8'b0}; 
                dataout_3= {data[23:16] , data[55:48] , data[87:80] , 8'b0};
                dataout_4= {data[31:24] , data[63:56] , data[95:88] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[4] , d_k_in[8] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[5] , d_k_in[9] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[6] , d_k_in[10] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[7] , d_k_in[11] , 1'b0};
            end     
  end

  else if (pipe_width == 8 && number_of_lanes == 8) begin

                data_valid_out_1= data_valid[0];
                data_valid_out_2= data_valid[1];
                data_valid_out_3= data_valid[2];
                data_valid_out_4= data_valid[3];
                data_valid_out_5= data_valid[4];
                data_valid_out_6= data_valid[5];
                data_valid_out_7= data_valid[6];
                data_valid_out_8= data_valid[7];

            if(data_valid[7] == 1 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[31:24];
                dataout_5= data[39:32];
                dataout_6= data[47:40]; 
                dataout_7= data[55:48];
                dataout_8= data[63:56];

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
                d_k_out_5= d_k_in[4];
                d_k_out_6= d_k_in[5];
                d_k_out_7= d_k_in[6];
                d_k_out_8= d_k_in[7]; 
            end
            else if(data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[31:24];
                dataout_5= 0;
                dataout_6= 0; 
                dataout_7= 0;
                dataout_8= 0;

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
                d_k_out_5= 0;
                d_k_out_6= 0;
                d_k_out_7= 0;
                d_k_out_8= 0; 
            end
  end

  else if (pipe_width == 16 && number_of_lanes == 8) begin

                data_valid_out_1= {data_valid[0] , data_valid[8]};
                data_valid_out_2= {data_valid[1] , data_valid[9]};
                data_valid_out_3= {data_valid[2] , data_valid[10]};
                data_valid_out_4= {data_valid[3] , data_valid[11]};
                data_valid_out_5= {data_valid[4] , data_valid[12]};
                data_valid_out_6= {data_valid[5] , data_valid[13]};
                data_valid_out_7= {data_valid[6] , data_valid[14]};
                data_valid_out_8= {data_valid[7] , data_valid[15]};  

            if(data_valid[15] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64]};
                dataout_2= {data[15:8] , data[79:72]}; 
                dataout_3= {data[23:16] , data[87:80]};
                dataout_4= {data[31:24] , data[95:88]};
                dataout_5= {data[39:32] , data[103:96]};
                dataout_6= {data[47:40] , data[111:104]}; 
                dataout_7= {data[55:48] , data[119:112]};
                dataout_8= {data[63:56] , data[127:120]};

                d_k_out_1= {d_k_in[0] , d_k_in[8]};
                d_k_out_2= {d_k_in[1] , d_k_in[9]};
                d_k_out_3= {d_k_in[2] , d_k_in[10]};
                d_k_out_4= {d_k_in[3] , d_k_in[11]};
                d_k_out_5= {d_k_in[4] , d_k_in[12]};
                d_k_out_6= {d_k_in[5] , d_k_in[13]};
                d_k_out_7= {d_k_in[6] , d_k_in[14]};
                d_k_out_8= {d_k_in[7] , d_k_in[15]};                
            end
            else if(data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] , 8'b0};
                dataout_4= {data[31:24] , 8'b0};
                dataout_5= 0;
                dataout_6= 0; 
                dataout_7= 0;
                dataout_8= 0;

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
                d_k_out_5= 0;
                d_k_out_6= 0;
                d_k_out_7= 0;
                d_k_out_8= 0;                
            end
            else if(data_valid[8] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] , 8'b0};
                dataout_4= {data[31:24] , 8'b0};
                dataout_5= {data[39:32] , 8'b0};
                dataout_6= {data[47:40] , 8'b0}; 
                dataout_7= {data[55:48] , 8'b0};
                dataout_8= {data[63:56] , 8'b0};

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
                d_k_out_5= {d_k_in[4] , 1'b0};
                d_k_out_6= {d_k_in[5] , 1'b0};
                d_k_out_7= {d_k_in[6] , 1'b0};
                d_k_out_8= {d_k_in[7] , 1'b0};                
            end
            else if(data_valid[12] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64]};
                dataout_2= {data[15:8] , data[79:72]}; 
                dataout_3= {data[23:16] , data[87:80]};
                dataout_4= {data[31:24] , data[95:88]};
                dataout_5= {data[39:32] , 8'b0};
                dataout_6= {data[47:40] , 8'b0}; 
                dataout_7= {data[55:48] , 8'b0};
                dataout_8= {data[63:56] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[8]};
                d_k_out_2= {d_k_in[1] , d_k_in[9]};
                d_k_out_3= {d_k_in[2] , d_k_in[10]};
                d_k_out_4= {d_k_in[3] , d_k_in[11]};
                d_k_out_5= {d_k_in[4] , 1'b0};
                d_k_out_6= {d_k_in[5] , 1'b0};
                d_k_out_7= {d_k_in[6] , 1'b0};
                d_k_out_8= {d_k_in[7] , 1'b0};                
            end            
  end

  else if (pipe_width == 32 && number_of_lanes == 8) begin

                data_valid_out_1= {data_valid[0] , data_valid[8] , data_valid[16] , data_valid[24]};
                data_valid_out_2= {data_valid[1] , data_valid[9] , data_valid[17] , data_valid[25]};
                data_valid_out_3= {data_valid[2] , data_valid[10] , data_valid[18] , data_valid[26]};
                data_valid_out_4= {data_valid[3] , data_valid[11] , data_valid[19] , data_valid[27]};
                data_valid_out_5= {data_valid[4] , data_valid[12] , data_valid[20] , data_valid[28]};
                data_valid_out_6= {data_valid[5] , data_valid[13] , data_valid[21] , data_valid[29]};
                data_valid_out_7= {data_valid[6] , data_valid[14] , data_valid[22] , data_valid[30]};
                data_valid_out_8= {data_valid[7] , data_valid[15] , data_valid[23] , data_valid[31]};   

            if(data_valid[31] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0], data[71:64], data[135:128], data[199:192]};
                dataout_2= {data[15:8], data[79:72] , data[143:136] , data[207:200]}; 
                dataout_3= {data[23:16] , data[87:80] , data[151:144] , data[215:208]};
                dataout_4= {data[31:24] , data[95:88] , data[159:152] , data[223:216]};
                dataout_5= {data[39:32] , data[103:96] , data[167:160] , data[231:224]};
                dataout_6= {data[47:40] , data[111:104] , data[175:168] , data[239:232]}; 
                dataout_7= {data[55:48] , data[119:112] , data[183:176] , data[247:240]};
                dataout_8= {data[63:56] , data[127:120] , data[191:184] , data[255:248]};

                d_k_out_1= {d_k_in[0] , d_k_in[8] , d_k_in[16] , d_k_in[24]};
                d_k_out_2= {d_k_in[1] , d_k_in[9] , d_k_in[17] , d_k_in[25]};
                d_k_out_3= {d_k_in[2] , d_k_in[10] , d_k_in[18] , d_k_in[26]};
                d_k_out_4= {d_k_in[3] , d_k_in[11] , d_k_in[19] , d_k_in[27]};
                d_k_out_5= {d_k_in[4] , d_k_in[12] , d_k_in[20] , d_k_in[28]};
                d_k_out_6= {d_k_in[5] , d_k_in[13] , d_k_in[21] , d_k_in[29]};
                d_k_out_7= {d_k_in[6] , d_k_in[14] , d_k_in[22] , d_k_in[30]};
                d_k_out_8= {d_k_in[7] , d_k_in[15] , d_k_in[23] , d_k_in[31]};                 
            end
            else if(data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};
                dataout_5= 0;
                dataout_6= 0; 
                dataout_7= 0;
                dataout_8= 0;

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
                d_k_out_5= 0;
                d_k_out_6= 0;
                d_k_out_7= 0;
                d_k_out_8= 0;                 
            end             
            else if(data_valid[8] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};
                dataout_5= {data[39:32] , 24'b0};
                dataout_6= {data[47:40] , 24'b0}; 
                dataout_7= {data[55:48] , 24'b0};
                dataout_8= {data[63:56] , 24'b0};

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
                d_k_out_5= {d_k_in[4] , 3'b0};
                d_k_out_6= {d_k_in[5] , 3'b0};
                d_k_out_7= {d_k_in[6] , 3'b0};
                d_k_out_8= {d_k_in[7] , 3'b0};                 
            end
            else if(data_valid[12] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64] , 16'b0};
                dataout_2= {data[15:8] , data[79:72] , 16'b0}; 
                dataout_3= {data[23:16] , data[87:80] , 16'b0};
                dataout_4= {data[31:24] , data[95:88] , 16'b0};
                dataout_5= {data[39:32] , 24'b0};
                dataout_6= {data[47:40] , 24'b0}; 
                dataout_7= {data[55:48] , 24'b0};
                dataout_8= {data[63:56] , 24'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[8] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[9] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[10] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[11] , 2'b0};
                d_k_out_5= {d_k_in[4] , 3'b0};
                d_k_out_6= {d_k_in[5] , 3'b0};
                d_k_out_7= {d_k_in[6] , 3'b0};
                d_k_out_8= {d_k_in[7] , 3'b0};                 
            end              
            else if(data_valid[16] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64] , 16'b0};
                dataout_2= {data[15:8] , data[79:72] , 16'b0}; 
                dataout_3= {data[23:16] , data[87:80] , 16'b0};
                dataout_4= {data[31:24] , data[95:88] , 16'b0};
                dataout_5= {data[39:32] , data[103:96] , 16'b0};
                dataout_6= {data[47:40] , data[111:104] , 16'b0}; 
                dataout_7= {data[55:48] , data[119:112] , 16'b0};
                dataout_8= {data[63:56] , data[127:120] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[8] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[9] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[10] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[11] , 2'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[12] , 2'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[13] , 2'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[14] , 2'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[15] , 2'b0};                 
            end
            else if(data_valid[20] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64] , data[135:128] , 8'b0};
                dataout_2= {data[15:8] , data[79:72] , data[143:136] , 8'b0}; 
                dataout_3= {data[23:16] , data[87:80] , data[151:144] , 8'b0};
                dataout_4= {data[31:24] , data[95:88] , data[159:152] , 8'b0};
                dataout_5= {data[39:32] , data[103:96] , 16'b0};
                dataout_6= {data[47:40] , data[111:104] , 16'b0}; 
                dataout_7= {data[55:48] , data[119:112] , 16'b0};
                dataout_8= {data[63:56] , data[127:120] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[8] , d_k_in[16] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[9] , d_k_in[17] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[10] , d_k_in[18] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[11] , d_k_in[19] , 1'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[12] , 2'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[13] , 2'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[14] , 2'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[15] , 2'b0};                 
            end               
            else if(data_valid[24] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64] , data[135:128] , 8'b0};
                dataout_2= {data[15:8] , data[79:72] , data[143:136] , 8'b0}; 
                dataout_3= {data[23:16] , data[87:80] , data[151:144] , 8'b0};
                dataout_4= {data[31:24] , data[95:88] , data[159:152] , 8'b0};
                dataout_5= {data[39:32] , data[103:96] , data[167:160] , 8'b0};
                dataout_6= {data[47:40] , data[111:104] , data[175:168] , 8'b0}; 
                dataout_7= {data[55:48] , data[119:112] , data[183:176] , 8'b0};
                dataout_8= {data[63:56] , data[127:120] , data[191:184] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[8] , d_k_in[16] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[9] , d_k_in[17] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[10] , d_k_in[18] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[11] , d_k_in[19] , 1'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[12] , d_k_in[20] , 1'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[13] , d_k_in[21] , 1'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[14] , d_k_in[22] , 1'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[15] , d_k_in[23] , 1'b0};                 
            end 
            else if(data_valid[28] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[71:64] , data[135:128] , data[199:192]};
                dataout_2= {data[15:8] , data[79:72] , data[143:136] , data[207:200]}; 
                dataout_3= {data[23:16] , data[87:80] , data[151:144] , data[215:208]};
                dataout_4= {data[31:24] , data[95:88] , data[159:152] , data[223:216]};
                dataout_5= {data[39:32] , data[103:96] , data[167:160] , 8'b0};
                dataout_6= {data[47:40] , data[111:104] , data[175:168] , 8'b0}; 
                dataout_7= {data[55:48] , data[119:112] , data[183:176] , 8'b0};
                dataout_8= {data[63:56] , data[127:120] , data[191:184] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[8] , d_k_in[16] , d_k_in[24]};
                d_k_out_2= {d_k_in[1] , d_k_in[9] , d_k_in[17] , d_k_in[25]};
                d_k_out_3= {d_k_in[2] , d_k_in[10] , d_k_in[18] , d_k_in[26]};
                d_k_out_4= {d_k_in[3] , d_k_in[11] , d_k_in[19] , d_k_in[27]};
                d_k_out_5= {d_k_in[4] , d_k_in[12] , d_k_in[20] , 1'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[13] , d_k_in[21] , 1'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[14] , d_k_in[22] , 1'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[15] , d_k_in[23] , 1'b0};                 
            end 
  end

  else if (pipe_width == 8 && number_of_lanes == 16) begin

                data_valid_out_1= data_valid[0];
                data_valid_out_2= data_valid[1];
                data_valid_out_3= data_valid[2];
                data_valid_out_4= data_valid[3];
                data_valid_out_5= data_valid[4];
                data_valid_out_6= data_valid[5];
                data_valid_out_7= data_valid[6];
                data_valid_out_8= data_valid[7];
                data_valid_out_9= data_valid[8];
                data_valid_out_10= data_valid[9];
                data_valid_out_11= data_valid[10];
                data_valid_out_12= data_valid[11];
                data_valid_out_13= data_valid[12];
                data_valid_out_14= data_valid[13];
                data_valid_out_15= data_valid[14];
                data_valid_out_16= data_valid[15];

            if(data_valid[15] == 1 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[31:24];
                dataout_5= data[39:32];
                dataout_6= data[47:40]; 
                dataout_7= data[55:48];
                dataout_8= data[63:56];
                dataout_9= data[71:64];
                dataout_10= data[79:72]; 
                dataout_11= data[87:80];
                dataout_12= data[95:88];
                dataout_13= data[103:96];
                dataout_14= data[111:104]; 
                dataout_15= data[119:112];
                dataout_16= data[127:120];

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
                d_k_out_5= d_k_in[4];
                d_k_out_6= d_k_in[5];
                d_k_out_7= d_k_in[6];
                d_k_out_8= d_k_in[7];
                d_k_out_9= d_k_in[8];
                d_k_out_10= d_k_in[9];
                d_k_out_11= d_k_in[10];
                d_k_out_12= d_k_in[11];
                d_k_out_13= d_k_in[12];
                d_k_out_14= d_k_in[13];
                d_k_out_15= d_k_in[14];
                d_k_out_16= d_k_in[15];   
            end
            else if(data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[31:24];
                dataout_5= 0;
                dataout_6= 0; 
                dataout_7= 0;
                dataout_8= 0;
                dataout_9= 0;
                dataout_10= 0; 
                dataout_11= 0;
                dataout_12= 0;
                dataout_13= 0;
                dataout_14= 0; 
                dataout_15= 0;
                dataout_16= 0;

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
                d_k_out_5= 0;
                d_k_out_6= 0;
                d_k_out_7= 0;
                d_k_out_8= 0;
                d_k_out_9= 0;
                d_k_out_10= 0;
                d_k_out_11= 0;
                d_k_out_12= 0;
                d_k_out_13= 0;
                d_k_out_14= 0;
                d_k_out_15= 0;
                d_k_out_16= 0;   
            end            
            else if(data_valid[8] == 0 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[31:24];
                dataout_5= data[39:32];
                dataout_6= data[47:40]; 
                dataout_7= data[55:48];
                dataout_8= data[63:56];
                dataout_9= 0;
                dataout_10= 0; 
                dataout_11= 0;
                dataout_12= 0;
                dataout_13= 0;
                dataout_14= 0; 
                dataout_15= 0;
                dataout_16= 0;

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
                d_k_out_5= d_k_in[4];
                d_k_out_6= d_k_in[5];
                d_k_out_7= d_k_in[6];
                d_k_out_8= d_k_in[7];
                d_k_out_9= 0;
                d_k_out_10= 0;
                d_k_out_11= 0;
                d_k_out_12= 0;
                d_k_out_13= 0;
                d_k_out_14= 0;
                d_k_out_15= 0;
                d_k_out_16= 0;   
            end
            else if(data_valid[12] == 0 && data_valid[0] == 1) begin
                dataout_1= data[7:0];
                dataout_2= data[15:8]; 
                dataout_3= data[23:16];
                dataout_4= data[31:24];
                dataout_5= data[39:32];
                dataout_6= data[47:40]; 
                dataout_7= data[55:48];
                dataout_8= data[63:56];
                dataout_9= data[71:64];
                dataout_10= data[79:72]; 
                dataout_11= data[87:80];
                dataout_12= data[95:88];
                dataout_13= 0;
                dataout_14= 0; 
                dataout_15= 0;
                dataout_16= 0;

                d_k_out_1= d_k_in[0];
                d_k_out_2= d_k_in[1];
                d_k_out_3= d_k_in[2];
                d_k_out_4= d_k_in[3];
                d_k_out_5= d_k_in[4];
                d_k_out_6= d_k_in[5];
                d_k_out_7= d_k_in[6];
                d_k_out_8= d_k_in[7];
                d_k_out_9= d_k_in[8];
                d_k_out_10= d_k_in[9];
                d_k_out_11= d_k_in[10];
                d_k_out_12= d_k_in[11];
                d_k_out_13= 0;
                d_k_out_14= 0;
                d_k_out_15= 0;
                d_k_out_16= 0;   
            end

  end

  else if (pipe_width == 16 && number_of_lanes == 16) begin

                data_valid_out_1= {data_valid[0] , data_valid[16]};
                data_valid_out_2= {data_valid[1] , data_valid[17]};
                data_valid_out_3= {data_valid[2] , data_valid[18]};
                data_valid_out_4= {data_valid[3] , data_valid[19]};
                data_valid_out_5= {data_valid[4] , data_valid[20]};
                data_valid_out_6= {data_valid[5] , data_valid[21]};
                data_valid_out_7= {data_valid[6] , data_valid[22]};
                data_valid_out_8= {data_valid[7] , data_valid[23]};
                data_valid_out_9= {data_valid[8] , data_valid[24]};
                data_valid_out_10= {data_valid[9] , data_valid[25]};
                data_valid_out_11= {data_valid[10] , data_valid[26]};
                data_valid_out_12= {data_valid[11] , data_valid[27]};
                data_valid_out_13= {data_valid[12] , data_valid[28]};
                data_valid_out_14= {data_valid[13] , data_valid[29]};
                data_valid_out_15= {data_valid[14] , data_valid[30]};
                data_valid_out_16= {data_valid[15] , data_valid[31]}; 

            if(data_valid[31] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128]};
                dataout_2= {data[15:8] , data[143:136]}; 
                dataout_3= {data[23:16] , data[151:144]};
                dataout_4= {data[31:24] , data[159:152]};
                dataout_5= {data[39:32] , data[167:160]};
                dataout_6= {data[47:40] , data[175:168]}; 
                dataout_7= {data[55:48] , data[183:176]};
                dataout_8= {data[63:56] , data[191:184]};
                dataout_9= {data[71:64] , data[199:192]};
                dataout_10= {data[79:72] , data[207:200]}; 
                dataout_11= {data[87:80] , data[215:208]};
                dataout_12= {data[95:88] , data[223:216]};
                dataout_13= {data[103:96] , data[231:224]};
                dataout_14= {data[111:104] , data[239:232]};
                dataout_15= {data[119:112] , data[247:240]};
                dataout_16= {data[127:120] , data[255:248]};

                d_k_out_1= {d_k_in[0] , d_k_in[16]};
                d_k_out_2= {d_k_in[1] , d_k_in[17]};
                d_k_out_3= {d_k_in[2] , d_k_in[18]};
                d_k_out_4= {d_k_in[3] , d_k_in[19]};
                d_k_out_5= {d_k_in[4] , d_k_in[20]};
                d_k_out_6= {d_k_in[5] , d_k_in[21]};
                d_k_out_7= {d_k_in[6] , d_k_in[22]};
                d_k_out_8= {d_k_in[7] , d_k_in[23]};
                d_k_out_9= {d_k_in[8] , d_k_in[24]};
                d_k_out_10= {d_k_in[9] , d_k_in[25]};
                d_k_out_11= {d_k_in[10] , d_k_in[26]};
                d_k_out_12= {d_k_in[11] , d_k_in[27]};
                d_k_out_13= {d_k_in[12] , d_k_in[28]};
                d_k_out_14= {d_k_in[13] , d_k_in[29]};
                d_k_out_15= {d_k_in[14] , d_k_in[30]};
                d_k_out_16= {d_k_in[15] , d_k_in[31]};                
            end
           else if(data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] , 8'b0};
                dataout_4= {data[31:24] , 8'b0};
                dataout_5=  0;
                dataout_6=  0; 
                dataout_7=  0;
                dataout_8=  0;
                dataout_9=  0;
                dataout_10=  0; 
                dataout_11=  0;
                dataout_12=  0;
                dataout_13=  0;
                dataout_14=  0;
                dataout_15=  0;
                dataout_16=  0;

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
                d_k_out_5=  0;
                d_k_out_6=  0;
                d_k_out_7=  0;
                d_k_out_8=  0;
                d_k_out_9=  0;
                d_k_out_10=  0;
                d_k_out_11=  0;
                d_k_out_12=  0;
                d_k_out_13=  0;
                d_k_out_14=  0;
                d_k_out_15=  0;
                d_k_out_16=  0;                
            end             
            else if(data_valid[8] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] , 8'b0};
                dataout_4= {data[31:24] , 8'b0};
                dataout_5= {data[39:32] , 8'b0};
                dataout_6= {data[47:40] , 8'b0}; 
                dataout_7= {data[55:48] , 8'b0};
                dataout_8= {data[63:56] , 8'b0};
                dataout_9=  0;
                dataout_10=  0; 
                dataout_11=  0;
                dataout_12=  0;
                dataout_13=  0;
                dataout_14=  0;
                dataout_15=  0;
                dataout_16=  0;

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
                d_k_out_5= {d_k_in[4] , 1'b0};
                d_k_out_6= {d_k_in[5] , 1'b0};
                d_k_out_7= {d_k_in[6] , 1'b0};
                d_k_out_8= {d_k_in[7] , 1'b0};
                d_k_out_9=  0;
                d_k_out_10=  0;
                d_k_out_11=  0;
                d_k_out_12=  0;
                d_k_out_13=  0;
                d_k_out_14=  0;
                d_k_out_15=  0;
                d_k_out_16=  0;                
            end             
            else if(data_valid[12] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] , 8'b0};
                dataout_4= {data[31:24] , 8'b0};
                dataout_5= {data[39:32] , 8'b0};
                dataout_6= {data[47:40] , 8'b0}; 
                dataout_7= {data[55:48] , 8'b0};
                dataout_8= {data[63:56] , 8'b0};
                dataout_9= {data[71:64] , 8'b0};
                dataout_10= {data[79:72] , 8'b0}; 
                dataout_11= {data[87:80] , 8'b0};
                dataout_12= {data[95:88] , 8'b0};
                dataout_13=  0;
                dataout_14=  0;
                dataout_15=  0;
                dataout_16=  0;

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
                d_k_out_5= {d_k_in[4] , 1'b0};
                d_k_out_6= {d_k_in[5] , 1'b0};
                d_k_out_7= {d_k_in[6] , 1'b0};
                d_k_out_8= {d_k_in[7] , 1'b0};
                d_k_out_9= {d_k_in[8] , 1'b0};
                d_k_out_10= {d_k_in[9] , 1'b0};
                d_k_out_11= {d_k_in[10] , 1'b0};
                d_k_out_12= {d_k_in[11] , 1'b0};
                d_k_out_13=  0;
                d_k_out_14=  0;
                d_k_out_15=  0;
                d_k_out_16=  0;                
            end                        
            else if(data_valid[16] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 8'b0};
                dataout_2= {data[15:8] , 8'b0}; 
                dataout_3= {data[23:16] ,8'b0};
                dataout_4= {data[31:24] , 8'b0};
                dataout_5= {data[39:32] , 8'b0};
                dataout_6= {data[47:40] , 8'b0}; 
                dataout_7= {data[55:48] , 8'b0};
                dataout_8= {data[63:56] , 8'b0};
                dataout_9= {data[71:64] , 8'b0};
                dataout_10= {data[79:72] , 8'b0}; 
                dataout_11= {data[87:80] , 8'b0};
                dataout_12= {data[95:88] , 8'b0};
                dataout_13= {data[103:96] , 8'b0};
                dataout_14= {data[111:104] , 8'b0};
                dataout_15= {data[119:112] , 8'b0};
                dataout_16= {data[127:120] , 8'b0};

                d_k_out_1= {d_k_in[0] , 1'b0};
                d_k_out_2= {d_k_in[1] , 1'b0};
                d_k_out_3= {d_k_in[2] , 1'b0};
                d_k_out_4= {d_k_in[3] , 1'b0};
                d_k_out_5= {d_k_in[4] , 1'b0};
                d_k_out_6= {d_k_in[5] , 1'b0};
                d_k_out_7= {d_k_in[6] , 1'b0};
                d_k_out_8= {d_k_in[7] , 1'b0};
                d_k_out_9= {d_k_in[8] , 1'b0};
                d_k_out_10= {d_k_in[9] , 1'b0};
                d_k_out_11= {d_k_in[10] , 1'b0};
                d_k_out_12= {d_k_in[11] , 1'b0};
                d_k_out_13= {d_k_in[12] , 1'b0};
                d_k_out_14= {d_k_in[13] , 1'b0};
                d_k_out_15= {d_k_in[14] , 1'b0};
                d_k_out_16= {d_k_in[15] , 1'b0};                
            end            
            else if(data_valid[20] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128]};
                dataout_2= {data[15:8] , data[143:136]}; 
                dataout_3= {data[23:16] , data[151:144]};
                dataout_4= {data[31:24] , data[159:152]};
                dataout_5= {data[39:32] , 8'b0};
                dataout_6= {data[47:40] , 8'b0}; 
                dataout_7= {data[55:48] , 8'b0};
                dataout_8= {data[63:56] , 8'b0};
                dataout_9= {data[71:64] , 8'b0};
                dataout_10= {data[79:72] , 8'b0}; 
                dataout_11= {data[87:80] , 8'b0};
                dataout_12= {data[95:88] , 8'b0};
                dataout_13= {data[103:96] , 8'b0};
                dataout_14= {data[111:104] , 8'b0};
                dataout_15= {data[119:112] , 8'b0};
                dataout_16= {data[127:120] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16]};
                d_k_out_2= {d_k_in[1] , d_k_in[17]};
                d_k_out_3= {d_k_in[2] , d_k_in[18]};
                d_k_out_4= {d_k_in[3] , d_k_in[19]};
                d_k_out_5= {d_k_in[4] , 1'b0};
                d_k_out_6= {d_k_in[5] , 1'b0};
                d_k_out_7= {d_k_in[6] , 1'b0};
                d_k_out_8= {d_k_in[7] , 1'b0};
                d_k_out_9= {d_k_in[8] , 1'b0};
                d_k_out_10= {d_k_in[9] , 1'b0};
                d_k_out_11= {d_k_in[10] , 1'b0};
                d_k_out_12= {d_k_in[11] , 1'b0};
                d_k_out_13= {d_k_in[12] , 1'b0};
                d_k_out_14= {d_k_in[13] , 1'b0};
                d_k_out_15= {d_k_in[14] , 1'b0};
                d_k_out_16= {d_k_in[15] , 1'b0};                
            end                        
            else if(data_valid[24] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128]};
                dataout_2= {data[15:8] , data[143:136]}; 
                dataout_3= {data[23:16] , data[151:144]};
                dataout_4= {data[31:24] , data[159:152]};
                dataout_5= {data[39:32] , data[167:160]};
                dataout_6= {data[47:40] , data[175:168]}; 
                dataout_7= {data[55:48] , data[183:176]};
                dataout_8= {data[63:56] , data[191:184]};
                dataout_9= {data[71:64] ,8'b0};
                dataout_10= {data[79:72] , 8'b0}; 
                dataout_11= {data[87:80] , 8'b0};
                dataout_12= {data[95:88] , 8'b0};
                dataout_13= {data[103:96] , 8'b0};
                dataout_14= {data[111:104] , 8'b0};
                dataout_15= {data[119:112] , 8'b0};
                dataout_16= {data[127:120] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16]};
                d_k_out_2= {d_k_in[1] , d_k_in[17]};
                d_k_out_3= {d_k_in[2] , d_k_in[18]};
                d_k_out_4= {d_k_in[3] , d_k_in[19]};
                d_k_out_5= {d_k_in[4] , d_k_in[20]};
                d_k_out_6= {d_k_in[5] , d_k_in[21]};
                d_k_out_7= {d_k_in[6] , d_k_in[22]};
                d_k_out_8= {d_k_in[7] , d_k_in[23]};
                d_k_out_9= {d_k_in[8] , 1'b0};
                d_k_out_10= {d_k_in[9] , 1'b0};
                d_k_out_11= {d_k_in[10] , 1'b0};
                d_k_out_12= {d_k_in[11] , 1'b0};
                d_k_out_13= {d_k_in[12] , 1'b0};
                d_k_out_14= {d_k_in[13] , 1'b0};
                d_k_out_15= {d_k_in[14] , 1'b0};
                d_k_out_16= {d_k_in[15] , 1'b0};                
            end            
            else if(data_valid[28] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128]};
                dataout_2= {data[15:8] , data[143:136]}; 
                dataout_3= {data[23:16] , data[151:144]};
                dataout_4= {data[31:24] , data[159:152]};
                dataout_5= {data[39:32] , data[167:160]};
                dataout_6= {data[47:40] , data[175:168]}; 
                dataout_7= {data[55:48] , data[183:176]};
                dataout_8= {data[63:56] , data[191:184]};
                dataout_9= {data[71:64] , data[199:192]};
                dataout_10= {data[79:72] , data[207:200]}; 
                dataout_11= {data[87:80] , data[215:208]};
                dataout_12= {data[95:88] , data[223:216]};
                dataout_13= {data[103:96] , 8'b0};
                dataout_14= {data[111:104] , 8'b0};
                dataout_15= {data[119:112] , 8'b0};
                dataout_16= {data[127:120] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16]};
                d_k_out_2= {d_k_in[1] , d_k_in[17]};
                d_k_out_3= {d_k_in[2] , d_k_in[18]};
                d_k_out_4= {d_k_in[3] , d_k_in[19]};
                d_k_out_5= {d_k_in[4] , d_k_in[20]};
                d_k_out_6= {d_k_in[5] , d_k_in[21]};
                d_k_out_7= {d_k_in[6] , d_k_in[22]};
                d_k_out_8= {d_k_in[7] , d_k_in[23]};
                d_k_out_9= {d_k_in[8] , d_k_in[24]};
                d_k_out_10= {d_k_in[9] , d_k_in[25]};
                d_k_out_11= {d_k_in[10] , d_k_in[26]};
                d_k_out_12= {d_k_in[11] , d_k_in[27]};
                d_k_out_13= {d_k_in[12] , 1'b0};
                d_k_out_14= {d_k_in[13] , 1'b0};
                d_k_out_15= {d_k_in[14] , 1'b0};
                d_k_out_16= {d_k_in[15] , 1'b0};                
            end
  end

  else if (pipe_width == 32 && number_of_lanes == 16) begin

                data_valid_out_1= {data_valid[0] , data_valid[16] , data_valid[32] , data_valid[48]};
                data_valid_out_2= {data_valid[1] , data_valid[17] , data_valid[33] , data_valid[49]};
                data_valid_out_3= {data_valid[2] , data_valid[18] , data_valid[34] , data_valid[50]};
                data_valid_out_4= {data_valid[3] , data_valid[19] , data_valid[35] , data_valid[51]};
                data_valid_out_5= {data_valid[4] , data_valid[20] , data_valid[36] , data_valid[52]};
                data_valid_out_6= {data_valid[5] , data_valid[21] , data_valid[37] , data_valid[53]};
                data_valid_out_7= {data_valid[6] , data_valid[22] , data_valid[38] , data_valid[54]};
                data_valid_out_8= {data_valid[7] , data_valid[23] , data_valid[39] , data_valid[55]};
                data_valid_out_9= {data_valid[8] , data_valid[24] , data_valid[40] , data_valid[56]};
                data_valid_out_10= {data_valid[9] , data_valid[25] , data_valid[41] , data_valid[57]};
                data_valid_out_11= {data_valid[10] , data_valid[26] , data_valid[42] , data_valid[58]};
                data_valid_out_12= {data_valid[11] , data_valid[27] , data_valid[43] , data_valid[59]};
                data_valid_out_13= {data_valid[12] , data_valid[28] , data_valid[44] , data_valid[60]};
                data_valid_out_14= {data_valid[13] , data_valid[29] , data_valid[45] , data_valid[61]};
                data_valid_out_15= {data_valid[14] , data_valid[30] , data_valid[46] , data_valid[62]};
                data_valid_out_16= {data_valid[15] , data_valid[31] , data_valid[47] , data_valid[63]};
  
            if(data_valid[63] == 1 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , data[391:384]};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , data[399:392]}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , data[407:400]};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , data[415:408]};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , data[423:416]};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , data[431:424]}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , data[439:432]};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , data[447:440]};
                dataout_9= {data[71:64] , data[199:192] , data[327:320] , data[455:448]};
                dataout_10= {data[79:72] , data[207:200] , data[335:328] , data[463:456]}; 
                dataout_11= {data[87:80] , data[215:208] , data[343:336] , data[471:464]};
                dataout_12= {data[95:88] , data[223:216] , data[351:344] , data[479:472]};
                dataout_13= {data[103:96] , data[231:224] , data[359:352] , data[487:480]};
                dataout_14= {data[111:104] , data[239:232] , data[367:360] , data[495:488]}; 
                dataout_15= {data[119:112] , data[247:240] , data[375:368] , data[503:496]};
                dataout_16= {data[127:120] , data[255:248] , data[383:376] , data[511:504]};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , d_k_in[48]};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , d_k_in[49]};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , d_k_in[50]};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , d_k_in[51]};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , d_k_in[52]};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , d_k_in[53]};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , d_k_in[54]};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , d_k_in[55]};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , d_k_in[40] , d_k_in[56]};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , d_k_in[41] , d_k_in[57]};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , d_k_in[42] , d_k_in[58]};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , d_k_in[43] , d_k_in[59]};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , d_k_in[44] , d_k_in[60]};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , d_k_in[45] , d_k_in[61]};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , d_k_in[46] , d_k_in[62]};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , d_k_in[47] , d_k_in[63]};
            end
            else if(data_valid[4] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};
                dataout_5=  0;
                dataout_6=  0; 
                dataout_7=  0;
                dataout_8=  0;
                dataout_9=  0;
                dataout_10=  0; 
                dataout_11=  0;
                dataout_12=  0;
                dataout_13=  0;
                dataout_14=  0; 
                dataout_15=  0;
                dataout_16=  0;

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
                d_k_out_5=  0;
                d_k_out_6=  0;
                d_k_out_7=  0;
                d_k_out_8=  0;
                d_k_out_9=  0;
                d_k_out_10=  0;
                d_k_out_11=  0;
                d_k_out_12=  0;
                d_k_out_13=  0;
                d_k_out_14=  0;
                d_k_out_15=  0;
                d_k_out_16=  0;
            end
            else if(data_valid[8] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};
                dataout_5= {data[39:32] , 24'b0};
                dataout_6= {data[47:40] , 24'b0}; 
                dataout_7= {data[55:48] , 24'b0};
                dataout_8= {data[63:56] , 24'b0};
                dataout_9=  0;
                dataout_10=  0; 
                dataout_11=  0;
                dataout_12=  0;
                dataout_13=  0;
                dataout_14=  0; 
                dataout_15=  0;
                dataout_16=  0;

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
                d_k_out_5= {d_k_in[4] , 3'b0};
                d_k_out_6= {d_k_in[5] , 3'b0};
                d_k_out_7= {d_k_in[6] , 3'b0};
                d_k_out_8= {d_k_in[7] , 3'b0};
                d_k_out_9=  0;
                d_k_out_10=  0;
                d_k_out_11=  0;
                d_k_out_12=  0;
                d_k_out_13=  0;
                d_k_out_14=  0;
                d_k_out_15=  0;
                d_k_out_16=  0;
            end
            else if(data_valid[12] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};
                dataout_5= {data[39:32] , 24'b0};
                dataout_6= {data[47:40] , 24'b0}; 
                dataout_7= {data[55:48] , 24'b0};
                dataout_8= {data[63:56] , 24'b0};
                dataout_9= {data[71:64] , 24'b0};
                dataout_10= {data[79:72] , 24'b0}; 
                dataout_11= {data[87:80] , 24'b0};
                dataout_12= {data[95:88] , 24'b0};
                dataout_13=  0;
                dataout_14=  0; 
                dataout_15=  0;
                dataout_16=  0;

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
                d_k_out_5= {d_k_in[4] , 3'b0};
                d_k_out_6= {d_k_in[5] , 3'b0};
                d_k_out_7= {d_k_in[6] , 3'b0};
                d_k_out_8= {d_k_in[7] , 3'b0};
                d_k_out_9= {d_k_in[8] , 3'b0};
                d_k_out_10= {d_k_in[9] , 3'b0};
                d_k_out_11= {d_k_in[10] , 3'b0};
                d_k_out_12= {d_k_in[11] , 3'b0};
                d_k_out_13=  0;
                d_k_out_14=  0;
                d_k_out_15=  0;
                d_k_out_16=  0;
            end
            else if(data_valid[16] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , 24'b0};
                dataout_2= {data[15:8] , 24'b0}; 
                dataout_3= {data[23:16] , 24'b0};
                dataout_4= {data[31:24] , 24'b0};
                dataout_5= {data[39:32] , 24'b0};
                dataout_6= {data[47:40] , 24'b0}; 
                dataout_7= {data[55:48] , 24'b0};
                dataout_8= {data[63:56] , 24'b0};
                dataout_9= {data[71:64] , 24'b0};
                dataout_10= {data[79:72] , 24'b0}; 
                dataout_11= {data[87:80] , 24'b0};
                dataout_12= {data[95:88] , 24'b0};
                dataout_13= {data[103:96] , 24'b0};
                dataout_14= {data[111:104] , 24'b0}; 
                dataout_15= {data[119:112] , 24'b0};
                dataout_16= {data[127:120] , 24'b0};

                d_k_out_1= {d_k_in[0] , 3'b0};
                d_k_out_2= {d_k_in[1] , 3'b0};
                d_k_out_3= {d_k_in[2] , 3'b0};
                d_k_out_4= {d_k_in[3] , 3'b0};
                d_k_out_5= {d_k_in[4] , 3'b0};
                d_k_out_6= {d_k_in[5] , 3'b0};
                d_k_out_7= {d_k_in[6] , 3'b0};
                d_k_out_8= {d_k_in[7] , 3'b0};
                d_k_out_9= {d_k_in[8] , 3'b0};
                d_k_out_10= {d_k_in[9] , 3'b0};
                d_k_out_11= {d_k_in[10] , 3'b0};
                d_k_out_12= {d_k_in[11] , 3'b0};
                d_k_out_13= {d_k_in[12] , 3'b0};
                d_k_out_14= {d_k_in[13] , 3'b0};
                d_k_out_15= {d_k_in[14] , 3'b0};
                d_k_out_16= {d_k_in[15] , 3'b0};
            end
            else if(data_valid[20] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , 16'b0};
                dataout_2= {data[15:8] , data[143:136] ,16'b0}; 
                dataout_3= {data[23:16] , data[151:144] , 16'b0};
                dataout_4= {data[31:24] , data[159:152] , 16'b0};
                dataout_5= {data[39:32] , 24'b0};
                dataout_6= {data[47:40] , 24'b0}; 
                dataout_7= {data[55:48] , 24'b0};
                dataout_8= {data[63:56] , 24'b0};
                dataout_9= {data[71:64] , 24'b0};
                dataout_10= {data[79:72] , 24'b0}; 
                dataout_11= {data[87:80] , 24'b0};
                dataout_12= {data[95:88] , 24'b0};
                dataout_13= {data[103:96] , 24'b0};
                dataout_14= {data[111:104] , 24'b0}; 
                dataout_15= {data[119:112] , 24'b0};
                dataout_16= {data[127:120] , 24'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , 2'b0};
                d_k_out_5= {d_k_in[4] , 3'b0};
                d_k_out_6= {d_k_in[5] , 3'b0};
                d_k_out_7= {d_k_in[6] , 3'b0};
                d_k_out_8= {d_k_in[7] , 3'b0};
                d_k_out_9= {d_k_in[8] , 3'b0};
                d_k_out_10= {d_k_in[9] , 3'b0};
                d_k_out_11= {d_k_in[10] , 3'b0};
                d_k_out_12= {d_k_in[11] , 3'b0};
                d_k_out_13= {d_k_in[12] , 3'b0};
                d_k_out_14= {d_k_in[13] , 3'b0};
                d_k_out_15= {d_k_in[14] , 3'b0};
                d_k_out_16= {d_k_in[15] , 3'b0};
            end
            else if(data_valid[24] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , 16'b0};
                dataout_2= {data[15:8] , data[143:136] , 16'b0}; 
                dataout_3= {data[23:16] , data[151:144] , 16'b0};
                dataout_4= {data[31:24] , data[159:152] , 16'b0};
                dataout_5= {data[39:32] , data[167:160] , 16'b0};
                dataout_6= {data[47:40] , data[175:168] , 16'b0}; 
                dataout_7= {data[55:48] , data[183:176] , 16'b0};
                dataout_8= {data[63:56] , data[191:184] , 16'b0};
                dataout_9= {data[71:64] , 24'b0};
                dataout_10= {data[79:72] , 24'b0}; 
                dataout_11= {data[87:80] , 24'b0};
                dataout_12= {data[95:88] , 24'b0};
                dataout_13= {data[103:96] , 24'b0};
                dataout_14= {data[111:104] , 24'b0}; 
                dataout_15= {data[119:112] , 24'b0};
                dataout_16= {data[127:120] , 24'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , 2'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , 2'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , 2'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , 2'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , 2'b0};
                d_k_out_9= {d_k_in[8] , 3'b0};
                d_k_out_10= {d_k_in[9] , 3'b0};
                d_k_out_11= {d_k_in[10] , 3'b0};
                d_k_out_12= {d_k_in[11] , 3'b0};
                d_k_out_13= {d_k_in[12] , 3'b0};
                d_k_out_14= {d_k_in[13] , 3'b0};
                d_k_out_15= {d_k_in[14] , 3'b0};
                d_k_out_16= {d_k_in[15] , 3'b0};
            end
            else if(data_valid[28] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , 16'b0};
                dataout_2= {data[15:8] , data[143:136] , 16'b0}; 
                dataout_3= {data[23:16] , data[151:144] , 16'b0};
                dataout_4= {data[31:24] , data[159:152] , 16'b0};
                dataout_5= {data[39:32] , data[167:160] , 16'b0};
                dataout_6= {data[47:40] , data[175:168] , 16'b0}; 
                dataout_7= {data[55:48] , data[183:176] , 16'b0};
                dataout_8= {data[63:56] , data[191:184] , 16'b0};
                dataout_9= {data[71:64] , data[199:192] , 16'b0};
                dataout_10= {data[79:72] , data[207:200] , 16'b0}; 
                dataout_11= {data[87:80] , data[215:208] , 16'b0};
                dataout_12= {data[95:88] , data[223:216] , 16'b0};
                dataout_13= {data[103:96] , 24'b0};
                dataout_14= {data[111:104] , 24'b0}; 
                dataout_15= {data[119:112] , 24'b0};
                dataout_16= {data[127:120] , 24'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , 2'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , 2'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , 2'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , 2'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , 2'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , 2'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , 2'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , 2'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , 2'b0};
                d_k_out_13= {d_k_in[12] , 3'b0};
                d_k_out_14= {d_k_in[13] , 3'b0};
                d_k_out_15= {d_k_in[14] , 3'b0};
                d_k_out_16= {d_k_in[15] , 3'b0};
            end
            else if(data_valid[32] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , 16'b0};
                dataout_2= {data[15:8] , data[143:136] , 16'b0}; 
                dataout_3= {data[23:16] , data[151:144] , 16'b0};
                dataout_4= {data[31:24] , data[159:152] , 16'b0};
                dataout_5= {data[39:32] , data[167:160] , 16'b0};
                dataout_6= {data[47:40] , data[175:168] , 16'b0}; 
                dataout_7= {data[55:48] , data[183:176] , 16'b0};
                dataout_8= {data[63:56] , data[191:184] , 16'b0};
                dataout_9= {data[71:64] , data[199:192] , 16'b0};
                dataout_10= {data[79:72] , data[207:200] , 16'b0}; 
                dataout_11= {data[87:80] , data[215:208] , 16'b0};
                dataout_12= {data[95:88] , data[223:216] , 16'b0};
                dataout_13= {data[103:96] , data[231:224] , 16'b0};
                dataout_14= {data[111:104] , data[239:232] , 16'b0}; 
                dataout_15= {data[119:112] , data[247:240] , 16'b0};
                dataout_16= {data[127:120] , data[255:248] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , 2'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , 2'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , 2'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , 2'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , 2'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , 2'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , 2'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , 2'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , 2'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , 2'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , 2'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , 2'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , 2'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , 2'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , 2'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , 2'b0};
            end 
            else if(data_valid[36] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , 8'b0};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , 8'b0}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , 8'b0};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , 8'b0};
                dataout_5= {data[39:32] , data[167:160] , 16'b0};
                dataout_6= {data[47:40] , data[175:168] , 16'b0}; 
                dataout_7= {data[55:48] , data[183:176] , 16'b0};
                dataout_8= {data[63:56] , data[191:184] , 16'b0};
                dataout_9= {data[71:64] , data[199:192] , 16'b0};
                dataout_10= {data[79:72] , data[207:200] , 16'b0}; 
                dataout_11= {data[87:80] , data[215:208] , 16'b0};
                dataout_12= {data[95:88] , data[223:216] , 16'b0};
                dataout_13= {data[103:96] , data[231:224] , 16'b0};
                dataout_14= {data[111:104] , data[239:232] , 16'b0}; 
                dataout_15= {data[119:112] , data[247:240] , 16'b0};
                dataout_16= {data[127:120] , data[255:248] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , 1'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , 2'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , 2'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , 2'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , 2'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , 2'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , 2'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , 2'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , 2'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , 2'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , 2'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , 2'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , 2'b0};
            end            
            else if(data_valid[40] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , 8'b0};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , 8'b0}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , 8'b0};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , 8'b0};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , 8'b0};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , 8'b0}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , 8'b0};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , 8'b0};
                dataout_9= {data[71:64] , data[199:192] , 16'b0};
                dataout_10= {data[79:72] , data[207:200] , 16'b0}; 
                dataout_11= {data[87:80] , data[215:208] , 16'b0};
                dataout_12= {data[95:88] , data[223:216] , 16'b0};
                dataout_13= {data[103:96] , data[231:224] , 16'b0};
                dataout_14= {data[111:104] , data[239:232] , 16'b0}; 
                dataout_15= {data[119:112] , data[247:240] , 16'b0};
                dataout_16= {data[127:120] , data[255:248] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , 1'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , 1'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , 1'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , 1'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , 1'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , 2'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , 2'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , 2'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , 2'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , 2'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , 2'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , 2'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , 2'b0};
            end
            else if(data_valid[44] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , 8'b0};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , 8'b0}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , 8'b0};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , 8'b0};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , 8'b0};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , 8'b0}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , 8'b0};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , 8'b0};
                dataout_9= {data[71:64] , data[199:192] , data[327:320] , 8'b0};
                dataout_10= {data[79:72] , data[207:200] , data[335:328] , 8'b0}; 
                dataout_11= {data[87:80] , data[215:208] , data[343:336] , 8'b0};
                dataout_12= {data[95:88] , data[223:216] , data[351:344] , 8'b0};
                dataout_13= {data[103:96] , data[231:224] , 16'b0};
                dataout_14= {data[111:104] , data[239:232] , 16'b0}; 
                dataout_15= {data[119:112] , data[247:240] , 16'b0};
                dataout_16= {data[127:120] , data[255:248] , 16'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , 1'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , 1'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , 1'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , 1'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , 1'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , d_k_in[40] , 1'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , d_k_in[41] , 1'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , d_k_in[42] , 1'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , d_k_in[43] , 1'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , 2'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , 2'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , 2'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , 2'b0};
            end
            else if(data_valid[48] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , 8'b0};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , 8'b0}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , 8'b0};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , 8'b0};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , 8'b0};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , 8'b0}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , 8'b0};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , 8'b0};
                dataout_9= {data[71:64] , data[199:192] , data[327:320] , 8'b0};
                dataout_10= {data[79:72] , data[207:200] , data[335:328] , 8'b0}; 
                dataout_11= {data[87:80] , data[215:208] , data[343:336] , 8'b0};
                dataout_12= {data[95:88] , data[223:216] , data[351:344] , 8'b0};
                dataout_13= {data[103:96] , data[231:224] , data[359:352] , 8'b0};
                dataout_14= {data[111:104] , data[239:232] , data[367:360] , 8'b0}; 
                dataout_15= {data[119:112] , data[247:240] , data[375:368] , 8'b0};
                dataout_16= {data[127:120] , data[255:248] , data[383:376] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , 1'b0};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , 1'b0};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , 1'b0};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , 1'b0};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , 1'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , 1'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , 1'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , 1'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , d_k_in[40] , 1'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , d_k_in[41] , 1'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , d_k_in[42] , 1'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , d_k_in[43] , 1'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , d_k_in[44] , 1'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , d_k_in[45] , 1'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , d_k_in[46] , 1'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , d_k_in[47] , 1'b0};
            end            
            else if(data_valid[52] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , data[391:384]};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , data[399:392]}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , data[407:400]};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , data[415:408]};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , 8'b0};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , 8'b0}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , 8'b0};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , 8'b0};
                dataout_9= {data[71:64] , data[199:192] , data[327:320] , 8'b0};
                dataout_10= {data[79:72] , data[207:200] , data[335:328] , 8'b0}; 
                dataout_11= {data[87:80] , data[215:208] , data[343:336] , 8'b0};
                dataout_12= {data[95:88] , data[223:216] , data[351:344] , 8'b0};
                dataout_13= {data[103:96] , data[231:224] , data[359:352] , 8'b0};
                dataout_14= {data[111:104] , data[239:232] , data[367:360] , 8'b0}; 
                dataout_15= {data[119:112] , data[247:240] , data[375:368] , 8'b0};
                dataout_16= {data[127:120] , data[255:248] , data[383:376] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , d_k_in[48]};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , d_k_in[49]};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , d_k_in[50]};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , d_k_in[51]};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , 1'b0};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , 1'b0};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , 1'b0};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , 1'b0};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , d_k_in[40] , 1'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , d_k_in[41] , 1'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , d_k_in[42] , 1'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , d_k_in[43] , 1'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , d_k_in[44] , 1'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , d_k_in[45] , 1'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , d_k_in[46] , 1'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , d_k_in[47] , 1'b0};
            end                          
            else if(data_valid[56] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , data[391:384]};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , data[399:392]}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , data[407:400]};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , data[415:408]};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , data[423:416]};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , data[431:424]}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , data[439:432]};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , data[447:440]};
                dataout_9= {data[71:64] , data[199:192] , data[327:320] , 8'b0};
                dataout_10= {data[79:72] , data[207:200] , data[335:328] , 8'b0}; 
                dataout_11= {data[87:80] , data[215:208] , data[343:336] , 8'b0};
                dataout_12= {data[95:88] , data[223:216] , data[351:344] , 8'b0};
                dataout_13= {data[103:96] , data[231:224] , data[359:352] , 8'b0};
                dataout_14= {data[111:104] , data[239:232] , data[367:360] , 8'b0}; 
                dataout_15= {data[119:112] , data[247:240] , data[375:368] , 8'b0};
                dataout_16= {data[127:120] , data[255:248] , data[383:376] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , d_k_in[48]};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , d_k_in[49]};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , d_k_in[50]};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , d_k_in[51]};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , d_k_in[52]};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , d_k_in[53]};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , d_k_in[54]};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , d_k_in[55]};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , d_k_in[40] , 1'b0};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , d_k_in[41] , 1'b0};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , d_k_in[42] , 1'b0};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , d_k_in[43] , 1'b0};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , d_k_in[44] , 1'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , d_k_in[45] , 1'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , d_k_in[46] , 1'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , d_k_in[47] , 1'b0};
            end              
            else if(data_valid[60] == 0 && data_valid[0] == 1) begin
                dataout_1= {data[7:0] , data[135:128] , data[263:256] , data[391:384]};
                dataout_2= {data[15:8] , data[143:136] , data[271:264] , data[399:392]}; 
                dataout_3= {data[23:16] , data[151:144] , data[279:272] , data[407:400]};
                dataout_4= {data[31:24] , data[159:152] , data[287:280] , data[415:408]};
                dataout_5= {data[39:32] , data[167:160] , data[295:288] , data[423:416]};
                dataout_6= {data[47:40] , data[175:168] , data[303:296] , data[431:424]}; 
                dataout_7= {data[55:48] , data[183:176] , data[311:304] , data[439:432]};
                dataout_8= {data[63:56] , data[191:184] , data[319:312] , data[447:440]};
                dataout_9= {data[71:64] , data[199:192] , data[327:320] , data[455:448]};
                dataout_10= {data[79:72] , data[207:200] , data[335:328] , data[463:456]}; 
                dataout_11= {data[87:80] , data[215:208] , data[343:336] , data[471:464]};
                dataout_12= {data[95:88] , data[223:216] , data[351:344] , data[479:472]};
                dataout_13= {data[103:96] , data[231:224] , data[359:352] , 8'b0};
                dataout_14= {data[111:104] , data[239:232] , data[367:360] , 8'b0}; 
                dataout_15= {data[119:112] , data[247:240] , data[375:368] , 8'b0};
                dataout_16= {data[127:120] , data[255:248] , data[383:376] , 8'b0};

                d_k_out_1= {d_k_in[0] , d_k_in[16] , d_k_in[32] , d_k_in[48]};
                d_k_out_2= {d_k_in[1] , d_k_in[17] , d_k_in[33] , d_k_in[49]};
                d_k_out_3= {d_k_in[2] , d_k_in[18] , d_k_in[34] , d_k_in[50]};
                d_k_out_4= {d_k_in[3] , d_k_in[19] , d_k_in[35] , d_k_in[51]};
                d_k_out_5= {d_k_in[4] , d_k_in[20] , d_k_in[36] , d_k_in[52]};
                d_k_out_6= {d_k_in[5] , d_k_in[21] , d_k_in[37] , d_k_in[53]};
                d_k_out_7= {d_k_in[6] , d_k_in[22] , d_k_in[38] , d_k_in[54]};
                d_k_out_8= {d_k_in[7] , d_k_in[23] , d_k_in[39] , d_k_in[55]};
                d_k_out_9= {d_k_in[8] , d_k_in[24] , d_k_in[40] , d_k_in[56]};
                d_k_out_10= {d_k_in[9] , d_k_in[25] , d_k_in[41] , d_k_in[57]};
                d_k_out_11= {d_k_in[10] , d_k_in[26] , d_k_in[42] , d_k_in[58]};
                d_k_out_12= {d_k_in[11] , d_k_in[27] , d_k_in[43] , d_k_in[59]};
                d_k_out_13= {d_k_in[12] , d_k_in[28] , d_k_in[44] , 1'b0};
                d_k_out_14= {d_k_in[13] , d_k_in[29] , d_k_in[45] , 1'b0};
                d_k_out_15= {d_k_in[14] , d_k_in[30] , d_k_in[46] , 1'b0};
                d_k_out_16= {d_k_in[15] , d_k_in[31] , d_k_in[47] , 1'b0};
            end            
  end
end

endmodule

