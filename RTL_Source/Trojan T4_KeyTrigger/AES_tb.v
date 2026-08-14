module AES_tb();

wire e256;
wire d256;
reg enable;

AES a(enable, e256, d256);

initial begin
	$monitor("Encrypt256 = %b, Decrypt256 = %b", e256, d256);
		
	// Turning on enable to check that all tests passed
	enable = 1;
	#10;
	
	// Turning off enable to check if the leds turn off
	enable = 0;
	#10;
	
	// Turning on enable to check if the leds turn on again
	enable = 1;
	#10;
end

endmodule
