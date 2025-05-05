#include <stdint.h>

#define __IO volatile 

typedef struct {
    __IO uint32_t MODER;
    __IO uint32_t IDR;
    __IO uint32_t ODR;
} GPIO_TypeDef;

#define APB_BASEADDR    0x10000000
#define GPIOA_BASEADDR  (APB_BASEADDR + 0x1000)

#define GPIOA           ((GPIO_TypeDef *) GPIOA_BASEADDR)

// RGB LED 핀 정의 
#define RED_LED_PIN     1  // 빨간색 LED 핀 
#define GREEN_LED_PIN   2  // 녹색 LED 핀 
#define BLUE_LED_PIN    3  // 파란색 LED 핀 

// 틸트 센서는 JC4 (P18 핀)에 연결됨
#define TILT_SENSOR_PIN 3  // 틸트 센서 핀 (임의 설정, 실제 핀 매핑은 외부에서 처리됨)

void delay(int n);
void GPIO_init(void);
void RGB_LED_Set(uint32_t red, uint32_t green, uint32_t blue);
uint32_t TiltSensor_getState(void);

int main() {
    // GPIO 초기화
    GPIO_init();
    
    uint32_t prev_tilt_state = 0;
    uint32_t tilt_detected = 0;
    uint32_t alarm_counter = 0;
    
    // 초기 LED 끄기 (모든 색상 꺼짐)
    RGB_LED_Set(0, 0, 0);
    
    while(1) {
        // 틸트 센서 상태 읽기
        uint32_t current_tilt_state = TiltSensor_getState();
        
        // 센서 상태 변화 감지
        if (current_tilt_state != prev_tilt_state) {
            tilt_detected = 1;
            alarm_counter = 100; // 약 2초
            
            // 기울어짐 감지 시 빨간색 LED 켜기
            RGB_LED_Set(1, 0, 0);
        }
        
        // 알람 타이머 관리
        if (alarm_counter > 0) {
            alarm_counter--;
            
            // 알람 시간이 끝나면 LED 끄기
            if (alarm_counter == 0) {
                RGB_LED_Set(0, 0, 0);
                tilt_detected = 0;
            }
        }
        
        // 이전 상태 저장
        prev_tilt_state = current_tilt_state;
        
        // 지연
        delay(20);
    }
    
    return 0;
}

void delay(int n) {
    uint32_t temp = 0;
    for (int i = 0; i < n; i++) {
        temp = 0;
        for(int j = 0; j < 500; j++) {
            temp++;
        }
    }
}

void GPIO_init(void) {
    // GPIOA 초기화: RGB LED 핀은 출력(01), 틸트 센서 핀은 입력(00)
    uint32_t mode_reg = 0;
    mode_reg |= (1 << (RED_LED_PIN * 2));    // 빨간색 LED 핀을 출력 모드로 설정
    mode_reg |= (1 << (GREEN_LED_PIN * 2));  // 녹색 LED 핀을 출력 모드로 설정
    mode_reg |= (1 << (BLUE_LED_PIN * 2));   // 파란색 LED 핀을 출력 모드로 설정
    
    GPIOA->MODER = mode_reg;
}

void RGB_LED_Set(uint32_t red, uint32_t green, uint32_t blue) {
    // 각 색상 LED 제어
    if (red) {
        GPIOA->ODR |= (1 << RED_LED_PIN);    // 빨간색 LED 켜기
    } else {
        GPIOA->ODR &= ~(1 << RED_LED_PIN);   // 빨간색 LED 끄기
    }
    
    if (green) {
        GPIOA->ODR |= (1 << GREEN_LED_PIN);  // 녹색 LED 켜기
    } else {
        GPIOA->ODR &= ~(1 << GREEN_LED_PIN); // 녹색 LED 끄기
    }
    
    if (blue) {
        GPIOA->ODR |= (1 << BLUE_LED_PIN);   // 파란색 LED 켜기
    } else {
        GPIOA->ODR &= ~(1 << BLUE_LED_PIN);  // 파란색 LED 끄기
    }
}

uint32_t TiltSensor_getState(void) {
    return (GPIOA->IDR & (1 << TILT_SENSOR_PIN)) ? 1 : 0; // 틸트 센서 핀 상태 읽기
}