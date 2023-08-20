module mrHY4_Sub(
    input clk,
    input rst,
    input xn2, xp, xpp,
    input yn2, yp, ypp,
    output sn2, sp, 
	output reg spp
);

reg tpp;
wire spp4, tpp4, tp, tn2;
mrHY4A SA(.xn2(xn2), .xp(xp), .xpp(xpp), .yp2(yn2), .yp(ypp), .sp4(tpp4), .sn2(tn2), .sp(tp));
mrHY4S SS(.xn2(tn2), .xp(tp), .xpp(tpp), .yn2(ypp), .yn(yp), .sp4(spp4), .sn2(sn2), .sp(sp));
always @ (posedge clk) begin
    if(rst) begin
        tpp <= 'b0;
        spp <= 'b1;
    end else begin 
        tpp <= tpp4;
        spp <= spp4;
    end
end
endmodule

