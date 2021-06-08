
module TX_LTSSM #
(
parameter MAXPIPEWIDTH = 32,
parameter DEVICETYPE = 0, //0 for downstream 1 for upstream
parameter LANESNUMBER =16,
parameter GEN1_PIPEWIDTH = 8 ,	
parameter GEN2_PIPEWIDTH = 8 ,	
parameter GEN3_PIPEWIDTH = 8 ,	
parameter GEN4_PIPEWIDTH = 8 ,	
parameter GEN5_PIPEWIDTH = 8 ,	
parameter MAX_GEN = 1
)
(
input Pclk,
input Reset, //active low
output reg [2:0]Gen ,
output reg [4:0] NumberDetectLanes,
output reg [LANESNUMBER-1:0] DetectLanes,
output reg WriteDetectLanesFlag,
// main LTSSM interface
input  [4:0] SetTXState,
output reg TXFinishFlag,
output reg [4:0] TXExitTo,
output reg[7:0] WriteLinkNum,
output reg WriteLinkNumFlag,
input [7:0] ReadLinkNum,
input [2:0] TrainToGen,
//input ReadSpeedChangeVariable,
input ReadDirectSpeedChange,
input [7*LANESNUMBER-1:0]ReadEqualizationControlRegisterUSP,
input [7*LANESNUMBER-1:0]ReadEqualizationControlRegisterDSP,
//input ReadCompleteEqualizationVariable, //////ask Emad 
// LPIF TX control & data flow interface 
output reg HoldFIFOData,
input FIFOReady,
// OS generator interface 
output reg [2:0] OSType,
output reg[1:0] LaneNumber, 
output reg[7:0] LinkNumber,
output reg[2:0] Rate,
output reg Loopback,
//OS generator interface communication
output reg OSGeneratorStart,
input OSGeneratorBusy,
input OSGeneratorFinish,
//OS generator interface equalization 
output reg [1:0] EC,
output reg ResetEIEOSCount,
output reg [4* LANESNUMBER-1:0] TXPreset,
output reg [3* LANESNUMBER-1:0] RXPreset,
output reg [LANESNUMBER-1:0] UsePresetCoff,
output reg [6* LANESNUMBER-1:0] FS,
output reg [6* LANESNUMBER-1:0] LF,
output reg [6* LANESNUMBER-1:0] PreCursorCoff,
output reg [6* LANESNUMBER-1:0] CursorCoff,
output reg [6* LANESNUMBER-1:0] PostCursorCoff,
output reg [ LANESNUMBER-1:0] RejectCoff,
output reg SpeedChange,
output reg ReqEq,
output reg EQTS2,
//mux
output reg MuxSel,
//Lane Management control 
//PIPE TX Control
output reg [ LANESNUMBER-1:0]DetectReq,
output reg [ LANESNUMBER-1:0]ElecIdleReq,
input  [ LANESNUMBER-1:0]DetectStatus,
//scrambler
output reg turnOff,
output [23:0]seedValue,
//new
input 	[18*LANESNUMBER -1:0]LocalTxPresetCoefficients,
output 	[18*LANESNUMBER -1:0]TxDeemph,
input 	[6*LANESNUMBER -1:0]LocalFS,
input 	[6*LANESNUMBER -1:0]LocalLF,
output reg	[4*LANESNUMBER -1:0]LocalPresetIndex,
output reg	[LANESNUMBER -1:0]GetLocalPresetCoeffcients,
input 	[LANESNUMBER -1:0]LocalTxCoefficientsValid,
output 	[6*LANESNUMBER -1:0]OLF,
output 	[6*LANESNUMBER -1:0]OFS,
output 	[LANESNUMBER -1:0]RxEqEval,
output 	[LANESNUMBER -1:0]InvalidRequest,
input 	[6*LANESNUMBER -1:0]LinkEvaluationFeedbackDirectionChange
);

