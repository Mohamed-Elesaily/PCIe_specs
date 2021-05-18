module RxLTSSM #(parameter DEVICETYPE=0) (
input clk,
input reset,
input [2047:0] orderedSets,
input [4:0]numberOfDetectedLanes,
input [3:0]substate,
input [7:0]linkNumber,
input forceDetect,
input rxElectricalIdle,
input validOrderedSets,
output [7:0] rateId,
output upConfigureCapability,
output finish,
output [3:0]exitTo,
output linkUp,
output witeUpconfigureCapability,
output writerateid,
output disableDescrambler
);

wire [15:0]resetOsCheckers;
wire [15:0]countUp,resetCounters;
wire [127:0]rateIds;
wire [15:0]upConfigurebits;
wire [79:0]countersValues;
wire [4:0] checkValues;
wire [15:0]comparisonValues;
wire  enableTimer,resetTimer,timeOut;
wire [5:0]setTimer;


genvar i;
generate
   for (i=0; i <= 15; i=i+1) 
   begin
     osChecker #(.DEVICETYPE(DEVICETYPE))osChecker( 
     clk,
     linkNumber,
     i[7:0],
     orderedSets[(i*128)+127:i*128],
     validOrderedSets,
     substate,
     resetOsCheckers[i],
     countUp[i],
     resetCounters[i],
     rateIds[(i*8)+7:i*8],
     upConfigurebits[i]);

     counter counter(
     resetCounters[i],
     clk,
     countUp[i],
     countersValues[(i*5)+4:i*5]);

     comparator comparator(
     countersValues[(i*5)+4:i*5],
     checkValues,
     comparisonValues[i]);

     
   end
endgenerate


masterRxLTSSM masterRxLTSSM(
    clk,
    numberOfDetectedLanes,
    substate,
    comparisonValues,
    forceDetect,
    rxElectricalIdle,
    timeOut,
    reset,
    finish,
    exitTo,
    resetOsCheckers,
    disableDescrambler,
    setTimer,
    enableTimer,
    resetTimer,
    checkValues);

timer timer(clk,setTimer,enableTimer,resetTimer,timeOut);


assign writerateid= (finish &&(exitTo == 4'd4|| exitTo == 4'd9))? 1'b1 : 1'b0;
assign witeUpconfigureCapability=(finish &&(exitTo == 4'd4|| exitTo == 4'd9))? 1'b1 : 1'b0;
assign {rateId,upConfigureCapability} = {rateIds[7:0],upConfigurebits[0]};
assign linkUp = (substate == 4'd10)? 1'b1 : 1'b0;
endmodule