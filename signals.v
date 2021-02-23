module PCIe
#(
	
	parameter NDWORD  =16
	parameter MAXPIPEWIDTH = 32,
	parameter DEVICETYPE = 0, //0 for downstream 1 for upstream
	parameter LANESNUMBER =16
	
	parameter GEN1_PIPEWIDTH = 8 	// 8bit  : 250 M
	parameter GEN1_PCLCk     = 250  // 16bit : 125 M
									// 32bit : 62.5M
	
	parameter GEN2_PIPEWIDTH = 8 	// 8bit  : 500 M
	parameter GEN2_PCLCk     = 500  // 16bit : 250 M
									// 32bit : 125 M
	
	parameter GEN3_PIPEWIDTH = 8 	// 8bit  : 1   G
	parameter GEN3_PCLCk     = 1000 // 16bit : 500 M
									// 32bit : 250 M
									
	parameter GEN4_PIPEWIDTH = 8 	// 8bit  : 2   G
	parameter GEN4_PCLCk     = 2000 // 16bit : 1   G
									// 32bit : 250 M

	parameter GEN5_PIPEWIDTH = 8 	// 8bit  : 4 G
	parameter GEN5_PCLCk     = 4000 // 16bit : 2 G
									// 32bit : 1 G
)
(
//clk and reset 
input CLK,
output PCLK,
input reset,
output phy_reset,
//PIPE interface width
output [1:0] width,
//TX_signals
output [MAXPIPEWIDTH-1:0][LANESNUMBER-1:0]TxData,
output TxDataValid,
output TxElecIdle,
output TxStartBlock,
output [MAXPIPEWIDTH/8-1:0][LANESNUMBER-1:0]TxDataK,
output [1:0]TxSyncHeader,
output	TxDetectRx_Loopback,
//RX_signals
input  [MAXPIPEWIDTH-1:0][LANESNUMBER-1:0]RxData,
input   RxDataValid,
input	[MAXPIPEWIDTH/8-1:0][LANESNUMBER-1:0]RxDataK,
input	RxStartBlock,
input	[1:0]RxSyncHeader,
input	RxValid,
input	[2:0]RxStatus,
//commands and status signals
output [3:0]PowerDown,
output  [3:0]Rate,
input PhyStatus,
output [1:0]Width,
//pclkcontrolsignal
output [4:0]PCLKRate,
output PclkChangeAck,
input  PclkChangeOk,
//eq_signals
input [21:0]get_eq_info,
output [21:0]send_eq_info,
input use_preset,
input valid_coeff,
input evaluation_complete,
output read_eq,
output evaluate_eq,
output write_eq,
output EC,
//LPIF 
output pl_trdy,
input  lp_irdy,
input  [NDWORD-1:0][31:0]lp_data,
input  [NDWORD-1:0]lp_valid,
output [NDWORD-1:0][31:0]pl_data,
output [NDWORD-1:0] pl_valid,
input  [3:0]lp_state_req,
output [3:0]pl_state_sts,
output [2:0]pl_speedmode,
input lp_force_detect,
////lPIF start & end of TLP DLLP
input [NDWORD-1:0]lp_dlpstart,
input [NDWORD-1:0]lp_dlpend,
input [NDWORD-1:0]lp_tlpstart,
input [NDWORD-1:0]lp_tlpend,
output [NDWORD-1:0]pl_dlpstart,
output [NDWORD-1:0]pl_dlpend,
output [NDWORD-1:0]pl_tlpstart,
output [NDWORD-1:0]pl_tlpend
//optional Message bus
output [7:0] M2P_MessageBus
input  [7:0] P2M_MessageBus

);
endmodule