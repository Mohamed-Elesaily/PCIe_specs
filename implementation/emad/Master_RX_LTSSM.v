module  masterRxLTSSM #(parameter MAXLANES = 16)(
    input clk,
    input [4:0]numberOfDetectedLanes,
    input [3:0]substate,
    input [15:0]countersComparators,
    input forceDetect,
    input rxElectricalIdle,
    input timeOut,
    input reset,
    output reg finish,
    output reg [3:0]exitTo,
    output reg [15:0]resetOsCheckers,
    output reg disableDescrambler,
    //output [3:0]lpifStatus
    output reg [5:0]setTimer,
    output reg enableTimer,
    output reg resetTimer,
    output reg[4:0]comparatorsCount);
    
    reg[3:0] lastState;
    reg[1:0] currentState,nextState;
    reg[5:0] timeToWait;
    reg[15:0]comparatorsCondition;
    reg forcedetectflag;
//input substates from main ltssm
    localparam [3:0]
	detectQuiet =  4'd0,
	detectActive = 4'd1,
	pollingActive= 4'd2,
	pollingConfiguration= 4'd3,
    configurationLinkWidthStart = 4'd4,
    configurationLinkWidthAccept = 4'd5,
    configurationLanenumWait = 4'd6,
    configurationLanenumAccept = 4'd7,
    configurationComplete =4'd8,
    configurationIdle = 4'd9;
    

//local states
    localparam [1:0]
    start = 2'b00,
    counting = 2'b01,
    success = 2'b10,
    failed = 2'b11;

    //CURRENT STATE FF
    always @(posedge clk or negedge reset or posedge forceDetect)
    begin
        if(!reset)
        begin
            	currentState <= start;
	        finish <= 1'b0;
		lastState<=4'hF;
		forcedetectflag<=1'b0;
        end
        else
        begin
		if(forceDetect) //got to detectquiet
		begin
               		comparatorsCount <= 5'd0;
                	timeToWait <= 6'd12;
               	 	currentState <= counting;
			forcedetectflag <=1'b1;
		end
           	else currentState <= nextState;
        end    
    end

    always @(*)
    begin
        disableDescrambler = 1'b0;
        case(currentState)
        start:
        begin
	 forcedetectflag = 1'b0;        
         if(substate != lastState) //ensure that this is a new request
         begin
            resetOsCheckers = {16{1'b1}};
            if(substate == detectQuiet)
            begin
                comparatorsCount = 5'd0;
                timeToWait = 6'd12;
                nextState = counting;
		 
            end
            else if(substate == detectActive)
            begin
                comparatorsCount = 5'd0;
                timeToWait = 6'd0;
                nextState = counting;
		
            end
            else if(substate==pollingActive||substate==configurationComplete)
            begin
                comparatorsCount = 5'd8;
                timeToWait = 6'd24;
                nextState = counting;
		
            end
            else if (substate==configurationLinkWidthStart||substate==configurationLinkWidthAccept||substate==configurationLanenumAccept)
            begin
                comparatorsCount = 5'd2;
                timeToWait = 6'd24;
                nextState = counting;
		                
            end
            else if (substate==configurationLanenumWait)
            begin
                comparatorsCount=5'd2;
                timeToWait = 6'd2;
                nextState = counting;
		
            end
            else if (substate==pollingConfiguration)
            begin
                comparatorsCount=5'd8;
                timeToWait = 6'd48;
                nextState = counting;
		
            end
 	    else if (substate==configurationIdle)
            begin
                comparatorsCount=5'd8;
                timeToWait = 6'd2;
                nextState = counting;
		
            end
		
        end
        
        else 
        begin
            comparatorsCount=5'd0;
            timeToWait = 6'd0;
            enableTimer = 1'b0;
            resetTimer = 1'b0;
            resetOsCheckers = 16'b0;
            nextState = start;
        end

    end
        
    counting:
    begin
        enableTimer = 1'b1;
        resetTimer  = 1'b1;
        resetOsCheckers = {16{1'b1}};
	finish = 1'b0;
        if((!timeOut && countersComparators >= comparatorsCondition) || (substate == detectQuiet && rxElectricalIdle) || (substate == detectQuiet && timeOut))
        begin
            enableTimer = 1'b0;
            resetTimer  = 1'b0;
            nextState = success;
           
        end
        else if(timeOut)
	begin
	nextState = failed;
	end	
        else nextState = counting;
    end
        success:
        begin
	    lastState = substate;
            resetOsCheckers = 16'b0;
            enableTimer = 1'b0;
            resetTimer = 1'b0;
            finish = 1'b1;
            exitTo =  forcedetectflag? detectActive : substate + 1'b1;
            nextState = start;
        end
        failed:
        begin
            lastState = substate;
            resetOsCheckers = 16'b0;
            enableTimer = 1'b0;
            resetTimer = 1'b0;
            finish = 1'b1;
            exitTo = detectQuiet;
            nextState = start;
        end
        default:
        begin
            nextState = start;
            enableTimer = 1'b0;
            resetTimer = 1'b0;
            resetOsCheckers = 16'b0;
        end
        

    
        endcase
    end
    


always@(*)
begin
    if(numberOfDetectedLanes==5'd1)       comparatorsCondition = 16'd1;
    else if(numberOfDetectedLanes == 5'd2)comparatorsCondition = {{14{1'b0}},{2{1'b1}}};
    else if(numberOfDetectedLanes == 5'd4)comparatorsCondition = {{12{1'b0}},{4{1'b1}}};
    else if(numberOfDetectedLanes == 5'd8)comparatorsCondition = {{8{1'b0}},{8{1'b1}}};
    else if(numberOfDetectedLanes == 5'd16)comparatorsCondition= {16{1'b1}};
    else comparatorsCondition = 16'd0;
end

endmodule