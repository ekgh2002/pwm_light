`timescale 1ns / 1ps

module FSM(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output [2:0] o_lightState
    );

    parameter   S_LIGHT_0 = 3'd000,
                S_LIGHT_1 = 3'd001,
                S_LIGHT_2 = 3'd010,
                S_LIGHT_3 = 3'd011,
                S_LIGHT_4 = 3'd100;

    reg [2:0] curState, nextState;
    reg [2:0] r_lightState;

    assign o_lightState = r_lightState;

    //상태변경
    always @(posedge i_clk or posedge i_reset) begin
        if (i_reset) curState <= S_LIGHT_0;
        else         curState <= nextState;
    end

    //event 처리
    always @(curState or i_button) begin
        case (curState)
            S_LIGHT_0 : begin
                if (i_button[0])      nextState <= S_LIGHT_1;  //up
                else                  nextState <= S_LIGHT_0;  //off 
            end
            S_LIGHT_1 : begin
                if (i_button[0])      nextState <= S_LIGHT_2;  //up
                else if (i_button[1]) nextState <= S_LIGHT_0;  //down
                else if (i_button[2]) nextState <= S_LIGHT_0;  //off 
                else                  nextState <= S_LIGHT_1;
            end
            S_LIGHT_2 : begin
                if (i_button[0])      nextState <= S_LIGHT_3;  //up
                else if (i_button[1]) nextState <= S_LIGHT_1;  //down
                else if (i_button[2]) nextState <= S_LIGHT_0;  //off 
                else                  nextState <= S_LIGHT_2;
            end
            S_LIGHT_3 : begin
                if (i_button[0])      nextState <= S_LIGHT_4;  //up
                else if (i_button[1]) nextState <= S_LIGHT_2;  //down
                else if (i_button[2]) nextState <= S_LIGHT_0;  //off 
                else                  nextState <= S_LIGHT_3;
            end
            S_LIGHT_4 : begin
                if (i_button[1])      nextState <= S_LIGHT_3;  //down
                else if (i_button[2]) nextState <= S_LIGHT_0;  //off 
                else                  nextState <= S_LIGHT_4;
            end
            // default : nextState <= S_LIGHT_0;
        endcase       
    end

    //상태에 따른 동작
    always @(curState) begin
        case (curState)
            S_LIGHT_0 : r_lightState <= 3'b000;
            S_LIGHT_1 : r_lightState <= 3'b001;
            S_LIGHT_2 : r_lightState <= 3'b010;
            S_LIGHT_3 : r_lightState <= 3'b011;
            S_LIGHT_4 : r_lightState <= 3'd100;
            default : r_lightState <= 3'b000;
        endcase
    end
endmodule
