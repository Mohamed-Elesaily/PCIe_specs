module mainLTSSM  #(
parameter MAX_GEN = 5;
parameter DEVICETYPE=0,
parameter Width = 32,
parameter GEN1_PIPEWIDTH = 8 ,	
parameter GEN2_PIPEWIDTH = 8 ,	
parameter GEN3_PIPEWIDTH = 8 ,	
parameter GEN4_PIPEWIDTH = 8 ,	
parameter GEN5_PIPEWIDTH = 8)
(
    input clk,
    input reset,
    input [3:0] lpifStateRequest,
    input [4:0] numberOfDetectedLanesIn,
    input [7:0] linkNumberInTx,
    input [7:0] linkNumberInRx,
    input [7:0] rateIdIn,
    input upConfigureCapabilityIn,
    input writeNumberOfDetectedLanes,
    input writeLinkNumberTx,
    input writeLinkNumberRx,
    input writeUpconfigureCapability,
    input writeRateId,
    input finishTx,
    input finishRx,
    input [4:0] gotoTx,
    input [4:0] gotoRx,
    input forceDetect,
    /***************eq****************/
    input [47:0] ReceiverpresetHintDSPIn,
    input [63:0] TransmitterPresetHintDSPIn,
    input [47:0] ReceiverpresetHintUSPIn,
    input [63:0] TransmitterPresetHintUSPIn,
    input writeReceiverpresetHintDSP,
    input writeTransmitterPresetHintDSP,
    input writeReceiverpresetHintUSP,
    input writeTransmitterPresetHintUSP,
    input directed_speed_change_In,
    input write_directed_speed_change,
    input 	[18*16 -1:0]LocalTxPresetCoefficients,
    input 	[6*16 -1:0]LocalFS,
    input 	[6*16 -1:0]LocalLF,
    input 	[16 -1:0]LocalTxCoefficientsValid,
    input 	[6*16 -1:0]LinkEvaluationFeedbackDirectionChange,
    output 	[18*16 -1:0]TxDeemph,
    output 	[4*16 -1:0]LocalPresetIndex,
    output 	[16 -1:0]GetLocalPresetCoeffcients,
    output 	[6*16 -1:0]LF,
    output 	[6*16 -1:0]FS,
    output 	[16 -1:0]RxEqEval,
    output 	[16 -1:0]InvalidRequest,
    output directed_speed_change,
    output  [47:0] ReceiverpresetHintDSP,
    output  [63:0] TransmitterPresetHintDSP,
    output  [47:0] ReceiverpresetHintUSP,
    output  [63:0] TransmitterPresetHintUSP,
    output  LF_register,
    output  FS_register,
    output  CursorCoff,
    output PreCursorCoff,
    output PostCursorCoff, 
    /***************eq****************/
    output reg linkUp,
    output reg[2:0] GEN,
    output [4:0] numberOfDetectedLanesOut,
    output [7:0] linkNumberOutTx,
    output [7:0] linkNumberOutRx,
    output [7:0] rateIdOut,
    output upConfigureCapabilityOut,
    output reg[3:0] lpifStateStatus,
    output reg[4:0] substateTx,
    output reg[4:0] substateRx,
    output reg[1:0] width,
    output reg[2:0] trainToGen
    output reg pl_speedmode;    
);

/*
input directed_speed_change,   ///////////new
input [63:0] TxpresetHintofUS,//////////new
input [2:0] trainToGen,////////////new
output [47:0] ReceiverpresetHintofOtherDevice,///////////new
output [63:0] TransmitterPresetofOtherDevice,///////////new
output writeReceiverpresetHint,///////////new
output writeTransmitterPresetHint,///////////new


*/

//local signals
    reg [4:0] numberOfDetectedLanes;
    reg [7:0] linkNumber;
    reg [7:0] rateId;
    reg upConfigureCapability;
    reg [1:0]currentState,nextState;
    reg [3:0] substateTxnext,substateRxnext;
    reg directed_speed_change;
    reg [47:0] ReceiverpresetHintDSP;
    reg [63:0] TransmitterPresetHintDSP;
    reg [47:0] ReceiverpresetHintUSP;
    reg [63:0] TransmitterPresetHintUSP;
    reg [6*16-1:0] CursorCoff,PreCursorCoff,PostCursorCoff,LF_register,FS_register;
    
