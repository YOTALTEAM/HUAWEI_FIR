module mrHY4A(
    input xn2, xp, xpp,
    input yp2, yp,
    output sp4, sn2, sp
);
// FA
assign sp = xp ^ xpp ^ yp;
wire cp2;
assign cp2 = (xp & xpp) | (xpp & yp) | (yp & xp);
// PPM
assign sn2 = xn2 ^ yp2 ^ cp2;
assign sp4 = (~xn2 & yp2) | (yp2 & cp2) | (cp2 & ~xn2);
endmodule
