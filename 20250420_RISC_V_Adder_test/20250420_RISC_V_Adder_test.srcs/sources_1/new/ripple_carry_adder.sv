`timescale 1ns / 1ps

module ripple_carry_adder (
    input  logic [31:0] a,     // 첫 번째 피연산자
    input  logic [31:0] b,     // 두 번째 피연산자
    input  logic sub,          // 연산 제어 (0: 덧셈, 1: 뺄셈)
    output logic [31:0] result, // 연산 결과
    output logic cout          // 자리올림 출력
);
    logic [31:0] b_mod;  // 2의 보수 처리를 위한 B 수정
    logic [32:0] carry;  // 자리올림 신호 (초기 자리올림 포함)
    
    genvar i;
    
    // 뺄셈 연산을 위한 B 비트 반전 (2의 보수의 첫 단계)
    generate
        for (i = 0; i < 32; i++) begin : b_complement
            assign b_mod[i] = b[i] ^ sub;
        end
    endgenerate
    
    // 초기 자리올림은 뺄셈일 경우 1 (2의 보수에서 +1을 위함)
    assign carry[0] = sub;
    
    // 각 비트별 가산 수행
    generate
        for (i = 0; i < 32; i++) begin : adder_gen
            // 각 비트 위치의 합과 자리올림 계산
            assign result[i] = a[i] ^ b_mod[i] ^ carry[i];
            assign carry[i+1] = (a[i] & b_mod[i]) | (a[i] & carry[i]) | (b_mod[i] & carry[i]);
        end
    endgenerate
    
    // 최종 자리올림 출력
    assign cout = carry[32];
endmodule