//Local parameters
    //LPIF STATES
    localparam[1:0]
        reset_   = 4'd0,
        active_  = 4'd1,
        retrain_ = 4'd11;

    //Tx/Rx LTSSM states
    localparam [4:0]
	    detectQuiet =  5'd0,
        detectActive = 5'd1,
        pollingActive= 5'd2,
        pollingConfiguration= 5'd3,
        configurationLinkWidthStart = 5'd4,
        configurationLinkWidthAccept = 5'd5,
        configurationLanenumWait = 5'd6,
        configurationLanenumAccept = 5'd7,
        configurationComplete = 5'd8,
        configurationIdle = 5'd9,
        L0 = 5'd10,
        recoveryRcvrLock = 5'd11,
        recoveryRcvrCfg = 5'd12,
        recoverySpeed = 5'd13,
        phase0 = 5'd14,
        phase1 = 5'd15,
        phase2 = 5'd16,
        phase3 =5'd17,
        recoveryIdle = 5'd18;

    //Data resgiter handling
    always@(posedge clk)
    begin
        if(writeNumberOfDetectedLanes)numberOfDetectedLanes<=numberOfDetectedLanesIn;
        if(writeLinkNumberTx)linkNumber<=linkNumberInTx;
        else if(writeLinkNumberRx)linkNumber<=linkNumberInRx;
        if(writeUpconfigureCapability)upConfigureCapability<=upConfigureCapabilityIn;
        if(writeReceiverpresetHintDSP)ReceiverpresetHintDSP <=ReceiverpresetHintDSPIn;
        if(writeReceiverpresetHintUSP)ReceiverpresetHintUSP <=ReceiverpresetHintUSPIn;
        if(writeTransmitterPresetHintUSP) TransmitterPresetHintUSP<=TransmitterPresetHintUSPIn;
        if(writeTransmitterPresetHintDSP)TransmitterPresetHintDSP <=TransmitterPresetHintDSPIn;
        if(write_directed_speed_change) directed_speed_change <= directed_speed_change_In;
    end

    always @(posedge clk or negedge reset)
    begin
        if(!reset || forceDetect)
        begin
            currentState <= reset_;
            //substateTx <= detectQuiet;
            //substateRx <= detectQuiet;
            GEN <= 3'd1;
            
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
            if(finishRx&&gotoRx==L0&&lpifStateRequest==active_)
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
            else if(lpifStateRequest==retrain_ || trainToGen == 3'd2 || trainToGen == 3'd3)
            begin
               nextState <= retrain_; 
            end
        end
        retrain_:
        begin
            if(gotoRx == L0 && gotoTx == L0)
            begin
               nextState <= active_; 
            end
        end 
        default:
            nextState <= reset_; 
       endcase 
        
    end

