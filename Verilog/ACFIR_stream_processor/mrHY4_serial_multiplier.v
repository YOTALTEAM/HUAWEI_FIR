module mrHY4_serial_multiplier(
    input clk,
    input rst,
    input [13:0] P,
    input [2:0] cnt,
    output reg [7:0] Mn2, Mp, Mpp
);

wire [7:0] Un2, Up, Upp;
assign Upp[0] = P[13];
mrHY4A AY0(.xn2(Mn2[1]), .xp(Mp[1]), .xpp(Mpp[1]), .yp2(P[1]), .yp(P[0]), .sp4(Upp[1]), .sn2(Un2[0]), .sp(Up[0]));
mrHY4A AY1(.xn2(Mn2[2]), .xp(Mp[2]), .xpp(Mpp[2]), .yp2(P[3]), .yp(P[2]), .sp4(Upp[2]), .sn2(Un2[1]), .sp(Up[1]));
mrHY4A AY2(.xn2(Mn2[3]), .xp(Mp[3]), .xpp(Mpp[3]), .yp2(P[5]), .yp(P[4]), .sp4(Upp[3]), .sn2(Un2[2]), .sp(Up[2]));
mrHY4A AY3(.xn2(Mn2[4]), .xp(Mp[4]), .xpp(Mpp[4]), .yp2(P[7]), .yp(P[6]), .sp4(Upp[4]), .sn2(Un2[3]), .sp(Up[3]));
mrHY4A AY4(.xn2(Mn2[5]), .xp(Mp[5]), .xpp(Mpp[5]), .yp2(P[9]), .yp(P[8]), .sp4(Upp[5]), .sn2(Un2[4]), .sp(Up[4]));
mrHY4A AY5(.xn2(Mn2[6]), .xp(Mp[6]), .xpp(Mpp[6]), .yp2(P[11]), .yp(P[10]), .sp4(Upp[6]), .sn2(Un2[5]), .sp(Up[5]));
mrHY4A AY6(.xn2(Mn2[7]), .xp(Mp[7]), .xpp(Mpp[7]), .yp2(P[13]), .yp(P[12]), .sp4(Upp[7]), .sn2(Un2[6]), .sp(Up[6]));
assign Un2[7] = P[13];
assign Up[7] = P[13];

reg [5:0] R;
always @ (*) begin
    case({Mn2[0], Mp[0], Mpp[0]})
        3'b000: R = 6'b000000; 
        3'b001: R = 6'b110010;
        3'b010: R = 6'b110010;
        3'b011: R = 6'b100101;
        3'b100: R = 6'b011010;
        3'b101: R = 6'b001101;
        3'b110: R = 6'b001101;
        3'b111: R = 6'b000000; 
    endcase
end

wire [7:3] Sn2, Sp, Spp;
assign Spp[3] = R[5];
mrHY4A AR3(.xn2(Un2[3]), .xp(Up[3]), .xpp(Upp[3]), .yp2(R[1]), .yp(R[0]), .sp4(Spp[4]), .sn2(Sn2[3]), .sp(Sp[3]));
mrHY4A AR4(.xn2(Un2[4]), .xp(Up[4]), .xpp(Upp[4]), .yp2(R[3]), .yp(R[2]), .sp4(Spp[5]), .sn2(Sn2[4]), .sp(Sp[4]));
mrHY4A AR5(.xn2(Un2[5]), .xp(Up[5]), .xpp(Upp[5]), .yp2(R[5]), .yp(R[4]), .sp4(Spp[6]), .sn2(Sn2[5]), .sp(Sp[5]));
mrHY4A AR6(.xn2(Un2[6]), .xp(Up[6]), .xpp(Upp[6]), .yp2(R[5]), .yp(R[5]), .sp4(Spp[7]), .sn2(Sn2[6]), .sp(Sp[6]));
//mrHY4A AR7(.xn2(Un2[7]), .xp(Up[7]), .xpp(Upp[7]), .yp2(R[5]), .yp(R[5]), .sp4(), .sn2(Sn2[7]), .sp(Sp[7]));
assign Sn2[7] = (~Upp[7] & R[5]) | (R[5] & P[13]) | (P[13] & ~Upp[7]);
assign Sp[7] = Upp[7] ^ R[5] ^ P[13];

always @ (posedge clk) begin
    if(rst || cnt == 7) begin
    //if(rst) begin
        Mn2 <= 'b0;
        Mp <= 'b0;
        Mpp <= 'b0;
    end else begin
        Mn2[7:0] <= {Sn2[7:3], Un2[2:0]};
        Mp[7:0] <= {Sp[7:3], Up[2:0]};
        Mpp[7:0] <= {Spp[7:3], Upp[2:0]};
    end
end

endmodule