// states encoding
 parameter  DetectQuiet = 5'd0, DetectActive = 5'd1, PollingActive = 5'd2,
	    PollingConfigration = 5'd3, ConfigrationLinkWidthStart = 5'd4, ConfigrationLinkWidthAccept= 5'd5,
            ConfigrationLaneNumWait = 5'd6,  ConfigrationLaneNumActive = 5'd7, ConfigrationComplete = 5'd8,
            ConfigrationIdle = 5'd9,L0=5'd10,RecoveryRcvrLock=5'd11,RecoveryRcvrCfg=5'd12, RecoverySpeed=5'd13,Ph0=5'd14,Ph1=5'd15,Ph2=5'd16,Ph3=5'd17,RecoveryIdle= 5'd18, Idle=5'd31;
//Device type 
parameter DownStream = 0 ,UpStream = 1;
//time 
parameter t12ms= 3'b001,t0ms = 3'b000 , t1ms=3'b110;
//Generation
parameter Gen1 = 3'b001,Gen2 = 3'b010,Gen3 = 3'b011,Gen4 = 3'b100,Gen5 = 3'b101; // TODO edited
//internal Register 

reg [4:0]State;
wire [4:0]NextState;
reg [4:0] ExitToState;
reg ExitToFlag;
//internal Register 
reg [15:0]OSCount;
reg [2:0]CurrentGen;
//
reg WriteDetectLanesFlagReg;
//Timer interface
reg TimerEnable;
reg TimerStart;
reg [2:0]TimerIntervalCode;
wire TimeOut;
Timer #(.Width(32)) T(.Gen(Gen),.Reset(Reset),.Pclk(Pclk),.Enable(TimerEnable),.Start(TimerStart),.TimerIntervalCode(TimerIntervalCode),.TimeOut(TimeOut));

//assignment
assign NextState = SetTXState; 

