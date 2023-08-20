module routing_map
#(parameter
    N = 32,
    BU_NUM = N >> 1
)(
    input clk,
    input rst,
    input [N-1:0] dn2, dp, dpp,
    input [14*BU_NUM-1:0] P,
    output [N-1:0] on2, op, opp,
    output reg [BU_NUM-1:0] wn2, wp, wpp 
);

reg [13:0] vP[BU_NUM-1:0];

always @ (*) begin: pack_P
	integer k;
	for(k = 0; k < BU_NUM; k = k + 1) begin
		vP[k] = P[14 * k+:14];
	end
end

genvar i;
generate
for(i = 0; i < BU_NUM; i = i + 1) begin
    butterfly_unit
    BU(
        .clk(clk),
        .rst(rst),
        .xn2(dn2[i]), .xp(dp[i]), .xpp(dpp[i]),
        .yn2(dn2[i + BU_NUM]), .yp(dp[i + BU_NUM]), .ypp(dpp[i + BU_NUM]),
        .P(vP[i]),
        .o1_n2(on2[2 * i]), .o1_p(op[2 * i]), .o1_pp(opp[2 * i]),
        .o2_n2(on2[2 * i + 1]), .o2_p(op[2 * i + 1]), .o2_pp(opp[2 * i + 1])
    );
end
endgenerate

always @ (*) begin: boothin
	integer j;
    for(j = 0; j < BU_NUM; j = j + 1) begin
        wn2[j] = dn2[j + BU_NUM];
        wp[j] = dp[j + BU_NUM];
        wpp[j] = dpp[j + BU_NUM];
    end
end 
endmodule

