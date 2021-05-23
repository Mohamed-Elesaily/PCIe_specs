module mainLTSSM (
    input clk,
    input reset,
    input [3:0] lpifStateRequest,
    input [4:0] numberOfDetectedLanesIn,
    input [7:0] linkNumberIn,
    input [7:0] rateIdIn,
    input upConfigureCapabilityIn,
    input writeNumberOfDetectedLanes,
    input writeLinkNumber,
    input writeUpconfigureCapability,
    input writeRateId,
    input finishTx,
    input finishRx,
    output [2:0] GEN,
    output [4:0] numberOfDetectedLanesOut,
    output [7:0] linkNumberOut,
    output [7:0] rateIdOut,
    output upConfigureCapabilityOut,
    output [3:0] lpifStateStatus,
    output [3:0] substateTx,
    output [3:0] substateRx
);


//local signals
    reg [4:0] numberOfDetectedLanes;
    reg [7:0] linkNumber;
    reg [7:0] rateId;
    reg upConfigureCapability;

    always@(posedge clk)
    begin
        if(writeNumberOfDetectedLanes)numberOfDetectedLanes<=numberOfDetectedLanesIn;
        if(writeLinkNumber)linkNumber<=linkNumberIn;
        if(writeUpconfigureCapability)upConfigureCapability<=upConfigureCapabilityIn;
    end


    assign{numberOfDetectedLanesOut,linkNumberOut,rateIdOut,upConfigureCapabilityOut} = {numberOfDetectedLanes,linkNumber,
    rateId,upConfigureCapability};
    
endmodule