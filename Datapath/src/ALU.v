module ALU  // ARITHMETIC UNIT

#(
	parameter WIDTH = 32
)
(
	input		[WIDTH-1: 0]	data_a, data_b,
	input		[2: 0]	select,
	output reg [WIDTH-1: 0] y
);		 


always @ (*)
begin
y = 32'b0;
case (select)
//6'b00000_0:	y = a;
//6'b00000_1:	y = a + 1'b1;
3'b001:	y = data_a + data_b;
//6'b00001_1:	y = a + b + 1'b1;
//6'b00010_0:	y = a + ~b;
//6'b00010_1:	y = a + (~b) + 1'b1;
//6'b00011_0:	y = a - 1'b1;
//6'b00011_1:	y = b;
3'b010:	y = data_a & data_b;
3'b011:	y = data_a | data_b;
3'b100: y = data_a ^ data_b;
//6'b00111_0:	y = ~a;
3'b101:	y = data_a << 1;
3'b110:	y = data_a >> 1;			// 16
3'b111:	y = 0;            // 24
default:		y = 4'b0;
endcase
end
endmodule
