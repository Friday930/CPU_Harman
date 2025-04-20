`timescale 1ns / 1ps

// 32비트 Han-Carlson 가산기/감산기 테스트벤치
module tb_adder;
    // 테스트 신호 선언
    logic [31:0] a, b;
    logic sub;
    logic [31:0] result;
    logic cout;
    
    // DUT 인스턴스화
    han_carlson_adder dut (
        .a(a),
        .b(b),
        .sub(sub),
        .result(result),
        .cout(cout)
    );
    
    // 실제 연산 결과와 예상 결과를 비교하기 위한 변수
    logic [31:0] expected_result;
    logic expected_cout;
    logic [32:0] temp_result;
    
    // 테스트 케이스 실행 및 검증 태스크
    task test_case(
        input [31:0] test_a,
        input [31:0] test_b,
        input test_sub
    );
        // 테스트 입력값 설정
        a = test_a;
        b = test_b;
        sub = test_sub;
        
        // 안정화 시간
        #10;
        
        // 예상 결과 계산
        if (sub) begin
            // 뺄셈 연산
            temp_result = {1'b0, a} - {1'b0, b};
            expected_result = temp_result[31:0];
            expected_cout = ~temp_result[32]; // 뺄셈에서 borrow는 반전된 자리올림
        end else begin
            // 덧셈 연산
            temp_result = {1'b0, a} + {1'b0, b};
            expected_result = temp_result[31:0];
            expected_cout = temp_result[32];
        end
    endtask
    
    // 시뮬레이션 시작
    initial begin
        // // 테스트 케이스 1: 간단한 덧셈
        // test_case(32'd12345, 32'd54321, 1'b0);
        
        // // 테스트 케이스 2: 간단한 뺄셈
        // test_case(32'd54321, 32'd12345, 1'b1);
        
        // // 테스트 케이스 3: 음수 결과가 나오는 뺄셈
        // test_case(32'd12345, 32'd54321, 1'b1);
        
        // // 테스트 케이스 4: 매우 큰 수 덧셈 (오버플로우 확인)
        // test_case(32'hFFFFFFFF, 32'd1, 1'b0);
        
        // // 테스트 케이스 5: 동일한 수 뺄셈 (0이 나오는 경우)
        // test_case(32'd999999, 32'd999999, 1'b1);
        
        // // 테스트 케이스 6: 경계값 테스트 - 최대값 덧셈
        // test_case(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);
        
        // // 테스트 케이스 7: 경계값 테스트 - 최대값과 최소값 덧셈
        // test_case(32'h7FFFFFFF, 32'h80000000, 1'b0);
        
        // // 테스트 케이스 8: 비트 패턴 테스트 - 교차 패턴
        // test_case(32'hAAAAAAAA, 32'h55555555, 1'b0);
        // test_case(32'hAAAAAAAA, 32'h55555555, 1'b1);
        
        // // 테스트 케이스 9: 0과의 연산
        // test_case(32'd12345, 32'd0, 1'b0);
        // test_case(32'd12345, 32'd0, 1'b1);
        
        // // 테스트 케이스 10: 임의의 큰 수 연산
        // test_case(32'h3FFFFFFF, 32'h4FFFFFFF, 1'b0);
        // test_case(32'h3FFFFFFF, 32'h4FFFFFFF, 1'b1);

        test_case(32'd2891472, 32'd3948202, 1'b0);
        test_case(32'd2891472, 32'd3948202, 1'b1);
        test_case(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1);

        
        $finish;
    end
endmodule
