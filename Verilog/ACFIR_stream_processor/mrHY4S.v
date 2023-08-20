module mrHY4S(
    input xn2, xp, xpp,
    input yn2, yn,
    output sp4, sn2, sp
);
wire sn4, sp2, sn;
// PPM
assign sn = xp ^ xpp ^ yn;
wire cp2;
assign cp2 = (xp & xpp) | (xpp & ~yn) | (~yn & xp);
// MMP
assign sp2 = xn2 ^ yn2 ^ cp2;
assign sn4 = (xn2 & yn2) | (yn2 & ~cp2) | (~cp2 & xn2);
// Result of subtraction is invert by bit
assign {sp4, sn2, sp} = {~sn4, ~sp2, ~sn};
endmodule
