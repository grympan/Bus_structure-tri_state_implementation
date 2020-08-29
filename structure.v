module structure (Clock, reset, func, Data, bus, Q1, Q2, Q3);

input Clock, reset;
input [2:0] func;
input [7:0] Data;
wire R1out, R1in, R2out, R2in, R3out, R3in, Extern;
output wire [7:0] bus, Q1, Q2, Q3;

register R1 (Clock, reset, R1in, bus, Q1);
register R2 (Clock, reset, R2in, bus, Q2);
register R3 (Clock, reset, R3in, bus, Q3);

buffer ExB (Data, Extern, bus);
buffer B1 (Q1, R1out, bus);
buffer B2 (Q2, R2out, bus);
buffer B3 (Q3, R3out, bus);

fsm myfsm (Clock, reset, func, R1out, R1in, R2out, R2in, R3out, R3in, Extern);

endmodule