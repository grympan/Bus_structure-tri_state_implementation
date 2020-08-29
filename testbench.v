module stimulus;

reg Clock, reset;
reg [2:0] func;
reg [7:0] Data;
wire [7:0] bus, Q1, Q2, Q3;

structure myst (Clock, reset, func, Data, bus, Q1, Q2, Q3);

initial
begin

Clock = 0;
func=0; reset=1; #5
reset=0; #5

// R1=1, R2=2, R3=3 초기 세팅
func=3; Data=1; #5
func=0; #5
func=4; Data=2; #5
func=0; #5
func=5; Data=3; #5
func=0; #5

func=1; #10

// R3=4 세팅 (뒤에 나올 move에서 bus값 변화 보여주기 위해)
func=5; Data=4; #5

func=2; #10;

end

always begin
#1 Clock = ~Clock;
end

endmodule