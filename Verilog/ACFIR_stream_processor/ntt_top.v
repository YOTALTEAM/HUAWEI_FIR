`timescale 1ns / 1ps
module ntt_top
#(parameter
    N = 128,
    LOGN = $clog2(N),
    CNT_END = 8 * (LOGN + 1),
    BU_NUM = N >> 1
)(
    input clk,
	input load,
    input start,
	input [47:0] din,
    input [12:0] ppgo0,
    input [12:0] ppgo1,
    input [12:0] ppgo2,
    input [12:0] ppgo3,
    input [12:0] ppgo4,
    input [12:0] ppgo5,
    input [12:0] ppgo6,
    input [12:0] ppgo7,
    input [12:0] ppgo8,
    input [12:0] ppgo9,
    input [12:0] ppgo10,
    input [12:0] ppgo11,
    input [12:0] ppgo12,
    input [12:0] ppgo13,
    input [12:0] ppgo14,
    input [12:0] ppgo15,
    input [12:0] ppgo16,
    input [12:0] ppgo17,
    input [12:0] ppgo18,
    input [12:0] ppgo19,
    input [12:0] ppgo20,
    input [12:0] ppgo21,
    input [12:0] ppgo22,
    input [12:0] ppgo23,
    input [12:0] ppgo24,
    input [12:0] ppgo25,
    input [12:0] ppgo26,
    input [12:0] ppgo27,
    input [12:0] ppgo28,
    input [12:0] ppgo29,
    input [12:0] ppgo30,
    input [12:0] ppgo31,
    input [12:0] ppgo32,
    input [12:0] ppgo33,
    input [12:0] ppgo34,
    input [12:0] ppgo35,
    input [12:0] ppgo36,
    input [12:0] ppgo37,
    input [12:0] ppgo38,
    input [12:0] ppgo39,
    input [12:0] ppgo40,
    input [12:0] ppgo41,
    input [12:0] ppgo42,
    input [12:0] ppgo43,
    input [12:0] ppgo44,
    input [12:0] ppgo45,
    input [12:0] ppgo46,
    input [12:0] ppgo47,
    input [12:0] ppgo48,
    input [12:0] ppgo49,
    input [12:0] ppgo50,
    input [12:0] ppgo51,
    input [12:0] ppgo52,
    input [12:0] ppgo53,
    input [12:0] ppgo54,
    input [12:0] ppgo55,
    input [12:0] ppgo56,
    input [12:0] ppgo57,
    input [12:0] ppgo58,
    input [12:0] ppgo59,
    input [12:0] ppgo60,
    input [12:0] ppgo61,
    input [12:0] ppgo62,
    input [12:0] ppgo63,

//	output done,
    output  [31:0]one_out0, one_out1,
    output  [31:0]onen_out0, onen_out1,
    output  [31:0]two_out0, two_out1,
    output  [31:0]twon_out0, twon_out1

//	output reg [BU_NUM-1:0] one, 
//	output reg [BU_NUM-1:0] onen, 
//	output reg [BU_NUM-1:0] two, 
//	output reg [BU_NUM-1:0] twon
);

reg [8*N-1:0] On2;
reg [8*N-1:0] Op;
reg [8*N-1:0] Opp;
wire done;
reg [BU_NUM-1:0] zero;
reg [N-1:0] dn2, dp, dpp;
wire [N-1:0] on2, op, opp;
wire [BU_NUM-1:0] wn2, wp, wpp;
wire [14*BU_NUM-1:0] P;
reg [31:0] Dn2, Dp, Dpp;
reg [8*N-1:0] RDn2, RDp, RDpp;
reg [6:0] cnt;

reg [BU_NUM-1:0] one;
reg [BU_NUM-1:0] onen; 
reg [BU_NUM-1:0] two;
reg [BU_NUM-1:0] twon;


assign one_out0 = one[31:0];
assign onen_out0 = onen[31:0];
assign two_out0 = two[31:0];
assign twon_out0 = twon[31:0];
assign one_out1 = one[63:32];
assign onen_out1 = onen[63:32];
assign two_out1 = two[63:32];
assign twon_out1 = twon[63:32];

assign P[13:0] = zero[0] ? 'b0 : {twon[0] | onen[0], ppgo0[12] | onen[0], ppgo0[11:1], ppgo0[0] | twon[0]};
assign P[27:14] = zero[1] ? 'b0 : {twon[1] | onen[1], ppgo1[12] | onen[1], ppgo1[11:1], ppgo1[0] | twon[1]};
assign P[41:28] = zero[2] ? 'b0 : {twon[2] | onen[2], ppgo2[12] | onen[2], ppgo2[11:1], ppgo2[0] | twon[2]};
assign P[55:42] = zero[3] ? 'b0 : {twon[3] | onen[3], ppgo3[12] | onen[3], ppgo3[11:1], ppgo3[0] | twon[3]};
assign P[69:56] = zero[4] ? 'b0 : {twon[4] | onen[4], ppgo4[12] | onen[4], ppgo4[11:1], ppgo4[0] | twon[4]};
assign P[83:70] = zero[5] ? 'b0 : {twon[5] | onen[5], ppgo5[12] | onen[5], ppgo5[11:1], ppgo5[0] | twon[5]};
assign P[97:84] = zero[6] ? 'b0 : {twon[6] | onen[6], ppgo6[12] | onen[6], ppgo6[11:1], ppgo6[0] | twon[6]};
assign P[111:98] = zero[7] ? 'b0 : {twon[7] | onen[7], ppgo7[12] | onen[7], ppgo7[11:1], ppgo7[0] | twon[7]};
assign P[125:112] = zero[8] ? 'b0 : {twon[8] | onen[8], ppgo8[12] | onen[8], ppgo8[11:1], ppgo8[0] | twon[8]};
assign P[139:126] = zero[9] ? 'b0 : {twon[9] | onen[9], ppgo9[12] | onen[9], ppgo9[11:1], ppgo9[0] | twon[9]};
assign P[153:140] = zero[10] ? 'b0 : {twon[10] | onen[10], ppgo10[12] | onen[10], ppgo10[11:1], ppgo10[0] | twon[10]};
assign P[167:154] = zero[11] ? 'b0 : {twon[11] | onen[11], ppgo11[12] | onen[11], ppgo11[11:1], ppgo11[0] | twon[11]};
assign P[181:168] = zero[12] ? 'b0 : {twon[12] | onen[12], ppgo12[12] | onen[12], ppgo12[11:1], ppgo12[0] | twon[12]};
assign P[195:182] = zero[13] ? 'b0 : {twon[13] | onen[13], ppgo13[12] | onen[13], ppgo13[11:1], ppgo13[0] | twon[13]};
assign P[209:196] = zero[14] ? 'b0 : {twon[14] | onen[14], ppgo14[12] | onen[14], ppgo14[11:1], ppgo14[0] | twon[14]};
assign P[223:210] = zero[15] ? 'b0 : {twon[15] | onen[15], ppgo15[12] | onen[15], ppgo15[11:1], ppgo15[0] | twon[15]};
assign P[237:224] = zero[16] ? 'b0 : {twon[16] | onen[16], ppgo16[12] | onen[16], ppgo16[11:1], ppgo16[0] | twon[16]};
assign P[251:238] = zero[17] ? 'b0 : {twon[17] | onen[17], ppgo17[12] | onen[17], ppgo17[11:1], ppgo17[0] | twon[17]};
assign P[265:252] = zero[18] ? 'b0 : {twon[18] | onen[18], ppgo18[12] | onen[18], ppgo18[11:1], ppgo18[0] | twon[18]};
assign P[279:266] = zero[19] ? 'b0 : {twon[19] | onen[19], ppgo19[12] | onen[19], ppgo19[11:1], ppgo19[0] | twon[19]};
assign P[293:280] = zero[20] ? 'b0 : {twon[20] | onen[20], ppgo20[12] | onen[20], ppgo20[11:1], ppgo20[0] | twon[20]};
assign P[307:294] = zero[21] ? 'b0 : {twon[21] | onen[21], ppgo21[12] | onen[21], ppgo21[11:1], ppgo21[0] | twon[21]};
assign P[321:308] = zero[22] ? 'b0 : {twon[22] | onen[22], ppgo22[12] | onen[22], ppgo22[11:1], ppgo22[0] | twon[22]};
assign P[335:322] = zero[23] ? 'b0 : {twon[23] | onen[23], ppgo23[12] | onen[23], ppgo23[11:1], ppgo23[0] | twon[23]};
assign P[349:336] = zero[24] ? 'b0 : {twon[24] | onen[24], ppgo24[12] | onen[24], ppgo24[11:1], ppgo24[0] | twon[24]};
assign P[363:350] = zero[25] ? 'b0 : {twon[25] | onen[25], ppgo25[12] | onen[25], ppgo25[11:1], ppgo25[0] | twon[25]};
assign P[377:364] = zero[26] ? 'b0 : {twon[26] | onen[26], ppgo26[12] | onen[26], ppgo26[11:1], ppgo26[0] | twon[26]};
assign P[391:378] = zero[27] ? 'b0 : {twon[27] | onen[27], ppgo27[12] | onen[27], ppgo27[11:1], ppgo27[0] | twon[27]};
assign P[405:392] = zero[28] ? 'b0 : {twon[28] | onen[28], ppgo28[12] | onen[28], ppgo28[11:1], ppgo28[0] | twon[28]};
assign P[419:406] = zero[29] ? 'b0 : {twon[29] | onen[29], ppgo29[12] | onen[29], ppgo29[11:1], ppgo29[0] | twon[29]};
assign P[433:420] = zero[30] ? 'b0 : {twon[30] | onen[30], ppgo30[12] | onen[30], ppgo30[11:1], ppgo30[0] | twon[30]};
assign P[447:434] = zero[31] ? 'b0 : {twon[31] | onen[31], ppgo31[12] | onen[31], ppgo31[11:1], ppgo31[0] | twon[31]};
assign P[461:448] = zero[32] ? 'b0 : {twon[32] | onen[32], ppgo32[12] | onen[32], ppgo32[11:1], ppgo32[0] | twon[32]};
assign P[475:462] = zero[33] ? 'b0 : {twon[33] | onen[33], ppgo33[12] | onen[33], ppgo33[11:1], ppgo33[0] | twon[33]};
assign P[489:476] = zero[34] ? 'b0 : {twon[34] | onen[34], ppgo34[12] | onen[34], ppgo34[11:1], ppgo34[0] | twon[34]};
assign P[503:490] = zero[35] ? 'b0 : {twon[35] | onen[35], ppgo35[12] | onen[35], ppgo35[11:1], ppgo35[0] | twon[35]};
assign P[517:504] = zero[36] ? 'b0 : {twon[36] | onen[36], ppgo36[12] | onen[36], ppgo36[11:1], ppgo36[0] | twon[36]};
assign P[531:518] = zero[37] ? 'b0 : {twon[37] | onen[37], ppgo37[12] | onen[37], ppgo37[11:1], ppgo37[0] | twon[37]};
assign P[545:532] = zero[38] ? 'b0 : {twon[38] | onen[38], ppgo38[12] | onen[38], ppgo38[11:1], ppgo38[0] | twon[38]};
assign P[559:546] = zero[39] ? 'b0 : {twon[39] | onen[39], ppgo39[12] | onen[39], ppgo39[11:1], ppgo39[0] | twon[39]};
assign P[573:560] = zero[40] ? 'b0 : {twon[40] | onen[40], ppgo40[12] | onen[40], ppgo40[11:1], ppgo40[0] | twon[40]};
assign P[587:574] = zero[41] ? 'b0 : {twon[41] | onen[41], ppgo41[12] | onen[41], ppgo41[11:1], ppgo41[0] | twon[41]};
assign P[601:588] = zero[42] ? 'b0 : {twon[42] | onen[42], ppgo42[12] | onen[42], ppgo42[11:1], ppgo42[0] | twon[42]};
assign P[615:602] = zero[43] ? 'b0 : {twon[43] | onen[43], ppgo43[12] | onen[43], ppgo43[11:1], ppgo43[0] | twon[43]};
assign P[629:616] = zero[44] ? 'b0 : {twon[44] | onen[44], ppgo44[12] | onen[44], ppgo44[11:1], ppgo44[0] | twon[44]};
assign P[643:630] = zero[45] ? 'b0 : {twon[45] | onen[45], ppgo45[12] | onen[45], ppgo45[11:1], ppgo45[0] | twon[45]};
assign P[657:644] = zero[46] ? 'b0 : {twon[46] | onen[46], ppgo46[12] | onen[46], ppgo46[11:1], ppgo46[0] | twon[46]};
assign P[671:658] = zero[47] ? 'b0 : {twon[47] | onen[47], ppgo47[12] | onen[47], ppgo47[11:1], ppgo47[0] | twon[47]};
assign P[685:672] = zero[48] ? 'b0 : {twon[48] | onen[48], ppgo48[12] | onen[48], ppgo48[11:1], ppgo48[0] | twon[48]};
assign P[699:686] = zero[49] ? 'b0 : {twon[49] | onen[49], ppgo49[12] | onen[49], ppgo49[11:1], ppgo49[0] | twon[49]};
assign P[713:700] = zero[50] ? 'b0 : {twon[50] | onen[50], ppgo50[12] | onen[50], ppgo50[11:1], ppgo50[0] | twon[50]};
assign P[727:714] = zero[51] ? 'b0 : {twon[51] | onen[51], ppgo51[12] | onen[51], ppgo51[11:1], ppgo51[0] | twon[51]};
assign P[741:728] = zero[52] ? 'b0 : {twon[52] | onen[52], ppgo52[12] | onen[52], ppgo52[11:1], ppgo52[0] | twon[52]};
assign P[755:742] = zero[53] ? 'b0 : {twon[53] | onen[53], ppgo53[12] | onen[53], ppgo53[11:1], ppgo53[0] | twon[53]};
assign P[769:756] = zero[54] ? 'b0 : {twon[54] | onen[54], ppgo54[12] | onen[54], ppgo54[11:1], ppgo54[0] | twon[54]};
assign P[783:770] = zero[55] ? 'b0 : {twon[55] | onen[55], ppgo55[12] | onen[55], ppgo55[11:1], ppgo55[0] | twon[55]};
assign P[797:784] = zero[56] ? 'b0 : {twon[56] | onen[56], ppgo56[12] | onen[56], ppgo56[11:1], ppgo56[0] | twon[56]};
assign P[811:798] = zero[57] ? 'b0 : {twon[57] | onen[57], ppgo57[12] | onen[57], ppgo57[11:1], ppgo57[0] | twon[57]};
assign P[825:812] = zero[58] ? 'b0 : {twon[58] | onen[58], ppgo58[12] | onen[58], ppgo58[11:1], ppgo58[0] | twon[58]};
assign P[839:826] = zero[59] ? 'b0 : {twon[59] | onen[59], ppgo59[12] | onen[59], ppgo59[11:1], ppgo59[0] | twon[59]};
assign P[853:840] = zero[60] ? 'b0 : {twon[60] | onen[60], ppgo60[12] | onen[60], ppgo60[11:1], ppgo60[0] | twon[60]};
assign P[867:854] = zero[61] ? 'b0 : {twon[61] | onen[61], ppgo61[12] | onen[61], ppgo61[11:1], ppgo61[0] | twon[61]};
assign P[881:868] = zero[62] ? 'b0 : {twon[62] | onen[62], ppgo62[12] | onen[62], ppgo62[11:1], ppgo62[0] | twon[62]};
assign P[895:882] = zero[63] ? 'b0 : {twon[63] | onen[63], ppgo63[12] | onen[63], ppgo63[11:1], ppgo63[0] | twon[63]};

routing_map
#(.N(N))
MAP(
    .clk(clk),
    .rst(start),
    .dn2(dn2), .dp(dp), .dpp(dpp),
    .P(P),
    .on2(on2), .op(op), .opp(opp),
    .wn2(wn2), .wp(wp), .wpp(wpp)
);

always @ (*) begin: D2Red
	integer j, k;
    Dpp[0] = 1'b0;
    Dpp[8] = 1'b0;
    Dpp[16] = 1'b0;
    Dpp[24] = 1'b0;
    for(j = 0; j < 6; j = j + 1) begin
        Dn2[j] = din[2*j+1];
        Dn2[j+8] = din[2*j+13];
        Dn2[j+16] = din[2*j+25];
        Dn2[j+24] = din[2*j+37];
        Dp[j] = din[2*j];
        Dp[j+8] = din[2*j+12];
        Dp[j+16] = din[2*j+24];
        Dp[j+24] = din[2*j+36];
        if(j > 0) begin
	       Dpp[j] = din[2*j-1];
	       Dpp[j+8] = din[2*j+11];
	       Dpp[j+16] = din[2*j+23];
	       Dpp[j+24] = din[2*j+35];
		end
    end
	Dn2[7:6] = 'b0;
	Dp[7:6] = 'b0;
	Dpp[6] = din[11];
	Dpp[7] = 'b0;

	Dn2[15:14] = 'b0;
	Dp[15:14] = 'b0;
	Dpp[14] = din[23];
	Dpp[15] = 'b0;

	Dn2[23:22] = 'b0;
	Dp[23:22] = 'b0;
	Dpp[22] = din[35];
	Dpp[23] = 'b0;

	Dn2[31:30] = 'b0;
	Dp[31:30] = 'b0;
	Dpp[30] = din[47];
	Dpp[31] = 'b0;
end
always @ (*) begin: boothin
	integer i;
    for(i = 0; i < BU_NUM; i = i + 1) begin
        case({wn2[i], wp[i], wpp[i]})
            3'b000: begin one[i] = 0; onen[i] = 0; two[i] = 0; twon[i] = 0; zero[i] = 1; end
            3'b001: begin one[i] = 1; onen[i] = 0; two[i] = 0; twon[i] = 0; zero[i] = 0; end
            3'b010: begin one[i] = 1; onen[i] = 0; two[i] = 0; twon[i] = 0; zero[i] = 0; end
            3'b011: begin one[i] = 0; onen[i] = 0; two[i] = 1; twon[i] = 0; zero[i] = 0; end
            3'b100: begin one[i] = 0; onen[i] = 0; two[i] = 0; twon[i] = 1; zero[i] = 0; end
            3'b101: begin one[i] = 0; onen[i] = 1; two[i] = 0; twon[i] = 0; zero[i] = 0; end
            3'b110: begin one[i] = 0; onen[i] = 1; two[i] = 0; twon[i] = 0; zero[i] = 0; end
            3'b111: begin one[i] = 0; onen[i] = 0; two[i] = 0; twon[i] = 0; zero[i] = 1; end
        endcase
    end
    
end

always @ (posedge clk) begin
    if(start) begin
        cnt <= 0;
    end else begin
        cnt <= cnt + 1;
    end
end

assign done = (cnt == CNT_END);

always @ (posedge clk) begin
	if(load) begin
		RDn2 <= {Dn2, RDn2[8*N-1:32]};
		RDp <= {Dp, RDp[8*N-1:32]};
		RDpp <= {Dpp, RDpp[8*N-1:32]};
	end
    else if(start) begin
        On2 <= 'b0;
        Op <= 'b0;
        Opp <= 'b0;		
    end else begin: load2rdg
		integer i;
        for(i = 0; i < N; i = i + 1) begin
            RDn2[8*i+:8] <= {1'b0, RDn2[8*i+1+:7]};
            RDp[8*i+:8] <= {1'b0, RDp[8*i+1+:7]};
            RDpp[8*i+:8] <= {1'b0, RDpp[8*i+1+:7]};
            On2[8*i+:8] <= {on2[i], On2[8*i+1+:7]};
            Op[8*i+:8] <= {op[i], On2[8*i+1+:7]};
            Opp[8*i+:8] <= {opp[i],On2[8*i+1+:7]};
        end
    end
end

always @ (*) begin
    if(cnt < 8) begin:first_stage_in
		integer i;
        for(i = 0; i < N; i = i + 1) begin
            dn2[i] = RDn2[8*i+:1];
            dp[i] = RDp[8*i+:1];
            dpp[i] = RDpp[8*i+:1];
        end
    end
    else begin: stage_in
		integer i;
        for(i = 0; i < N; i = i + 1) begin
            dn2[i] = on2[i];
            dp[i] = op[i];
            dpp[i] = opp[i];
        end 
    end
end 

endmodule


