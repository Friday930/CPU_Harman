`timescale 1ns / 1ps

module han_carlson_adder (
    input  logic [31:0] a,     // 첫 번째 피연산자
    input  logic [31:0] b,     // 두 번째 피연산자
    input  logic sub,          // 연산 제어 (0: 덧셈, 1: 뺄셈)
    output logic [31:0] result, // 연산 결과
    output logic cout          // 자리올림 출력
);
    // 뺄셈을 위한 B의 2의 보수 처리
    logic [31:0] b_mod;  // B 수정
    logic cin;           // 초기 자리올림
    
    genvar i, j;
    
    // 뺄셈 연산을 위한 B 비트 반전
    generate
        for (i = 0; i < 32; i++) begin : b_complement
            assign b_mod[i] = b[i] ^ sub;
        end
    endgenerate
    
    // 초기 자리올림 (뺄셈인 경우 1)
    assign cin = sub;
    
    // 1단계: 전파(P) 및 생성(G) 신호 계산
    logic [31:0] p_init, g_init;
    
    generate
        for (i = 0; i < 32; i++) begin : pg_init
            assign p_init[i] = a[i] ^ b_mod[i];  // 전파: a XOR b_mod
            assign g_init[i] = a[i] & b_mod[i];  // 생성: a AND b_mod
        end
    endgenerate
    
    // 2단계: 접두사 네트워크를 위한 블록 P와 G 계산
    // 2^k 비트 범위에서의 'o' 연산: (g, p) o (g', p') = (g + p·g', p·p')
    
    // 모든 단계(log2(32)=5)를 위한 P와 G 배열
    logic [31:0] p[6], g[6];  // [0]은 초기값, [1]부터 [5]까지는 각 단계
    
    // 초기값 복사
    assign p[0] = p_init;
    assign g[0] = g_init;
    
    // 첫 번째 단계: 홀수 위치는 직전의 짝수에서 데이터 가져옴
    generate
        for (i = 0; i < 32; i++) begin : stage1
            if (i % 2 == 0) begin  // 짝수 위치는 그대로 유지
                assign p[1][i] = p[0][i];
                assign g[1][i] = g[0][i];
            end else begin  // 홀수 위치는 위치 i와 i-1 조합
                assign p[1][i] = p[0][i] & p[0][i-1];
                assign g[1][i] = g[0][i] | (p[0][i] & g[0][i-1]);
            end
        end
    endgenerate
    
    // 나머지 단계: 거리를 2배씩 늘려가며 계산
    generate
        // 각 단계별 처리
        for (j = 2; j <= 5; j++) begin : stages
            // 각 비트 위치별 처리
            for (i = 0; i < 32; i++) begin : bits
                if (i < (1 << (j-1))) begin  // 처리하지 않는 낮은 비트
                    assign p[j][i] = p[j-1][i];
                    assign g[j][i] = g[j-1][i];
                end else begin  // 조합이 필요한 높은 비트
                    assign p[j][i] = p[j-1][i] & p[j-1][i - (1 << (j-1))];
                    assign g[j][i] = g[j-1][i] | (p[j-1][i] & g[j-1][i - (1 << (j-1))]);
                end
            end
        end
    endgenerate
    
    // 3단계: 자리올림 신호 계산
    logic [32:0] carries;  // 각 비트 위치의 자리올림 (includes initial carry)
    
    // 초기 자리올림 설정
    assign carries[0] = cin;
    
    generate
        // 비트 0의 자리올림은 초기 자리올림과 해당 비트의 생성 신호로 계산
        assign carries[1] = g[5][0] | (p[5][0] & cin);
        
        // 나머지 비트의 자리올림 계산
        for (i = 1; i < 32; i++) begin : carry_gen
            assign carries[i+1] = g[5][i] | (p[5][i] & carries[i]);
        end
    endgenerate
    
    // 4단계: 결과 계산
    generate
        for (i = 0; i < 32; i++) begin : result_gen
            assign result[i] = p_init[i] ^ carries[i];  // 결과 = P XOR Cin
        end
    endgenerate
    
    // 최종 자리올림 출력
    assign cout = carries[32];
    
endmodule