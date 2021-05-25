module mainLTSSM #(parameter DEVICETYPE = 0)(
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
    input [3:0] gotoTx,
    input [3:0] gotoRx,
    input forceDetect,
    output reg linkUp,
    output [2:0] GEN,
    output [4:0] numberOfDetectedLanesOut,
    output [7:0] linkNumberOut,
    output [7:0] rateIdOut,
    output upConfigureCapabilityOut,
    output reg[3:0] lpifStateStatus,
    output reg[3:0] substateTx,
    output reg[3:0] substateRx    
);


//local signals
    reg [4:0] numberOfDetectedLanes;
    reg [7:0] linkNumber;
    reg [7:0] rateId;
    reg upConfigureCapability;
    reg [1:0]currentState,nextState;
    reg[3:0] substateTxnext,substateRxnext;

//Local parameters
    //LPIF STATES
    localparam[1:0]
        reset_   = 2'd0,
        active_  = 2'd1,
        retrain_ = 2'd2;

    //Tx/Rx LTSSM states
    localparam [3:0]
        detectQuiet =  4'd0,
        detectActive = 4'd1,
        pollingActive= 4'd2,
        pollingConfiguration= 4'd3,
        configurationLinkWidthStart = 4'd4,
        configurationLinkWidthAccept = 4'd5,
        configurationLanenumWait = 4'd6,
        configurationLanenumAccept = 4'd7,
        configurationComplete = 4'd8,
        configurationIdle = 4'd9,
        L0 = 4'd10;

    //Data resgiter handling
    always@(posedge clk)
    begin
        if(writeNumberOfDetectedLanes)numberOfDetectedLanes<=numberOfDetectedLanesIn;
        if(writeLinkNumber)linkNumber<=linkNumberIn;
        if(writeUpconfigureCapability)upConfigureCapability<=upConfigureCapabilityIn;
    end

    always @(posedge clk or negedge reset)
    begin
        if(!reset || forceDetect)
        begin
            currentState <= reset_;
            substateTx <= detectQuiet;
            substateRx <= detectQuiet;
            
        end
        else
        begin
            currentState <= nextState;
            substateTx <= substateTxnext;
            substateRx <= substateRxnext;
        end    
    end

//next LPIF state handling
    always @(*)
    begin
       case (currentState)
        reset_:
        begin
            if(finishTx&&finishRx&&gotoRx==L0&&gotoTx==L0&&lpifStateRequest==active_)
            begin
                nextState <= active_;
            end
        end
        active_:
        begin
            if(lpifStateRequest==reset_)
            begin
               nextState <= reset_; 
            end
            else if(lpifStateRequest==retrain_)
            begin
               nextState <= retrain_; 
            end
        end
        retrain_:
        begin
            //RECOVERY
        end 
        default:
            nextState <= reset_; 
       endcase 
        
    end


//output handling block
    always @(*)
    begin
       case (currentState)
        reset_:
        begin
            case ({substateTx,substateRx})
                {detectQuiet,detectQuiet}:
                begin
                   if (finishTx&&finishRx&&gotoTx==detectActive&&gotoRx==detectActive) 
                    begin
                        {substateTxnext,substateRxnext} = {detectActive,detectActive};
                        lpifStateStatus = reset_;
                    end 
                end
                
                {detectActive,detectActive}:
                begin
                    if (finishTx&&finishRx&&gotoTx==pollingActive&&gotoRx==pollingActive) 
                        begin
                            {substateTxnext,substateRxnext} = {pollingActive,pollingActive};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                end

                {pollingActive,pollingActive}:
                begin
                    if (finishTx&&finishRx&&gotoTx==pollingConfiguration&&gotoRx==pollingConfiguration) 
                        begin
                            {substateTxnext,substateRxnext}= {pollingConfiguration,pollingConfiguration};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                end
                {pollingConfiguration,pollingConfiguration}:
                begin
                    if (finishTx&&finishRx&&gotoTx==configurationLinkWidthStart&&gotoRx==configurationLinkWidthStart) 
                        begin
                            {substateTxnext,substateRxnext}= {configurationLinkWidthStart,configurationLinkWidthStart};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                end
                {configurationLinkWidthStart,configurationLinkWidthStart}:
                begin
                    if (finishRx&&gotoRx==configurationLinkWidthAccept) 
                        begin
                            {substateTxnext,substateRxnext}= {configurationLinkWidthAccept,configurationLinkWidthAccept};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                end
                {configurationLinkWidthAccept,configurationLinkWidthAccept}:
                begin
                    if (!DEVICETYPE&&finishTx&&gotoTx==configurationLanenumWait)//in downstream the Rx doesn't make any thing 
                        begin
                            {substateTxnext,substateRxnext}= {configurationLanenumWait,configurationLanenumWait};
                            lpifStateStatus = reset_;
                        end
                    else if (DEVICETYPE&&finishTx&&finishRx&&gotoTx==configurationLanenumWait&&gotoRx==configurationLanenumWait) 
                        begin
                            {substateTxnext,substateRxnext}= {configurationLanenumWait,configurationLanenumWait};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                end
                {configurationLanenumWait,configurationLanenumWait}:
                    if (finishRx&&gotoRx==configurationLanenumAccept) 
                        begin
                            {substateTxnext,substateRxnext}= {configurationLanenumAccept,configurationLanenumAccept};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                {configurationLanenumAccept,configurationLanenumAccept}:
                    if (finishRx&&gotoRx==configurationComplete) 
                        begin
                            {substateTxnext,substateRxnext}= {configurationComplete,configurationComplete};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                {configurationComplete,configurationComplete}:
                    if (finishRx&&gotoRx==configurationIdle&&finishTx&&gotoRx==configurationIdle) 
                        begin
                            {substateTxnext,substateRxnext}= {configurationIdle,configurationIdle};
                            lpifStateStatus = reset_;
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                {configurationIdle,configurationIdle}:
                    if (finishRx&&gotoRx==L0&&finishTx&&gotoRx==L0) 
                        begin
                            linkUp = 1'b1;
                            lpifStateStatus = reset_;
                            //{substateTx,substateRx} <= {L0,L0};//ERASE THE COMMENT IF I CAN GOT TO L0 WITHOUT LPIF PERMISSION
                        end
                    else if((finishTx&&gotoTx==detectQuiet)||(finishRx&&gotoRx==detectQuiet))
                        begin
                            {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                            lpifStateStatus = reset_;
                        end
                default:
                    begin
                        {substateTxnext,substateRxnext}= {detectQuiet,detectQuiet};
                        lpifStateStatus = reset_;
                        linkUp = 1'b0;
                    end
            
            endcase
        end
        active_:
        begin
            {substateTxnext,substateRxnext}= {L0,L0};
            lpifStateStatus = active_;
        end
        retrain_:
        begin
           lpifStateStatus = retrain_; //RECOVERY
        end 
        default:
            nextState = reset_;
       endcase 
        
    end




    assign{numberOfDetectedLanesOut,linkNumberOut,rateIdOut,upConfigureCapabilityOut} = {numberOfDetectedLanes,linkNumber,
    rateId,upConfigureCapability};
    
endmodule