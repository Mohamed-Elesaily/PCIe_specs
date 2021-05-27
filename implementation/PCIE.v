module PCIe #(
	
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
//clk and reset 
input CLK,
input reset,
output phy_reset,
//PIPE interface width
output [1:0] width, ///////////////////which module
//TX_signals
output [MAXPIPEWIDTH*LANESNUMBER-1:0]TxData,
output [LANESNUMBER-1:0]TxDataValid,
output [LANESNUMBER-1:0]TxElecIdle,
output [LANESNUMBER-1:0]TxStartBlock,
output [(MAXPIPEWIDTH/8)*LANESNUMBER-1:0]TxDataK,
output [2*LANESNUMBER -1:0]TxSyncHeader,
output [LANESNUMBER-1:0]TxDetectRx_Loopback,
//RX_signals
input  	[MAXPIPEWIDTH*LANESNUMBER-1:0]RxData,
input   [LANESNUMBER-1:0]RxDataValid,////////////////////////////////////////
input	[(MAXPIPEWIDTH/8)*LANESNUMBER-1:0]RxDataK,
input	[LANESNUMBER-1:0]RxStartBlock,
input	[2*LANESNUMBER -1:0]RxSyncHeader,
input	[LANESNUMBER-1:0]RxValid,
input	[3*LANESNUMBER -1:0]RxStatus,
input [15:0]RxElectricalIdle,
//commands and status signals
output [4*LANESNUMBER-1:0]PowerDown,
output  [3:0]Rate,
input [LANESNUMBER-1:0]PhyStatus,

//pclkcontrolsignal
output [4:0]PCLKRate,
output PclkChangeAck,
input  PclkChangeOk,
//eq_signals
input 	[18*LANESNUMBER -1:0]LocalTxPresetCoefficients,
output 	[18*LANESNUMBER -1:0]TxDeemph,
input 	[6*LANESNUMBER -1:0]LocalFS,
input 	[6*LANESNUMBER -1:0]LocalLF,
output 	[4*LANESNUMBER -1:0]LocalPresetIndex,
output 	[LANESNUMBER -1:0]GetLocalPresetCoeffcients,
input 	[LANESNUMBER -1:0]LocalTxCoefficientsValid,
output 	[6*LANESNUMBER -1:0]LF,
output 	[LANESNUMBER -1:0]RxEqEval,
output 	[LANESNUMBER -1:0]InvalidRequest,
input 	[6*LANESNUMBER -1:0]LinkEvaluationFeedbackDirectionChange,

output pl_trdy,
input  lp_irdy,
input  [512-1:0]lp_data,
input  [64-1:0]lp_valid,
output [512-1:0]pl_data,
output [64-1:0] pl_valid,
input  [3:0]lp_state_req,
output [3:0]pl_state_sts,
output [2:0]pl_speedmode,////////////////////////////////////////
input lp_force_detect,
////lPIF start & end of TLP DLLP
input [64-1:0]lp_dlpstart,
input [64-1:0]lp_dlpend,
input [64-1:0]lp_tlpstart,
input [64-1:0]lp_tlpend,
output [64-1:0]pl_dlpstart,
output [64-1:0]pl_dlpend,
output [64-1:0]pl_tlpstart,
output [64-1:0]pl_tlpend,
output [64-1:0]pl_tlpedb,
//optional Message bus
output [7:0] M2P_MessageBus,
input  [7:0] P2M_MessageBus
);

wire WriteDetectLanesFlag;
wire [3:0] SetTXState;
wire TXFinishFlag;
wire [3:0]TXExitTo;
wire WriteLinkNumFlag;
wire [4:0] NumberDetectLanesfromtx;
wire [2:0]GEN; 
wire [4:0]numberOfDetectedLanes;
wire [3:0]RXsubstate;
wire [7:0]linkNumber;
wire [7:0] rateid;
wire upConfigureCapability;
wire RXfinish;
wire [3:0]RXexitTo;
///////////output linkUp,////////////
wire witeUpconfigureCapability;
wire writerateid;

mainLTSSM #(.DEVICETYPE(DEVICETYPE)) mainltssm(
    .clk(CLK),
    .reset(reset),
    .lpifStateRequest(lp_state_req),
    .numberOfDetectedLanesIn(NumberDetectLanesfromtx),
    .linkNumberIn(),///////////////////
    .rateIdIn(rateid),
    .upConfigureCapabilityIn(upConfigureCapability),
    .writeNumberOfDetectedLanes(WriteDetectLanesFlag),
    .writeLinkNumber(WriteLinkNumFlag),  ///////////////////////////signal from TX
    .writeUpconfigureCapability(witeUpconfigureCapability),
    .writeRateId(writerateid),
    .finishTx(TXFinishFlag),
    .finishRx( RXfinish),
    .gotoTx(TXExitTo),
    .gotoRx(RXexitTo),
    .forceDetect(lp_force_detect),
    .linkUp(), //////////////////////output from RX and output from main ltssm
    .GEN(GEN),
    .numberOfDetectedLanesOut(numberOfDetectedLanes),
    .linkNumberOut(linkNumber),
    .rateIdOut(),//////not used in tx
    .upConfigureCapabilityOut(),//////not used in tx
    .lpifStateStatus(pl_state_sts),
    .substateTx(SetTXState),
    .substateRx(RXsubstate)    
);

 


