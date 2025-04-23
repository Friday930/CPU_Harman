#include <stdint.h>

#define __IO            volatile

typedef struct {
    __IO uint32_t MODER;
    __IO uint32_t ODR;
} GPO_TypeDef;

typedef struct {
    __IO uint32_t MODER;
    __IO uint32_t IDR;
} GPI_TypeDef;

typedef struct {
    __IO uint32_t MODER;
    __IO uint32_t IDR;
    __IO uint32_t ODR;
} GPIO_TypeDef;

typedef struct {
    __IO uint32_t FCR;
    __IO uint32_t FMR;
    __IO uint32_t FDR;
} FND_TypeDef;

#define APB_BASEADDR    0x10000000
#define GPOA_BASEADDR   (APB_BASEADDR + 0x1000)
#define GPIB_BASEADDR   (APB_BASEADDR + 0x2000)
#define GPIOC_BASEADDR  (APB_BASEADDR + 0x3000)
#define GPIOD_BASEADDR  (APB_BASEADDR + 0x4000)
#define FND_BASEADDR    (APB_BASEADDR + 0x5000)

#define GPOA            ((GPO_TypeDef *) GPOA_BASEADDR)
#define GPIB            ((GPI_TypeDef *) GPIB_BASEADDR)
#define GPIOC           ((GPIO_TypeDef *) GPIOC_BASEADDR)
#define GPIOD           ((GPIO_TypeDef *) GPIOD_BASEADDR)
#define FND             ((FND_TypeDef *) FND_BASEADDR)

#define GPOA_MODER      *(uint32_t *)(GPOA_BASEADDR + 0x00)
#define GPOA_ODR        *(uint32_t *)(GPOA_BASEADDR + 0x04)
#define GPIB_MODER      *(uint32_t *)(GPIB_BASEADDR + 0x00)
#define GPIB_IDR        *(uint32_t *)(GPIB_BASEADDR + 0x04)

#define FND_OFF         0
#define FND_ON          1

void delay(int n);

void LED_init(GPIO_TypeDef *GPIOx);
void LED_write(GPIO_TypeDef *GPIOx, uint32_t data);

void Switch_init(GPIO_TypeDef *GPIOx);
uint32_t Switch_read(GPIO_TypeDef *GPIOx);

// fnd driver function
void FND_init(FND_TypeDef *fnd, uint32_t ON_OFF);
void FND_writeCom(FND_TypeDef *fnd, uint32_t comport);
void FND_writeData(FND_TypeDef *fnd, uint32_t data);

int main(){
    LED_init(GPIOC);
    Switch_init(GPIOD);
    FND_init(FND, FND_ON);

    uint32_t count = 0;
    uint32_t digit1, digit2, digit3, digit4;
    
    while(1){
        // 스위치 상태에 따라 FND On/Off 제어
        // if (Switch_read(GPIOD) == 0x00) {
        //     FND_init(FND, FND_OFF);
        // } else {
        //     FND_init(FND, FND_ON);
        // }
        
        // 각 자릿수 추출
        digit1 = count % 10;          // 1의 자리
        digit2 = (count / 10) % 10;   // 10의 자리
        digit3 = (count / 100) % 10;  // 100의 자리
        digit4 = (count / 1000) % 10; // 1000의 자리
        
        // 첫 번째 FND (1의 자리)
        FND_writeCom(FND, (1<<0));
        FND_writeData(FND, digit1);
        delay(1);
        
        // 두 번째 FND (10의 자리)
        FND_writeCom(FND, (1<<1));
        FND_writeData(FND, digit2);
        delay(1);
        
        // 세 번째 FND (100의 자리)
        FND_writeCom(FND, (1<<2));
        FND_writeData(FND, digit3);
        delay(1);
        
        // 네 번째 FND (1000의 자리)
        FND_writeCom(FND, (1<<3));
        FND_writeData(FND, digit4);
        delay(1);
        
        // 카운트 증가 및 9999 이후 0으로 초기화
        count++;
        if(count > 9999) {
            count = 0;
        }
        
        // 카운트 속도 조절을 위한 딜레이
        delay(5000);  
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

void LED_init(GPIO_TypeDef *GPIOx){
    GPIOx->MODER = 0xff;
}

void LED_write(GPIO_TypeDef *GPIOx, uint32_t data){
    GPIOx->ODR = data;
}

void Switch_init(GPIO_TypeDef *GPIOx){
    GPIOx->MODER = 0x00;
}

uint32_t Switch_read(GPIO_TypeDef *GPIOx){
    return GPIOx->IDR;
}

void FND_init(FND_TypeDef *fnd, uint32_t ON_OFF){
    fnd->FCR = ON_OFF;
}

void FND_writeCom(FND_TypeDef *fnd, uint32_t comport){
    fnd->FMR = comport;
}

void FND_writeData(FND_TypeDef *fnd, uint32_t data){
    fnd->FDR = data;
}