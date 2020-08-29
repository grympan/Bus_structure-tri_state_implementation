module register (Clock, reset, L, bus_data, Q);
	input Clock, reset, L;
	input [7:0] bus_data;
	output reg [7:0] Q;

	always @ (posedge Clock)
		if (reset) Q <= 0;
		else if (L) Q <= bus_data;
endmodule