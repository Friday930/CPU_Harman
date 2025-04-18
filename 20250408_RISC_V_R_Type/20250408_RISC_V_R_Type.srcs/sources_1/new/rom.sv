`timescale 1ns / 1ps

module rom (
    input  logic [31:0] addr,
    output logic [31:0] data
);
    logic [31:0] rom[0:15];

    initial begin
        // rom[x] = 32'b func7 _ rs2 _ rs1 _ f3 _ rd _ opcode; //R-Type
        rom[0] = 32'b0000000_00001_00010_000_00011_0110011; // add x3, x2, x1
        rom[1] = 32'b0100000_00001_00010_000_00100_0110011; // sub x4, x2, x1
        rom[2] = 32'b0000000_00001_00010_001_00101_0110011; // sll x5, x2, x1
        rom[3] = 32'b0000000_00001_00010_101_00110_0110011; // srl x6, x2, x1
        rom[4] = 32'b0100000_00001_00010_101_00111_0110011; // sra x7, x2, x1
        rom[5] = 32'b0000000_00001_00010_010_01000_0110011; // slt x8, x2, x1
        rom[6] = 32'b0000000_00001_00010_011_01001_0110011; // sltu x9, x2, x1
        rom[7] = 32'b0000000_00001_00010_100_01010_0110011; // xor x10, x2, x1
        rom[8] = 32'b0000000_00001_00010_110_01011_0110011; // or x11, x2, x1
        rom[9] = 32'b0000000_00001_00010_111_01100_0110011; // and x12, x2, x1
    end // test

    assign  data = rom[addr[31:2]]; // 4의 배수를 위해 하위 2비트 제거
endmodule
