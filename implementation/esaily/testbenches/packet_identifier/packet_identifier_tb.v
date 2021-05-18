module packet_identifier_tb();

reg [511:0]Data_in;
reg valid_pd;
reg linkup;
reg [63:0]DK;
reg [2:0]gen;

wire [511:0]Data_out;

wire w;
wire [63:0]pl_valid     ;
wire [63:0]pl_dlpstart  ;
wire [63:0]pl_dlpend    ;
wire [63:0]pl_tlpstart  ;
wire [63:0]pl_tlpedb    ;
wire [63:0]pl_tlpend    ;
// localparam p1 = 64'hFB_1234_FD_5C_12_FD_12;
packet_identifier DUT(


    .data_in(Data_in),
    .valid_pd(valid_pd),
    .gen(gen),
    .linkup(linkup),
    .DK(DK),

    .data_out(Data_out),
    .pl_valid   (pl_valid   ),
    .pl_dlpstart(pl_dlpstart),
    .pl_dlpend  (pl_dlpend  ),
    .pl_tlpstart(pl_tlpstart),
    .pl_tlpedb  (pl_tlpedb  ),
    .pl_tlpend  (pl_tlpend  ),
    
    
    .w(w)
  
);
localparam padding = {384{1'b0}};
localparam padding_dk = {48{1'b0}};
localparam p1 = 128'hFD_1234560067657349890324043244_FB;
localparam p2 = 128'h67_1234560067657349890324043244_78; //long packet
localparam p2_2 = 128'h67_1234560676F5F5F5_FD_3024043244_35; // end p2 ,pad and not packet data

localparam DK2 =16'h1;


localparam DK2_2 =16'h0F40;

localparam DK1 = 16'h1_00_1;
initial begin
gen = 3'b000;valid_pd=0;linkup=0;DK=0;Data_in=0;
#10
valid_pd=1;linkup=1;DK=0;Data_in=0;
#10
DK=DK1;Data_in=p1;
#10
DK=DK2;Data_in=p2;
#10
DK=DK2_2;Data_in=p2_2;
#10
DK=0;Data_in=0;
#10
    $stop;
end












endmodule