`timescale 1ns / 1ps

module Top_PWM_Light(
    input i_clk,
    input i_reset,
    input [2:0] i_button,
    output o_y
    );

    //clk
    wire w_clk;
    Clock_Divider Clock_divider(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk)
    );

    wire [9:0] w_counter;
    Counter counter(
    .i_clk(w_clk),
    .i_reset(i_reset),
    .o_counter(w_counter)
    );

    wire [4:0] w_light;
    comparater comp(
    .i_counter(w_counter),
    .o_light_0(w_light[0]),
    .o_light_1(w_light[1]),
    .o_light_2(w_light[2]),
    .o_light_3(w_light[3]),
    .o_light_4(w_light[4])
    );

    //FSM
    wire [2:0] w_button;
    Button_Controller Bt0(
    .i_clk(i_clk),
    .i_button(i_button[0]),
    .i_reset(i_reset),
    .o_button(w_button[0])         
    );

    Button_Controller Bt1(
    .i_clk(i_clk),
    .i_button(i_button[1]),
    .i_reset(i_reset),
    .o_button(w_button[1])         
    );

    Button_Controller Bt2(
    .i_clk(i_clk),
    .i_button(i_button[2]),
    .i_reset(i_reset),
    .o_button(w_button[2])         
    );

    wire [2:0] w_lightState;
    FSM fsm(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .i_button(w_button),
    .o_lightState(w_lightState)
    );

    MUX mux(
    .i_x(w_light),
    .sel(w_lightState),
    .o_y(o_y)
    );

endmodule
