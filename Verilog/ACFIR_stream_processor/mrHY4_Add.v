module mrHY4_Add(
    input clk,
    input rst,
    input xn2, xp, xpp,
    input yn2, yp, ypp,
    output sn2, sp, 
	output reg spp
);

wire tpp4, spp4, tn2, tp;
reg tpp;

mrHY4A AA(.xn2(xn2), .xp(xp), .xpp(xpp), .yp2(ypp), .yp(yp), .sp4(tpp4), .sn2(tn2), .sp(tp));
mrHY4S AS(.xn2(tn2), .xp(tp), .xpp(tpp), .yn2(yn2), .yn(ypp), .sp4(spp4), .sn2(sn2), .sp(sp));
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

