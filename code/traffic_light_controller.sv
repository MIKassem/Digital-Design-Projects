
module timing_counter (
    input wire clk,
    output reg [6:0] count,
    output wire SW
);

    initial begin
        count <= 0;
    end

    always @(posedge clk) begin
        if (count == 119) begin
            count = 0;
        end else begin
            count = count + 1;
        end
    end

    assign SW = (count < 50 || (count > 60 && count < 110)) ? 1'b1 : 1'b0;

endmodule

module signal_generator (
    input wire clk,
    input wire SENSOR,
    input wire [6:0] counter,
    output reg [2:0] NS, EW
);

    parameter NS_GREEN = 3'b001;
    parameter NS_YELLOW = 3'b010;
    parameter NS_RED = 3'b011;
    parameter EW_GREEN = 3'b100;
    parameter EW_YELLOW = 3'b101;
    parameter EW_RED = 3'b110;

    reg [2:0] current_state, next_state;

    initial begin
        current_state <= NS_GREEN;
    end

    always @(posedge clk) begin
        current_state <= next_state;
    end

    always @(*) begin
    always @(*) begin
        case (current_state)
            NS_GREEN: begin
            	if(SW ==1'b0 && SENSOR == 1'b1) begin
                  if(counter == 50 && counter == 110) begin
                  	next_state = NS_YELLOW;
                    end else begin
                  	next_state = NS_GREEN;
                    end
                end else begin
                    next_state = NS_GREEN;
                end   
            end
            NS_YELLOW: begin
            	if (sw == 1'b1) next_state = NS_RED;
                else next_state = NS_YELLOW;
            end
            NS_RED: begin
            	if (sw == 1'b1) next_state = EW_GREEN;
                else next_state = NS_RED;
            end
            EW_GREEN: begin
            	if (sw == 1'b0) next_state = EW_YELLOW;
                else next_state = EW_GREEN;
            end
            EW_YELLOW: begin
            	if (sw == 1'b1) next_state = EW_RED;
                else next_state = EW_YELLOW;
            end
            EW_RED: begin
            	if (sw == 1'b1) next_state = NS_GREEN;
                else next_state = EW_RED;
            end
            default: begin
                next_state = NS_GREEN;
            end
        endcase
    end
    
    always @(*) begin
    	case (current_State)
    		NS_GREEN: begin
    			NS = NS_GREEN;
    			EW = EW_RED;
    		end
    		NS_YELLOW: begin
    			NS = NS_YELLOW;
    			EW = EW_RED;
    		end
    		NS_RED: begin
    			NS = NS_RED;
    			EW = EW_GREEN;
    		end
    		EW_GREEN: begin
    			EW = EW_GREEN;
    			NS = NS_RED;
    		end
    		EW_YELLOW: begin
    			EW = EW_YELLOW;
    			NS = NS_RED;
    		end
    		default: begin
    			NS = NS_GREEN;
    			EW = EW_RED;
		end
	endcase
	end
endmodule
