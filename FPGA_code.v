//-------------main code for FPGA----------
module FPGA(clk,rst,CLB1,CLB2,CLB3,CLB4,Sel_CLB,Sel_dat,Out);
input clk,rst,Sel_dat;
input [1:0]CLB1;
input [1:0]CLB2;
input [1:0]CLB3;
input [1:0]CLB4;
input [1:0]Sel_CLB;
output Out;

//wires to connect the CLBS out
wire wr_clb1,wr_clb2,wr_clb3,wr_clb4;

//wire for connecting switch inputs of CLBS
wire [3:0]wr_connect;

//assign wires out put of clb to the input of the switch
assign wr_connect[0]=wr_clb1;
assign wr_connect[1]=wr_clb2;
assign wr_connect[2]=wr_clb3;
assign wr_connect[3]=wr_clb4;

//connect all the modules
CLB_1 fpga1(.LUT(CLB1),.clk(clk),.rst(rst),.sel1(Sel_dat),.OUT_PUT(wr_clb1));
CLB_2 fpga2(.LUT(CLB2),.clk(clk),.rst(rst),.sel1(Sel_dat),.OUT_PUT(wr_clb2));
CLB_3 fpga3(.LUT(CLB3),.clk(clk),.rst(rst),.sel1(Sel_dat),.OUT_PUT(wr_clb3));
CLB_4 fpga4(.LUT(CLB4),.clk(clk),.rst(rst),.sel1(Sel_dat),.OUT_PUT(wr_clb4));
switch fpga_sw(.in(wr_connect),.sel_clb(Sel_CLB),.out(Out));
endmodule

//---------------main code for the CLB1----------
module CLB_1(LUT,clk,rst,sel1,OUT_PUT);
input [1:0]LUT;
input clk,rst,sel1;
output OUT_PUT;

//wire for connecting the LUT,Dflip-flops & mux
wire wr_LUT,wr_dff;

//connecting the modules
LUTS CLB11(.LUT(LUT),.OUT(wr_LUT));
Dflip CLB12(.D(wr_LUT),.clk(clk),.Q(wr_dff));
mux CLB13(.S1(wr_LUT),.S2(wr_dff),.sel(sel1),.OUT_mux(OUT_PUT));
endmodule

//-------------main code for the CLB2------------
module CLB_2(LUT,clk,rst,sel1,OUT_PUT);
input [1:0]LUT;
input clk,rst,sel1;
output OUT_PUT;

//wire for connecting the LUT,Dflip-flops & mux
wire wr_LUT,wr_dff;

//connecting the modules
LUTS CLB11(.LUT(LUT),.OUT(wr_LUT));
Dflip CLB12(.D(wr_LUT),.clk(clk),.Q(wr_dff));
mux CLB13(.S1(wr_LUT),.S2(wr_dff),.sel(sel1),.OUT_mux(OUT_PUT));
endmodule

//-------------main code for the CLB3---------------
module CLB_3(LUT,clk,rst,sel1,OUT_PUT);
input [1:0]LUT;
input clk,rst,sel1;
output OUT_PUT;

//wire for connecting the LUT,Dflip-flops & mux
wire wr_LUT,wr_dff;

//connecting the modules
LUTS CLB11(.LUT(LUT),.OUT(wr_LUT));
Dflip CLB12(.D(wr_LUT),.clk(clk),.Q(wr_dff));
mux CLB13(.S1(wr_LUT),.S2(wr_dff),.sel(sel1),.OUT_mux(OUT_PUT));
endmodule

//------------main code for the CLB4----------
module CLB_4(LUT,clk,rst,sel1,OUT_PUT);
input [1:0]LUT;
input clk,rst,sel1;
output OUT_PUT;

//wire for connecting the LUT,Dflip-flops & mux
wire wr_LUT,wr_dff;

//connecting the modules
LUTS CLB11(.LUT(LUT),.OUT(wr_LUT));
Dflip CLB12(.D(wr_LUT),.clk(clk),.Q(wr_dff));
mux CLB13(.S1(wr_LUT),.S2(wr_dff),.sel(sel1),.OUT_mux(OUT_PUT));
endmodule

//-----------module for the LUT (look up table)---------
module LUTS(LUT,OUT);
input[1:0]LUT;
output reg OUT;
always @(LUT) begin
if(LUT==2'b01 || LUT == 2'b10)begin
OUT=1'b1;
end
else begin
OUT=1'b0;
end
end
endmodule

//--------module for D-flip-flop inside a CLB-----------
module Dflip(D,clk,Q);
input D,clk;
output reg Q;
always@(posedge clk)begin
Q=D;
end
endmodule

//---------module for mux inside CLB----------
module mux(S1,S2,sel,OUT_mux);
input S1,S2,sel;
output OUT_mux;

//wire to connect with the and gates & not gate for the mux
wire and1,and2,sel_not;
assign sel_not=~sel;
assign and1= sel_not & S1;
assign and2= sel & S2;
assign OUT_mux=and1 | and2;
endmodule

//---------module for Switch matrix inside the FPGA for connecting the CLBS-------------
module switch(in,sel_clb,out);
input [3:0]in;
input [1:0]sel_clb;
output out;

//wire for connecting the clbs to the input
wire sel_wrnot1,sel_wrnot2,and1,and2,and3,and4;

//assign the values
assign sel_wrnot1=~sel_clb[0],sel_wrnot2=~sel_clb[1];
assign and1= sel_wrnot2 & sel_wrnot1 & in[0];
assign and2= sel_wrnot2 & sel_clb[0] & in[1];
assign and3=sel_clb[1] & sel_wrnot1 & in[2];
assign and4=sel_clb[1] & sel_clb[0] & in[3];
assign out = and1 | and2| and3| and4;
endmodule
