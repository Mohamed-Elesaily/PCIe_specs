module PCIe
#(
	parameter NBYTES    = 64,
	parameter PIPEWIDTH = 32,
	parameter DEVICETYPE = 0, //0 for downstream 1 for upstream
	parameter LANESNUMBER =16			
)
(
//clk and reset 
input CLK,
output PCLK,
input reset,
output phy_reset,
//TX_signals
output [PIPEWIDTH-1:0]TxData,
output TxDataValid,
output TxElecIdle,
output TxStartBlock,
output [PIPEWIDTH/8-1:0]TxDataK,
output [1:0]TxSyncHeader,
output	TxDetectRx_Loopback,
//RX_signals
input  [PIPEWIDTH-1:0]RxData,
input   RxDataValid,
input	[PIPEWIDTH/8-1:0]RxDataK,
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
input  [NBYTES-1:0][7:0]lp_data,
input  [NBYTES-1:0]lp_valid,
output [NBYTES-1:0][7:0]pl_data,
output [NBYTES-1:0] pl_valid,
input  [3:0]lp_state_req,
output [3:0]pl_state_sts,
output [2:0]pl_speedmode,
input lp_force_detect,
////lPIF start & end of TLP DLLP
input [NBYTES-1:0]lp_dlpstart,
input [NBYTES-1:0]lp_dlpend,
input [NBYTES-1:0]lp_tlpstart,
input [NBYTES-1:0]lp_tlpend,
output [NBYTES-1:0]pl_dlpstart,
output [NBYTES-1:0]pl_dlpend,
output [NBYTES-1:0]pl_tlpstart,
output [NBYTES-1:0]pl_tlpend
);
endmodule