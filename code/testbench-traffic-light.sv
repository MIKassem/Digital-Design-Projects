module tb;
	reg clk;
	reg SESNOR;
	wire SW;
	wire [6:0] count;
	wire [2:0] NS;
	wire [2:0] EW;
	
	timing_counter tc(
		.clk(clk),
		.count(count),
		.SW(SW)
	);
	
	signal_generator sg(
		.clk(clk)),
		.SENSOR,
		.SW(SW),
		.counter(count),
		.NS(NS),
		.EW(EW)
	);
	
	intial begin
		$dumpfile("design.vcd");
		$dumpvars(1);
		clk=0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		SENSOR = 0;
		
		#10;
		SENSOR = 0;
		
		#1000; 
		SENSOR = 1;
		
		#250;
		SENSOR = 1;
		
		#1000;
		SENSOR = 1;
