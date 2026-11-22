// Part A: write module motion_cell here.
and  g1 (y, a, b);       // OUTPUT FIRST, then inputs
or   g2 (w1, a, b, c);    // any number of inputs
not  g3 (w2, a);
nand (w3, a, b);          // instance name optional
// also: nor  xor  xnor  buf

or g1 (x, a, b);
not g2 (x1, x);
or g3 (y, b, c);
not g4 (y1, y);
or g5 (d, x1, y1);


