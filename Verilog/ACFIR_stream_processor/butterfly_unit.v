module butterfly_unit(
        input clk,
        input rst,
        input xn2, xp, xpp,
        input yn2, yp, ypp, //booth coding input
        input [13:0]P,
        output o1_n2, o1_p, o1_pp,
        output o2_n2, o2_p, o2_pp
    );

wire [7:0] Mn2, Mp, Mpp; // partial product
reg [7:0] RMn2, RMp, RMpp; // Shift Right Register for M
reg [7:0] RXn2, RXp, RXpp; // Shift Right Register for X
reg [2:0] cnt;

always @ (posedge clk) begin
    if(rst) begin
        cnt <= 0;
    end else begin
        cnt <= cnt + 1;
    end
end

// Instance of Booth multipler
mrHY4_serial_multiplier BU_MUL(
    .clk(clk),
    .rst(rst),
    .cnt(cnt),
    .P(P),
    .Mn2(Mn2), .Mp(Mp), .Mpp(Mpp)
);

// Shift Right Register for input X
always @ (posedge clk) begin:SRR_X
    if(rst) begin
        RXn2 <= 'b0;
        RXp <= 'b0;
        RXpp <= 'b0;
    end else begin
        RXn2 <= {xn2, RXn2[7:1]};
        RXp <= {xp, RXp[7:1]};
        RXpp <= {xpp, RXpp[7:1]};
    end
end

// Shift Right Register for partial product M
always @ (posedge clk) begin:SRR_M
    if(rst) begin
        RMn2 <= 'b0;
        RMp <= 'b0;
        RMpp <= 'b0;
    end else if(cnt == 7) begin //load in parallel
        RMn2 <= {BU_MUL.Sn2[7:3], BU_MUL.Un2[2:0]};
        RMp <= {BU_MUL.Sp[7:3], BU_MUL.Up[2:0]};
        RMpp <= {BU_MUL.Spp[7:3], BU_MUL.Upp[2:0]};
    end else begin
        RMn2 <= {1'b0, RMn2[7:1]};
        RMp <= {1'b0, RMp[7:1]};
        RMpp <= {1'b0, RMpp[7:1]};
    end
end

// Instance of adder
mrHY4_Add BU_ADD(
    .clk(clk),
    .rst(rst),
    .xn2(RXn2[0]), .xp(RXp[0]), .xpp(RXpp[0]),
    .yn2(RMn2[0]), .yp(RMp[0]), .ypp(RMpp[0]),
    .sn2(o1_n2), .sp(o1_p), .spp(o1_pp)
);
// Instance of subtracter
mrHY4_Sub BU_SUB(
    .clk(clk),
    .rst(rst),
    .xn2(RXn2[0]), .xp(RXp[0]), .xpp(RXpp[0]),
    .yn2(RMn2[0]), .yp(RMp[0]), .ypp(RMpp[0]),
    .sn2(o2_n2), .sp(o2_p), .spp(o2_pp)
);

endmodule