module RX #(.GEN1_PIPEWIDTH(GEN1_PIPEWIDTH),.GEN2_PIPEWIDTH(GEN2_PIPEWIDTH), .GEN3_PIPEWIDTH(GEN3_PIPEWIDTH),.GEN4_PIPEWIDTH(GEN4_PIPEWIDTH),
.GEN5_PIPEWIDTH(GEN5_PIPEWIDTH),.DEVICETYPE(DEVICETYPE),.Width(MAXPIPEWIDTH ))
rx
( .reset(reset), 
.clk(CLK), 
.GEN(), 
.PhyStatus(PhyStatus), 
.RxValid(RxValid),
.RxStartBlock(RxStartBlock), 
.RxStatus(RxStatus),
.RxSyncHeader(RxSyncHeader), 
.RxElectricalIdle(RxElectricalIdle),
.RxData(RxData), 
.RxDataK(RxDataK),
.numberOfDetectedLanes(numberOfDetectedLanes),//////////////////
.substate(RXsubstate),
.linkNumber(linkNumber),
.lp_force_detect(lp_force_detect),
.pl_tlpstart(pl_tlpstart), 
.pl_dllpstart(pl_dlpstart), 
.pl_tlpend(pl_tlpend),
.pl_dllpend(pl_dlpend), 
.pl_tlpedb(pl_tlpedb), 
.pl_valid(pl_valid), 
.pl_data(pl_data),
.pl_speedmode(pl_speedmode), 
.pl_state_sts(), /////////////////////////////////////////////
.rateid(rateid),
.upConfigureCapability(upConfigureCapability),
.finish( RXfinish),
.exitTo(RXexitTo),
.linkUp(),/////////////////////////////////////////////output from RX
.witeUpconfigureCapability(witeUpconfigureCapability),
.writerateid(writerateid));





TOP_MODULE #
(
.MAXPIPEWIDTH(MAXPIPEWIDTH),
.DEVICETYPE(DEVICETYPE), //0 for downstream 1 for upstream
.LANESNUMBER(LANESNUMBER),
.GEN1_PIPEWIDTH(GEN1_PIPEWIDTH),	
.GEN2_PIPEWIDTH (GEN2_PIPEWIDTH) ,	
.GEN3_PIPEWIDTH (GEN3_PIPEWIDTH),	
.GEN4_PIPEWIDTH (GEN4_PIPEWIDTH) ,	
.GEN5_PIPEWIDTH (GEN5_PIPEWIDTH),	
.MAX_GEN(MAX_GEN))
TX
(.pclk(CLK),
.reset_n(reset),
.pl_trdy(pl_trdy),
.lp_irdy(lp_irdy),
.lp_data(lp_data),
.lp_valid(lp_valid),
.lp_dlpstart(lp_dlpstart),
.lp_dlpend(lp_dlpend),
.lp_tlpstart(lp_tlpstart),
.lp_tlpend(lp_tlpend),
.RxStatus(RxStatus),
.NumberDetectLanes(NumberDetectLanesfromtx)
.TxDetectRx_Loopback(TxDetectRx_Loopback),
.PowerDown(PowerDown),
.PhyStatus(PhyStatus),
.TxElecIdle(TxElecIdle),
.detected_lanes(),//////////////////////////////////////////////////////
.WriteDetectLanesFlag(WriteDetectLanesFlag),
.SetTXState(SetTXState),
.TXFinishFlag(TXFinishFlag),
.TXExitTo(TXExitTo), /////////////////////////
.WriteLinkNum(),//////////////////////////////
.WriteLinkNumFlag(WriteLinkNumFlag),
.ReadLinkNum(),////////////////////////////there is no link number read port from 
.TxData1(TxData[31:0]),
.TxData2(TxData[63:32]),
.TxData3(TxData[95:64]),
.TxData4(TxData[127:96]),
.TxData5(TxData[159:128]),
.TxData6(TxData[191:160),
.TxData7(TxData[223:192]),
.TxData8(TxData[255:224]),
.TxData9(TxData[287:256]),
.TxData10(TxData[319:288]),
.TxData11(TxData[351:320]),
.TxData12(TxData[383:352]),
.TxData13(TxData[415:384]),
.TxData14(TxData[447:416]),
.TxData15(TxData[479:448]),
.TxData16(TxData[511:480]),
.TxDataValid1(TxDataValid[0]),
.TxDataValid2(TxDataValid[1]),
.TxDataValid3(TxDataValid[2]),
.TxDataValid4(TxDataValid[3]),
.TxDataValid5(TxDataValid[4]),
.TxDataValid6(TxDataValid[5]),
.TxDataValid7(TxDataValid[6]),
.TxDataValid8(TxDataValid[7]),
.TxDataValid9(TxDataValid[8]),
.TxDataValid10(TxDataValid[9]),
.TxDataValid11(TxDataValid[10]),
.TxDataValid12(TxDataValid[11]),
.TxDataValid13(TxDataValid[12]),
.TxDataValid14(TxDataValid[13]),
.TxDataValid15(TxDataValid[14]),
.TxDataValid16(TxDataValid[15]),
.TxDataK1(TxDataK[3:0]),
.TxDataK2(TxDataK[7:4]),
.TxDataK3(TxDataK[11:8]),
.TxDataK4(TxDataK[15:12]),
.TxDataK5(TxDataK[19:16]),
.TxDataK6(TxDataK[23:20]),
.TxDataK7(TxDataK[27:24]),
.TxDataK8(TxDataK[31:28]),
.TxDataK9(TxDataK[35:32]),
.TxDataK10(TxDataK[39:36]),
.TxDataK11(TxDataK[43:40]),
.TxDataK12(TxDataK[47:44]),
.TxDataK13(TxDataK[51:48]),
.TxDataK14(TxDataK[55:52]),
.TxDataK15(TxDataK[59:56]),
.TxDataK16(TxDataK[63:60]));
endmodule

