`timescale 1ns / 1ps

module comparater(
    input [9:0] i_counter,
    output o_light_0, o_light_1, o_light_2, o_light_3, o_light_4
    );

    assign o_light_0 = (i_counter == 0) ? 1'b1 : 1'b0;
    assign o_light_1 = (i_counter < 300) ? 1'b1 : 1'b0;
    assign o_light_2 = (i_counter < 400) ? 1'b1 : 1'b0;
    assign o_light_3 = (i_counter < 600) ? 1'b1 : 1'b0;
    assign o_light_4 = (i_counter < 990) ? 1'b1 : 1'b0;

endmodule
