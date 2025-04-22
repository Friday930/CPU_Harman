#include <stdint.h>

#define __IO            volatile

typedef struct {
    __IO uint32_t MODER;    // 모드 레지스터 (입력/출력 설정)
    __IO uint32_t ODR;      // 출력 데이터 레지스터
    __IO uint32_t IDR;      // 입력 데이터 레지스터
} GPIO_TypeDef;

#define APB_BASEADDR    0x10000000
#define GPIOA_BASEADDR  (APB_BASEADDR + 0x1000)
#define GPIOB_BASEADDR  (APB_BASEADDR + 0x2000)

#define GPIOA           ((GPIO_TypeDef *) GPIOA_BASEADDR)
#define GPIOB           ((GPIO_TypeDef *) GPIOB_BASEADDR)

#define GPIOA_MODER     *(uint32_t *)(GPIOA_BASEADDR + 0x00)
#define GPIOA_ODR       *(uint32_t *)(GPIOA_BASEADDR + 0x04)
#define GPIOA_IDR       *(uint32_t *)(GPIOA_BASEADDR + 0x08)
#define GPIOB_MODER     *(uint32_t *)(GPIOB_BASEADDR + 0x00)
#define GPIOB_ODR       *(uint32_t *)(GPIOB_BASEADDR + 0x04)
#define GPIOB_IDR       *(uint32_t *)(GPIOB_BASEADDR + 0x08)

// GPIO 포트 모드 정의
#define GPIO_MODE_INPUT  0x00
#define GPIO_MODE_OUTPUT 0xFF

void delay(int n);
void GPIO_init(GPIO_TypeDef *GPIOx, uint32_t mode);
void GPIO_write(GPIO_TypeDef *GPIOx, uint32_t data);
uint32_t GPIO_read(GPIO_TypeDef *GPIOx);

int main(){
    // GPIO 초기화: GPIOA는 출력모드, GPIOB는 입력모드
    GPIO_init(GPIOA, GPIO_MODE_OUTPUT);
    GPIO_init(GPIOB, GPIO_MODE_INPUT);

    uint32_t temp;
    uint32_t one = 1;
    while(1){
        
        temp = GPIO_read(GPIOB);
        if (temp & (1<<0)){
           GPIO_write(GPIOA, temp); 
        }
        else if (temp & (1<<1)){
            GPIO_write(GPIOA, one);
            one = (one << 1) | (one >> 7);
            delay(50);
        }
        else if (temp & (1<<2)){
            GPIO_write(GPIOA, one);
            one = (one << 1) | (one >> 7);
            delay(50);
        }
        else{
            GPIO_write(GPIOA, 0xff);
            delay(50);
            GPIO_write(GPIOA, 0x00);
            delay(50);
        }
    }
    return 0;
}

void delay(int n){
    uint32_t temp = 0;
    for (int i = 0; i < n; i++){
        for (int j = 0; j < 1000; j++){
            temp++;
        }
    }
}

void GPIO_init(GPIO_TypeDef *GPIOx, uint32_t mode){
    GPIOx->MODER = mode;
}

void GPIO_write(GPIO_TypeDef *GPIOx, uint32_t data){
    GPIOx->ODR = data;
}

uint32_t GPIO_read(GPIO_TypeDef *GPIOx){
    return GPIOx->IDR;
}