`timescale 1ns / 1ps

module rom (
    input  logic [31:0] addr,
    output logic [31:0] data
);
    logic [31:0] rom[0:15];

    initial begin
        //rom[x]=32'b func7 _ rs2 _ rs1 _f3 _ rd  _opcode; // R-Type
        // rom[0] = 32'b0000000_00001_00010_000_00100_0110011;  // add x4, x2, x1
        // rom[1] = 32'b0100000_00001_00010_000_00101_0110011;  // sub x5, x2, x1

        //rom[x]=32'b imm7 _ rs2 _ rs1 _f3 _ imm5  _opcode; // S-Type
        // rom[2] = 32'b0000000_00010_00000_010_01000_0100011; // sw(store word) x2, 8(x0); -> 8번주소
        
        //rom[x]=32'b imm12 _ rs1 _ f3 _ rd _ opcode; // L-Type
        // rom[3] = 32'b000000001000_00000_010_00011_0000011; // lw(load word) x2, 8(x0);

        //rom[x]=32'b imm12 _ rs1 _ f3 _ rd _ opcode; // I-Type
        rom[4] = 32'b000000001000_00001_000_00100_0010011; // addi
        rom[5] = 32'b000000001001_00010_100_00101_0010011; // xori
        rom[6] = 32'b000000001010_00011_110_00110_0010011; // ori
        rom[7] = 32'b000000001011_00100_111_00111_0010011; // andi

        //rom[x]=32'b imm7 _ shamt5 _ rs1 _ f3 _ rd _ opcode; // I-Type
        rom[8] = 32'b0000000_00001_00101_001_01000_0010011; // slli
        rom[9] = 32'b0000000_00001_00110_101_01001_0010011; // srli
        rom[10] = 32'b0100000_00001_00111_101_01010_0010011; // srai
    end
    assign data = rom[addr[31:2]];
endmodule
