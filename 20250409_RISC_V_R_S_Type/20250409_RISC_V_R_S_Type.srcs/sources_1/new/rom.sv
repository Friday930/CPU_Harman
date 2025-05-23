`timescale 1ns / 1ps

module rom (
    input  logic [31:0] addr,
    output logic [31:0] data
);
    logic [31:0] rom[0:15];

    initial begin
        //rom[x]=32'b fucn7 _ rs2 _ rs1 _f3 _ rd  _opcode; // R-Type
        //rom[0] = 32'b0000000_00001_00010_000_00100_0110011;  // add x4, x2, x1
        rom[1] = 32'b0100000_00001_00010_000_00101_0110011;  // sub x5, x2, x1

        //rom[x]=32'b imm7 _ rs2 _ rs1 _f3 _ imm5  _opcode; // S-Type
        rom[2] = 32'b0000000_00010_00000_010_01000_0100011; // sw(store word) x2, 8(x0); -> 8번주소
        
        //rom[x]=32'b imm12_rs1_f3_rd_opcode; // L-Type
        rom[3] = 32'b000000001000_00011_010_01001_0000011; // lw(load word) x3, x9;
    end
    assign data = rom[addr[31:2]];
endmodule
