`timescale 1ns / 1ps

module Button_Controller(
    input i_clk,
    input i_button,
    input i_reset,
    output o_button
    );

    parameter PUSHED = 1'b1,
              RELEASED = 1'b0,
              TRUE = 1'b1,
              FALSE = 1'b0;
    parameter DEBOUNCE = 500_000;  //  10ms for 100MHz
    
    reg r_prevState = RELEASED;
    reg r_button;
    reg [31:0] r_counter = 0;

    assign o_button = r_button;

    always @(posedge i_clk or posedge i_reset) begin  
        if (i_reset) begin
            r_button <= FALSE;
            r_prevState <= RELEASED;
            r_counter <= 0;
        end
        else begin
            if ((i_button == PUSHED) && (r_prevState == RELEASED) && (r_counter < DEBOUNCE)) begin
                r_counter <= r_counter + 1;
                r_button <= FALSE;
            end
            else if ((i_button == PUSHED) && (r_prevState == RELEASED) && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prevState <= PUSHED;
                r_button <= FALSE;
            end
            else if ((i_button == RELEASED) && (r_prevState == PUSHED) && (r_counter < DEBOUNCE)) begin
                r_counter <= r_counter + 1;
                r_button <= FALSE;
            end
            else if ((i_button == RELEASED) && (r_prevState == PUSHED) && (r_counter == DEBOUNCE)) begin
                r_counter <= 0;
                r_prevState <= RELEASED;
                r_button <= TRUE;
            end
            else begin
                r_counter <= 0;
                r_button <= FALSE;
            end
        end
    end
endmodule
