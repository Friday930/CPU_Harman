`timescale 1ns / 1ps

// 가산기 비교 테스트벤치 (디스플레이 출력 없음)
module comparison_testbench;
    // 테스트 신호 선언
    logic [31:0] a, b;
    logic sub;
    logic [31:0] hca_result, rca_result;  // 각 가산기의 결과
    logic hca_cout, rca_cout;             // 각 가산기의 자리올림 출력
    
    // 연산 시작/완료 펄스 신호
    logic start_pulse;          // 연산 시작 펄스
    logic hca_done_pulse;       // Han-Carlson 가산기 연산 완료 펄스
    logic rca_done_pulse;       // Ripple Carry 가산기 연산 완료 펄스
    
    // 시간 측정을 위한 변수
    time hca_start_time, hca_end_time, rca_start_time, rca_end_time;
    time hca_delay, rca_delay;
    
    // Han-Carlson 가산기 인스턴스화
    han_carlson_adder hca (
        .a(a),
        .b(b),
        .sub(sub),
        .result(hca_result),
        .cout(hca_cout)
    );
    
    // Ripple Carry 가산기 인스턴스화
    ripple_carry_adder rca (
        .a(a),
        .b(b),
        .sub(sub),
        .result(rca_result),
        .cout(rca_cout)
    );
    
    // 결과 확인 및 연산 속도 비교 작업
    task compare_adders(
        input [31:0] test_a,
        input [31:0] test_b,
        input test_sub
    );
        // 테스트 입력값 초기화
        a = 32'hxxxxxxxx;
        b = 32'hxxxxxxxx;
        sub = 1'bx;
        start_pulse = 1'b0;
        hca_done_pulse = 1'b0;
        rca_done_pulse = 1'b0;
        #5;
        
        // 연산 시작 신호 생성
        start_pulse = 1'b1;
        #1;
        start_pulse = 1'b0;
        
        // 입력값 설정 및 시간 측정 시작
        hca_start_time = $time;
        rca_start_time = $time;
        a = test_a;
        b = test_b;
        sub = test_sub;
        
        // Han-Carlson 가산기 연산 완료 모니터링
        fork
            begin
                // Han-Carlson이 더 빠를 것으로 예상되므로 더 짧은 대기 시간
                #20;
                hca_end_time = $time;
                hca_delay = hca_end_time - hca_start_time;
                hca_done_pulse = 1'b1;
                #2;
                hca_done_pulse = 1'b0;
            end
            
            begin
                // Ripple Carry 가산기는 더 오래 걸릴 것으로 예상
                #100;
                rca_end_time = $time;
                rca_delay = rca_end_time - rca_start_time;
                rca_done_pulse = 1'b1;
                #2;
                rca_done_pulse = 1'b0;
            end
        join
        
        // 두 연산 모두 완료 후 추가 대기
        #20;
    endtask
    
    // 시뮬레이션 시작
    initial begin
        // // 테스트 케이스 1: 작은 숫자 덧셈
        // compare_adders(32'd123, 32'd456, 1'b0);
        
        // // 테스트 케이스 2: 큰 숫자 덧셈
        // compare_adders(32'h7FFFFFFF, 32'h00000001, 1'b0);
        
        // // 테스트 케이스 3: 자리올림이 많이 발생하는 덧셈
        // compare_adders(32'hFFFFFFFF, 32'h00000001, 1'b0);
        
        // // 테스트 케이스 4: 무작위 패턴 덧셈
        // compare_adders(32'hA5A5A5A5, 32'h5A5A5A5A, 1'b0);
        
        // // 테스트 케이스 5: 정상 뺄셈
        // compare_adders(32'd1000, 32'd500, 1'b1);
        
        // // 테스트 케이스 6: 음수 결과가 나오는 뺄셈
        // compare_adders(32'd500, 32'd1000, 1'b1);

        compare_adders(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b1);
        compare_adders(32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);
        
        $finish;
    end
endmodule
