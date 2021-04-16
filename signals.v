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
output [1:0] width,
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
input   [LANESNUMBER-1:0]RxDataValid,
input	[(MAXPIPEWIDTH/8)*LANESNUMBER-1:0]RxDataK,
input	[LANESNUMBER-1:0]RxStartBlock,
input	[2*LANESNUMBER -1:0]RxSyncHeader,
input	[LANESNUMBER-1:0]RxValid,
input	[3*LANESNUMBER -1:0]RxStatus,
//commands and status signals
output [3:0]PowerDown,
output  [3:0]Rate,
input PhyStatus,

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
output [2:0]pl_speedmode,
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
//optional Message bus
output [7:0] M2P_MessageBus,
input  [7:0] P2M_MessageBus

);


endmodule
