module GenDataPath_tb();
reg [511:0]data_in;
reg [63:0]DK;
reg [63:0]valid;
wire [511:0]data_out;

wire [63:0]dlpstart1; 
wire [63:0]dlpend1  ; 
wire [63:0]tlpstart1; 
wire [63:0]tlpedb1  ; 
wire [63:0]tlpend1  ; 
wire [63:0]valid_d;
Gen1_2_DataPath DUT(
    .Data_in(data_in),
    .DK(DK),
    .valid(valid),
    
    .Data_out(data_out),
    .dlpstart (dlpstart1),
    .dlpend   (dlpend1  ),
    .tlpstart (tlpstart1),
    .tlpedb   (tlpedb1  ),
    .tlpend   (tlpend1  ),
    .valid_d  (valid_d)  

);
// data boundries
    localparam STP = 8'b111_11011 ;
    localparam SDP = 8'b010_11100 ;
    localparam END = 8'b111_11101 ;
    localparam EDB = 8'b111_11110 ;
    localparam PAD = 8'b111_10111;

// types
    localparam data = 3'b000;
    localparam  not_valid = 3'b111;
    localparam tlpstart = 3'b001 ;
    localparam tlpend = 3'b010 ;
    localparam dllpend = 3'b100 ;
    localparam dllpstart = 3'b011 ;
    localparam tlpedb = 3'b101 ;
// 
    localparam tlp = 2'b01;
    localparam dllp = 2'b10;
    localparam not_valid_data = 2'b00 ;
 

initial begin
  DK    = 0;
  valid = 0;
  data_in=0;
  #10
   DK    =1;valid = 64'hfff0000000ffffff;data_in=STP;
  #10
 DK    =0;valid = 64'hff000000000ffff;data_in=8;
  #10
 DK    =1;valid = 64'hffff000000ffff;data_in=END;

  #10
   DK    =1;valid = 64'hfff0000000ffffff;data_in=SDP;
  #10
 DK    =0;valid = 64'hffffff;data_in=8;
  #10
 DK    =1;valid = 64'hffff000000ffff;data_in=END;
  #10

$stop();

end

endmodule