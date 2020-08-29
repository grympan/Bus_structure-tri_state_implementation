module fsm (Clock, reset, func, R1out, R1in, R2out, R2in, R3out, R3in, Extern);

input Clock, reset;
input [2:0] func;
output reg R1out, R1in, R2out, R2in, R3out, R3in, Extern;

localparam stable = 0, swap_s1 = 1, move = 2, loadR1 = 3, loadR2 = 4, loadR3 = 5, swap_s2 = 6, swap_s3 = 7;
reg [2:0] state, nxtState;

always @ (posedge Clock) begin
	if (reset) state <= stable;
	else state <= nxtState;
end

always @(*) begin

case(state)
	stable: begin
		if(func == 1) nxtState = swap_s1;
		else if(func == 2) nxtState = move;
		else if(func == 3) nxtState = loadR1;
		else if(func == 4) nxtState = loadR2;
		else if(func == 5) nxtState = loadR3;
		else nxtState = stable;
		R1out = 0; R1in = 0; R2out = 0; R2in = 0; R3out = 0; R3in = 0; Extern = 0; end
		
	swap_s1: begin
		nxtState = swap_s2;
		R1out = 0; R1in = 0; R2out = 1; R2in = 0; R3out = 0; R3in = 1; Extern = 0; end

	move: begin
		if(func == 1) nxtState = swap_s1;
		else if(func == 2) nxtState = move;
		else if(func == 3) nxtState = loadR1;
		else if(func == 4) nxtState = loadR2;
		else if(func == 5) nxtState = loadR3;
		else nxtState = stable;
		R1out = 1; R1in = 0; R2out = 0; R2in = 1; R3out = 0; R3in = 0; Extern = 0; end

	loadR1: begin
		if(func == 1) nxtState = swap_s1;
		else if(func == 2) nxtState = move;
		else if(func == 3) nxtState = loadR1;
		else if(func == 4) nxtState = loadR2;
		else if(func == 5) nxtState = loadR3;
		else nxtState = stable;
		R1out = 0; R1in = 1; R2out = 0; R2in = 0; R3out = 0; R3in = 0; Extern = 1; end

	loadR2: begin 
		if(func == 1) nxtState = swap_s1;
		else if(func == 2) nxtState = move;
		else if(func == 3) nxtState = loadR1;
		else if(func == 4) nxtState = loadR2;
		else if(func == 5) nxtState = loadR3;
		else nxtState = stable;
		R1out = 0; R1in = 0; R2out = 0; R2in = 1; R3out = 0; R3in = 0; Extern = 1; end

	loadR3: begin
		if(func == 1) nxtState = swap_s1;
		else if(func == 2) nxtState = move;
		else if(func == 3) nxtState = loadR1;
		else if(func == 4) nxtState = loadR2;
		else if(func == 5) nxtState = loadR3;
		else nxtState = stable;
		R1out = 0; R1in = 0; R2out = 0; R2in = 0; R3out = 0; R3in = 1; Extern = 1; end

	swap_s2: begin
		nxtState = swap_s3;
		R1out = 1; R1in = 0; R2out = 0; R2in = 1; R3out = 0; R3in = 0; Extern = 0; end

	swap_s3: begin
		if(func == 1) nxtState = swap_s3;
		else if(func == 2) nxtState = move;
		else if(func == 3) nxtState = loadR1;
		else if(func == 4) nxtState = loadR2;
		else if(func == 5) nxtState = loadR3;
		else nxtState = stable;
		R1out = 0; R1in = 1; R2out = 0; R2in = 0; R3out = 1; R3in = 0; Extern = 0; end
endcase
end
endmodule