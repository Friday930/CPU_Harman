`timescale 1ns / 1ps

module rom (
    input  logic [31:0] addr,
    output logic [31:0] data
);
  logic [31:0] rom[0:127];

  initial begin
    //rom[x]=32'b fucn7 _ rs2 _ rs1 _f3 _ rd  _opcode; // R-Type
    // rom[0] = 32'b0000000_00001_00010_000_00100_0110011;  // add x4, x2, x1
    // rom[1] = 32'b0100000_00010_00001_000_00101_0110011;  // sub x5, x2, x1
    // rom[2] = 32'b0000000_00001_00010_001_00110_0110011;  // sll x6, x2, x1
    // rom[3] = 32'b0000000_00001_00010_101_00111_0110011;  // srl x7, x2, x1
    // rom[4] = 32'b0100000_00001_00010_101_01000_0110011;  // sra x8, x2, x1
    // rom[5] = 32'b0000000_00001_00010_010_01001_0110011;  // slt x9, x2, x1
    // rom[6] = 32'b0000000_00001_00010_011_01010_0110011;  // sltu x10, x2, x1
    // rom[7] = 32'b0000000_00001_00010_100_01011_0110011;  // xor x11, x2, x1
    // rom[8] = 32'b0000000_00001_00010_110_01100_0110011;  // or x12, x2, x1
    // rom[9] = 32'b0000000_00001_00010_111_01101_0110011;  // and x13, x2, x1

    // //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5_ opcode; // B-Type
    // rom[2] = 32'b0000000_00010_00010_000_01100_1100011; // beq x2, x2, 12
    // rom[0] = 32'b0_000000_00010_00010_000_1000_0_1100011;  // beq x2, x2, 16
    // rom[1] = 32'b0_000000_00011_00100_001_1000_0_1100011;  // bne x3, x4, 8
    // rom[2] = 32'b0_000000_00101_00110_100_1000_0_1100011;  // blt x5, x6, 8
    // rom[3] = 32'b0_000000_00111_01000_101_1000_0_1100011;  // bge x7, x8, 8
    // rom[4] = 32'b0_000000_01001_01010_110_1000_0_1100011;  // bltu x9, x10, 8
    // rom[5] = 32'b0_000000_01011_01110_111_1000_0_1100011;  // bgeu x11, x12, 8

    //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5_ opcode; // S-Type
    // rom[3] = 32'b0000000_00010_00000_010_01000_0100011; // sw x2, 8(x0);
    // rom[0] = 32'b0000000_00010_00000_000_01000_0100011;  // sb x0, x3, 0
    // rom[1] = 32'b0000000_00010_00001_001_01000_0100011;  // sh x1, x3, 0
    // rom[2] = 32'b0000000_00010_00000_010_01000_0100011;  // sw x2, x0, 8

    // //rom[x]=32'b imm7  _ rs2 _ rs1 _f3 _ imm5_ opcode; // S-Type
    // //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ opcode; // L-Type
    // rom[2] = 32'b0000000_00010_00000_010_01000_0100011;  // sw x2, x0, 8
    // rom[4] = 32'b000000001000_00000_010_00110_0000011;  // lw x0, x6 8


    // // //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ opcode; // L-Type
    // // // rom[4] = 32'b000000001000_00000_010_00011_0000011; // lw x3, 8(x0);
    // // rom[0] = 32'b000000001000_00000_000_00100_0000011;  // lb x0, x4 8
    // rom[4] = 32'b000000001000_00000_010_00110_0000011;  // lw x0, x6 8
    // rom[1] = 32'b000000001000_00000_001_00101_0000011;  // lh x0, x5 8
    // rom[3] = 32'b000000001000_00000_100_00111_0000011;  // lbu x0, x7, 8
    // rom[4] = 32'b000000001000_00000_101_01000_0000011;  // lhu x0, x8, 8

    // //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ opcode; // I-Type
    // rom[0] = 32'b000000001000_00010_000_00100_0010011;  // addi  x2, x4, 8
    // rom[1] = 32'b000000001000_00010_010_00101_0010011;  // slti  x2, x5, 8
    // rom[2] = 32'b000000001000_00010_011_00110_0010011;  // sltui x2, x6, 8
    // rom[3] = 32'b000000001000_00010_100_00111_0010011;  // xori  x2, x7, 8
    // rom[4] = 32'b000000001000_00010_110_01000_0010011;  // ori   x2, x8, 8
    // rom[5] = 32'b000000001000_00010_111_01001_0010011;  // andi  x2, x9, 8

    // rom[6] = 32'b0000000_00001_00010_001_01010_0010011;  // slli x2, x10, 1
    // rom[7] = 32'b0000000_00001_00010_101_01011_0010011;  // slri x2, x11, 1
    // rom[8] = 32'b0100000_00001_00010_101_01100_0010011;  // srai x2, x12, 1

    //rom[x]=32'b imm20              _ rd  _ opcode; // LU-Type
    // rom[0] = 32'b00000000000000001000_00011_0110111; // lu x3, 8;

    // //rom[x]=32'b imm20              _ rd  _ opcode; // AU-Type
    // rom[1] = 32'b00000000000000001000_00100_0010111;  // auipc x4, 8;

    //rom[x]=32'b imm20              _ rd  _ opcode; // J-Type
    // //rom[x]=32'b imm12      _ rs1 _f3 _ rd  _ opcode; // JL-Type
    // rom[2] = 32'b000000000000_00110_000_00011_1100111;  // jalr x3, x6 8
    // rom[3] = 32'b00000000100000000000_00011_1101111;  // jal x5, 8
    // rom[4] = 32'b000000001000_00110_000_00011_1100111;  // jalr x3, x6 8


    // rom[3] = 32'b000000001000_00011_000_00110_1100111;  // jalr x3, x6 8
    $readmemh("code.mem", rom);
  end
  assign data = rom[addr[31:2]];
endmodule
