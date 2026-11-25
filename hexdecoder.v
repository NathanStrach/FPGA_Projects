module usertop (
    input         CLOCK_50, CLK_500Hz,
    input  [3:0]  RKEY, KEY,
    input  [17:0] RSW, SW,
    output [17:0] LEDR,
    output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7
);

    hexdecoder d3 (.in(SW[15:12]), .seg(HEX3)); //Hex decoder left
    hexdecoder d2 (.in(SW[11:8]),  .seg(HEX2)); //Hex decoder middle left
    hexdecoder d1 (.in(SW[7:4]),   .seg(HEX1)); //Hex decoder middle right
    hexdecoder d0 (.in(SW[3:0]),   .seg(HEX0)); //Hex decoder right

    //Keeps hexes [7:4] off 
    assign HEX4 = 7'b1111111;
    assign HEX5 = 7'b1111111;
    assign HEX6 = 7'b1111111;
    assign HEX7 = 7'b1111111;
    assign LEDR = SW;

endmodule


module hexdecoder (
    input  [3:0] in,
    output [6:0] seg
);

    wire A = in[3];
    wire B = in[2];
    wire C = in[1];
    wire D = in[0];

    // Segment a
    assign seg[0] = ~( (A & ~D) | (~B & ~C & ~D) | (A & ~B & ~C) | (B & C)
                     | (~A & C) | (~A & B & C) | (~A & B & D) );

    // Segment b
    assign seg[1] = ~( (~A & ~C & ~D) | (A & ~C & D) | (~B & C & ~D)
                     | (~A & C & D) | (~A & ~B) | (~B & ~C) );

    // Segment c
    assign seg[2] = ~( (~C & D) | (A & ~B) | (~A & B) | (~A & D) | (~A & ~C) );

    // Segment d
    assign seg[3] = ~( (A & ~C) | (B & ~C & D) | (B & C & ~D)
                     | (~A & ~B & ~D) | (~B & C & D) );

    // Segment e
    assign seg[4] = ~( (A & B) | (A & C) | (C & ~D) | (~B & ~C & ~D) );

    // Segment f
    assign seg[5] = ~( (A & ~B) | (A & C) | (B & ~D) | (~A & B & ~C) | (~C & ~D) );

    // Segment g
    assign seg[6] = ~( (A & D) | (A & ~B) | (C & ~D) | (~A & ~B & C) | (~A & B & ~C) );

endmodule