//check on gneration and adjust width reg 0 for 8bit 1 for 16bit 2 for 32bit
always @ (posedge clk)
begin 
	if(!reset) begin width <= 0; end
	else begin
		if (GEN == 1)begin  
			case(GEN1_PIPEWIDTH)
			8:width<=0;
			16:width<=1;
			32:width<=2;
			endcase
		end
		else if (GEN == 2)begin  
			case(GEN2_PIPEWIDTH)
			8:width<=0;
			16:width<=1;
			32:width<=2;
			endcase
		end
		else if (GEN == 3)begin  
			case(GEN3_PIPEWIDTH)
			8:width<=0;
			16:width<=1;
			32:width<=2;
			endcase
		end
		else if (GEN == 4)begin  
			case(GEN4_PIPEWIDTH)
			8:width<=0;
			16:width<=1;
			32:width<=2;
			endcase
		end
		else if (GEN == 5)begin  
			case(GEN5_PIPEWIDTH)
			8:width<=0;
			16:width<=1;
			32:width<=2;
			endcase
		end
		
	end
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
                    if ((finishRx&&gotoRx==pollingConfiguration) ||(gotoTx==pollingConfiguration&&finishTx)) 
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
                    if (finishRx&&gotoRx==L0) 
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
                        pl_speedmode = 3'd0;
                    end
            
            endcase
        end
        active_:
        begin
            {substateTxnext,substateRxnext}= {L0,L0};
            lpifStateStatus = active_;
            linkUp = 1'b1;
            if((MAX_GEN==3'd3 && rateId[3:1] == 3'b111) && (!DEVICETYPE || (DEVICETYPE && finishRx &&gotoRx== recoveryRcvrLock)))
            {
                directed_speed_change = 1'b1;
                trainToGen = 3'd3;
                {substateTxnext,substateRxnext}= {recoveryRcvrLock,recoveryRcvrLock};
                
            }
            else if((MAX_GEN==3'd2 && rateId[3:1] == 3'b011) && (!DEVICETYPE || (DEVICETYPE && finishRx &&gotoRx== recoveryRcvrLock)))
            {
                directed_speed_change = 1'b1;
                trainToGen = 3'd2;
                {substateTxnext,substateRxnext}= {recoveryRcvrLock,recoveryRcvrLock};
                
                
            }
           
        end
        retrain_:
        begin
           lpifStateStatus = retrain_;
           linkUp = 1'b1;
           case({substateRx,substateTx}):
                {recoveryRcvrLock,recoveryRcvrLock}:
                begin
                    if(finishRx && gotoRx == recoveryRcvrCfg)
                        {substateTxnext,substateRxnext}= {recoveryRcvrCfg,recoveryRcvrCfg};
                end
                {recoveryCfg,recoveryCfg}:
                begin
                    if(finishRx && gotoRx == recoverySpeed)
                        {substateTxnext,substateRxnext}= {recoverySpeed,recoverySpeed};

                    else if(finishRx && gotoRx == recoveryIdle)
                        {substateTxnext,substateRxnext}= {recoveryIdle,recoveryIdle};
                end
                {recoverySpeed,recoverySpeed}:
                begin
                    if((finishTx&&gotoTx==phase0)&& (finishRx&&gotoRx==phase0))
                    begin
                        {substateTxnext,substateRxnext}= {phase0,phase0};
                        directed_speed_change = 1'b0;
                        GEN = 3'd3;
                        pl_speedmode = 3'd2; //GEN 3
                    end
                        

                end
                {phase0,phase0}:
                begin
                    //mapping tx preset to coeff.
                    GetLocalPresetCoeffcients={16{1'b1}};
				    for(i=0;i<16;i=i+1)
                    begin
                        if(DEVICETYPE)
					        LocalPresetIndex[(4*16-4)-i*4+:4]=TransmitterPresetHintUSP[4*i+:4];
                        else
                            LocalPresetIndex[(4*16-4)-i*4+:4]=TransmitterPresetHintDSP[4*i+:4];
				    end

                    if(LocalTxCoefficientsValid=={16{1'b1}})
                    begin
                        for(i=0;i<16;i=i+1)
                        begin
                            PreCursorCoff[6*i+:6] =LocalTxPresetCoefficients[(18*16-18)-18*i+:6];//[23:18][5:0]       [35:0][17:0]
                            CursorCoff[6*i+:6]    =LocalTxPresetCoefficients[(18*16-18)-18*i+6+:6];//[29:24][11:6]
                            PostCursorCoff[6*i+:6]=LocalTxPresetCoefficients[(18*16-18)-18*i+12+:6];//[35:30][17:12]
                            LF_register[6*i+:6] = LocalLF[(6*LANESNUMBER-6)-6*i+:6];
                            FS_register[6*i+:6] = LocalFS[(6*LANESNUMBER-6)-6*i+:6];
					    end
                        TxDeemph =  LocalTxPresetCoefficients; //use received coeff.
                    end

                    if(finishRx && gotoRx == phase1)
                         {substateTxnext,substateRxnext}= {phase1,phase1};
                end
                {phase1,phase1}:
                begin
                    LF = LocalLF;
                    FS = LocalFS;
                    if(finishRx && gotoRx == recoveryRcvrLock)
                         {substateTxnext,substateRxnext}= {recoveryRcvrLock,recoveryRcvrLock};
                end

                {recoveryIdle,recoveryIdle}:
                begin
                    if((finishRx && gotoRx == L0) && (finishTx && gotoTx == L0))
                         {substateTxnext,substateRxnext}= {L0,L0};
                end
           endcase

        end 
        default:
            nextState = reset_;
       endcase 
        
    end




    assign{numberOfDetectedLanesOut,linkNumberOutTx,linkNumberOutRx,rateIdOut,upConfigureCapabilityOut} = {numberOfDetectedLanes,linkNumber
    ,linkNumber,rateId,upConfigureCapability};
    
endmodule