///lanes number
always @ *
begin 
if(DetectLanes[15]) NumberDetectLanes=15+1;
else if (DetectLanes[14]) NumberDetectLanes=14+1;
else if (DetectLanes[13]) NumberDetectLanes=13+1;
else if (DetectLanes[12]) NumberDetectLanes=12+1;
else if (DetectLanes[11]) NumberDetectLanes=11+1;
else if (DetectLanes[10]) NumberDetectLanes=10+1;
else if (DetectLanes[9]) NumberDetectLanes=9+1;
else if (DetectLanes[8]) NumberDetectLanes=8+1;
else if (DetectLanes[7]) NumberDetectLanes=7+1;
else if (DetectLanes[6]) NumberDetectLanes=6+1;
else if (DetectLanes[5]) NumberDetectLanes=5+1;
else if (DetectLanes[4]) NumberDetectLanes=4+1;
else if (DetectLanes[3]) NumberDetectLanes=3+1;
else if (DetectLanes[2]) NumberDetectLanes=2+1;
else if (DetectLanes[1]) NumberDetectLanes=1+1;
else if (DetectLanes[0]) NumberDetectLanes=0+1;
else   NumberDetectLanes=0;
end 
//exit to logic combinational
always @ * begin
//default value for outputs (synthesis)
	ExitToState = 5'bxxxx;
	ExitToFlag  = 0 ;

	case(State)
		DetectQuiet:begin
			if (TimeOut==1) begin
				ExitToState = DetectActive;
				ExitToFlag  = 1 ;
			end
		end	
		DetectActive:begin
			if (DetectStatus == {LANESNUMBER{1'b1}} )begin
				DetectLanes = DetectStatus;
				WriteDetectLanesFlagReg<=1;
				ExitToState = PollingActive;
				ExitToFlag  = 1 ;
			end	
			else if (TimeOut && DetectStatus == {LANESNUMBER{1'b0}} )begin
				ExitToState = DetectQuiet;
				ExitToFlag  = 1 ;
			end	
		end
		PollingActive:begin
		 if(OSCount >= 1024)begin
			ExitToState = PollingConfigration;
			ExitToFlag  = 1 ;
		 end
		end
		PollingConfigration:begin
		 if(OSCount >= 16)begin
			ExitToState = ConfigrationLinkWidthStart;
			ExitToFlag  = 1 ;
		 end
		end
		ConfigrationLinkWidthAccept:begin
		if(DEVICETYPE==DownStream && OSGeneratorFinish)begin
			ExitToState = ConfigrationLaneNumWait;
			ExitToFlag  = 1 ;
		end
		end
		ConfigrationComplete:begin
		if(OSCount >= 16)begin
			ExitToState = ConfigrationIdle;
			ExitToFlag  = 1 ;
		 end
		end
		ConfigrationIdle:begin
		if(OSCount >= 16)begin
			ExitToState = L0;
			ExitToFlag  = 1 ;
		 end
		end
		RecoveryRcvrLock:begin //////////////TODO ask Emad 
			if(OSGeneratorFinish)begin 
				ExitToState<=RecoveryRcvrCfg;
				ExitToFlag<=1;				
			end
		
		end
		RecoveryRcvrCfg:begin
			if(OSGeneratorFinish)begin 
				if(ReadDirectSpeedChange)begin
					ExitToState<=RecoverySpeed;
					ExitToFlag<=1;
				end
				else begin
					ExitToState<=RecoveryIdle;
					ExitToFlag<=1;
				end
			end
		
		end
		RecoverySpeed:begin
			if(TimeOut && OSCount >= 2)begin
				if(TrainToGen==Gen3)begin
					ExitToState<=Ph0;
					ExitToFlag<=1;
				end
				else begin
					ExitToState<=RecoveryRcvrLock;
					ExitToFlag<=1;
				end
			end
		end
		Ph0:begin
			//N/A
		end
	endcase
end

integer i;
always @(posedge Pclk) begin
//Default values of outputs
Gen <= CurrentGen;
ElecIdleReq <= {LANESNUMBER{1'b0}};
DetectReq<= {LANESNUMBER{1'b0}};
OSGeneratorStart <=0;
WriteLinkNumFlag <=0;
turnOff<=1;
GetLocalPresetCoeffcients<=0;
	case(State)
		DetectQuiet:begin
			HoldFIFOData <= 1;
			ElecIdleReq <= {LANESNUMBER{1'b1}};
		end
		DetectActive:begin
			HoldFIFOData<=1;
			DetectReq<= {LANESNUMBER{1'b1}};
		end
		 PollingActive:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b00;
		   LaneNumber<=2'b00;
			LinkNumber<=8'b0;
			Rate<=MAX_GEN;
			Loopback<=1;
			OSGeneratorStart<=1;
			end
		end
		PollingConfigration:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b01; //TS2
		   LaneNumber<=2'b00;
			LinkNumber<=8'b0;
			Rate<=MAX_GEN;
			OSGeneratorStart<=1;
			end
		end
		ConfigrationLinkWidthStart:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b00; //TS1
		   LaneNumber<=2'b00;
			Rate<=MAX_GEN;
			if(DEVICETYPE==DownStream)begin
				LinkNumber<=8'b01;
				WriteLinkNum <= 8'b01;
				WriteLinkNumFlag <= 1;
			end
			else begin
				LinkNumber<=8'b00; //pad
			end
			OSGeneratorStart<=1;
			end
		end
		
		ConfigrationLinkWidthAccept:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b00; //TS1
		   LinkNumber<=ReadLinkNum;
			Rate<=MAX_GEN;
			if(DEVICETYPE==DownStream)begin
				LaneNumber<=2'b01; //num_seq
			end
			else begin
				LaneNumber<=8'b00; //pad
			end
			OSGeneratorStart<=1;
			end
		end
		ConfigrationLaneNumWait:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b00; //TS1
		   LinkNumber<=ReadLinkNum;
			Rate<=MAX_GEN;
			LaneNumber<=2'b01; //num_seq
			OSGeneratorStart<=1;
			end
		end
		ConfigrationLaneNumActive:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b00; //TS1
		   LinkNumber<=ReadLinkNum;
			Rate<=MAX_GEN;
			LaneNumber<=2'b01; //num_seq
			OSGeneratorStart<=1;
			end
		end
		
		ConfigrationComplete:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=2'b01; //TS2
		   LinkNumber<=ReadLinkNum;
			Rate<=MAX_GEN;
			LaneNumber<=2'b01; //num_seq
			OSGeneratorStart<=1;
			end
		end
		ConfigrationIdle:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
			OSType<=3'b100; //IDLE
			OSGeneratorStart<=1;
			end
		end
		L0:begin
			turnOff<=0;
			HoldFIFOData<=0;
			MuxSel <=1; //TODO : check is it 1 or 0 for orderset
		end
		RecoveryRcvrLock: begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(!OSGeneratorBusy)begin //it is supposed that
				OSType<=3'b000; //TS1
				LinkNumber<=ReadLinkNum;
				Rate<=MAX_GEN;
				LaneNumber<=2'b01; //num_seq
				SpeedChange<=ReadDirectSpeedChange;
				EC<=2'b00;
				OSGeneratorStart<=1;
			end
		end
		RecoveryRcvrCfg:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset			
			if(!OSGeneratorBusy)begin //it is supposed that
				OSType<=3'b001; //TS2
				LinkNumber<=ReadLinkNum;
				Rate<=MAX_GEN;
				LaneNumber<=2'b01; //num_seq
				SpeedChange<=ReadDirectSpeedChange;
				EC<=2'b00;
				if (TrainToGen == Gen3 && DEVICETYPE ==DownStream )
				begin 
					EQTS2<=1;
					for(i=0;i<LANESNUMBER;i=i+1)begin
						RXPreset[3*i+:3]<=ReadEqualizationControlRegisterDSP[7*i+4+:3];
						TXPreset[4*i+:4]<=ReadEqualizationControlRegisterDSP[7*i+:4];
					end 
				end
				OSGeneratorStart<=1;
			end
		end
		RecoverySpeed:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			ElecIdleReq <= {LANESNUMBER{1'b1}};
			if(!OSGeneratorBusy)begin 
				OSType<=3'b011; //eios
				OSGeneratorStart<=1;
			end
		end
		Ph0:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(DEVICETYPE==UpStream)begin
				
				GetLocalPresetCoeffcients<={LANESNUMBER{1'b1}};
				for(i=0;i<LANESNUMBER;i=i+1)begin
					LocalPresetIndex[(4*LANESNUMBER-4)-i*4+:4]<=ReadEqualizationControlRegisterDSP[7*i+:4];
				end
				 
				if(!OSGeneratorBusy && LocalTxCoefficientsValid=={LANESNUMBER{1'b1}})begin //it is supposed that
					OSType<=3'b000; //TS1
					LinkNumber<=ReadLinkNum;
					Rate<=MAX_GEN;
					LaneNumber<=2'b01; //num_seq
					SpeedChange<=ReadDirectSpeedChange;
					EC<=2'b00;
					for(i=0;i<LANESNUMBER;i=i+1)begin
						TXPreset[4*i+:4]<=ReadEqualizationControlRegisterDSP[7*i+:4];
						PreCursorCoff[6*i+:6] <=LocalTxPresetCoefficients[(18*LANESNUMBER-18)-18*i+:6];//[23:18][5:0]       [35:0][17:0]
						CursorCoff[6*i+:6]    <=LocalTxPresetCoefficients[(18*LANESNUMBER-18)-18*i+6+:6];//[29:24][11:6]
	 					PostCursorCoff[6*i+:6]<=LocalTxPresetCoefficients[(18*LANESNUMBER-18)-18*i+12+:6];//[35:30][17:12]
					//	LF[6*i+:6] <= LocalLF[(6*LANESNUMBER-6)-6*i+:6];
						//FS[6*i+:6] <= LocalFS[(6*LANESNUMBER-6)-6*i+:6];
					end 

					OSGeneratorStart<=1;
				end
			end
		end
		Ph1:begin
			HoldFIFOData<=1;
			MuxSel <=0; //TODO : check is it 1 or 0 for orderset
			if(DEVICETYPE==DownStream)begin
				GetLocalPresetCoeffcients<={LANESNUMBER{1'b1}};
				for(i=0;i<LANESNUMBER;i=i+1)begin
					LocalPresetIndex[(4*LANESNUMBER-4)-i*4+:4]<=ReadEqualizationControlRegisterDSP[7*i+:4];
				end
				if(!OSGeneratorBusy && LocalTxCoefficientsValid=={LANESNUMBER{1'b1}})begin //it is supposed that
					OSType<=3'b000; //TS1
					LinkNumber<=ReadLinkNum;
					Rate<=MAX_GEN;
					LaneNumber<=2'b01; //num_seq
					SpeedChange<=ReadDirectSpeedChange;
		 			EC<=2'b01;
					for(i=0;i<LANESNUMBER;i=i+1)begin
						TXPreset[4*i+:4]<=ReadEqualizationControlRegisterDSP[7*i+:4];
						//PreCursorCoff[6*i+5:6*i] <=LocalTxPresetCoefficients[18*LANESNUMBER-18*i-12-1:18*LANESNUMBER-18*i-18];//[23:18][5:0]       [35:0][17:0]
						//CursorCoff[6*i+5:6*i] <=LocalTxPresetCoefficients[18*LANESNUMBER-18*i-6-1:18*LANESNUMBER-18*i-12];//[29:24][11:6]
	 					PostCursorCoff[6*i+:6] <=LocalTxPresetCoefficients[(18*LANESNUMBER-18)-18*i+12+:6];//[35:30][17:12]
						LF[6*i+:6] <= LocalLF[(6*LANESNUMBER-6)-6*i+:6];
						FS[6*i+:6] <= LocalFS[(6*LANESNUMBER-6)-6*i+:6];
					end 
					OSGeneratorStart<=1;
				end
			end
			else if(DEVICETYPE==UpStream)begin
				GetLocalPresetCoeffcients<={LANESNUMBER{1'b1}};
				for(i=0;i<LANESNUMBER;i=i+1)begin
					LocalPresetIndex[(4*LANESNUMBER-4)-i*4+:4]<=ReadEqualizationControlRegisterUSP[7*i+:4];
				end
			if(!OSGeneratorBusy && LocalTxCoefficientsValid=={LANESNUMBER{1'b1}})begin //it is supposed that
					OSType<=3'b000; //TS1
					LinkNumber<=ReadLinkNum;
					Rate<=MAX_GEN;
					LaneNumber<=2'b01; //num_seq
					SpeedChange<=ReadDirectSpeedChange;
					EC<=2'b01;
					for(i=0;i<LANESNUMBER;i=i+1)begin
						TXPreset[4*i+:4]<=ReadEqualizationControlRegisterUSP[7*i+:4];
						//PreCursorCoff[6*i+5:6*i] <=LocalTxPresetCoefficients[18*LANESNUMBER-18*i-12-1:18*LANESNUMBER-18*i-18];//[23:18][5:0]       [35:0][17:0]
						//CursorCoff[6*i+5:6*i] <=LocalTxPresetCoefficients[18*LANESNUMBER-18*i-6-1:18*LANESNUMBER-18*i-12];//[29:24][11:6]
	 					PostCursorCoff[6*i+:6] <=LocalTxPresetCoefficients[(18*LANESNUMBER-18)-18*i+12+:6];//[35:30][17:12]
						LF[6*i+:6] <= LocalLF[(6*LANESNUMBER-6)-6*i+:6];
						FS[6*i+:6] <= LocalFS[(6*LANESNUMBER-6)-6*i+:6];
					end 
					OSGeneratorStart<=1;
				end
			
			
			
			end
		
		
		end
	endcase 
end


//on trasition to different state initialize orderset_count and any other variable need to be initialized
always @(posedge Pclk)
begin
TimerStart <= 0;
	case(State)
		DetectQuiet:begin
			if( NextState == DetectActive)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			else if (NextState == PollingActive || NextState == PollingConfigration 
			|| NextState == ConfigrationComplete ||NextState == ConfigrationIdle)begin
				OSCount<=0;		
			end
			if(TimeOut)begin
				TimerEnable <= 0;
			end
		end		
		
		DetectActive:begin
			if(NextState == DetectQuiet)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			else if (NextState == PollingActive || NextState == PollingConfigration 
			|| NextState == ConfigrationComplete ||NextState == ConfigrationIdle)begin
				OSCount<=0;		
			end			
		   if(TimeOut)begin
				TimerEnable <= 0;
			end
		end		

		PollingActive:begin
			if(OSGeneratorFinish)begin
				OSCount<=OSCount+1;		
			end
			if(NextState == DetectQuiet || NextState == DetectActive)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			else if ( NextState == PollingConfigration || NextState == ConfigrationComplete 
			||NextState == ConfigrationIdle)begin
				OSCount<=0;		
			end			
		end		
		
		PollingConfigration :begin
			if(OSGeneratorFinish)begin
				OSCount<=OSCount+1;		
			end
			if(NextState == DetectQuiet || NextState == DetectActive)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			else if (NextState == PollingActive  
			|| NextState == ConfigrationComplete ||NextState == ConfigrationIdle)begin
				OSCount<=0;		
			end			
		end		
	
		ConfigrationComplete:begin
			if(OSGeneratorFinish)begin
				OSCount<=OSCount+1;		
			end
			if(NextState == DetectQuiet || NextState == DetectActive)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			else if (NextState == PollingActive || NextState == PollingConfigration 
			||NextState == ConfigrationIdle)begin
				OSCount<=0;		
			end			
		end		

		ConfigrationIdle:begin
			if(OSGeneratorFinish)begin
				OSCount<=OSCount+1;		
			end
			if(NextState == DetectQuiet || NextState == DetectActive)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			
			else if (NextState == PollingActive || NextState == PollingConfigration 
			|| NextState == ConfigrationComplete )begin
				OSCount<=0;		
			end			
		end		
		
		RecoveryRcvrCfg:begin
			if(NextState==RecoverySpeed)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t1ms;
				OSCount<= 0;
			end
		end
		
		RecoverySpeed:begin
			if(OSGeneratorFinish)begin
				OSCount <= OSCount + 1;		
			end
			if(TimeOut)begin
				TimerEnable <= 0;
			end
		end
		default:begin
			if(NextState == DetectQuiet || NextState == DetectActive)begin
				TimerEnable <= 1;
				TimerStart  <= 1;
				TimerIntervalCode <= t12ms;
			end
			else if (NextState == PollingActive || NextState == PollingConfigration 
			|| NextState == ConfigrationComplete ||NextState == ConfigrationIdle || NextState == RecoverySpeed )begin
				OSCount<=0;		
			end			
		end		
	endcase
end
// outputs
always @ (posedge Pclk)
begin
	if(!Reset) begin
		State <= Idle;
		TXExitTo <= DetectQuiet;
		TXFinishFlag <= 0;
		CurrentGen=Gen1;
		WriteDetectLanesFlag<=0;
	end
	else begin
		State   <= NextState;
		TXExitTo<= ExitToState;
		TXFinishFlag <= ExitToFlag;
		WriteDetectLanesFlag<=WriteDetectLanesFlagReg;
	end
end

endmodule