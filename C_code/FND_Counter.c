#include <stdint.h>

#define __IO    volatile // 최적화 하지말아라 라는 의미, register 앞에 자주 붙인다고 함

typedef struct{
    __IO uint32_t MODER;
    __IO uint32_t ODR;
} GPO_TypeDef;

typedef struct{
    __IO uint32_t MODER;
    __IO uint32_t IDR;
} GPI_TypeDef;

typedef struct{
    __IO uint32_t MODER;
    __IO uint32_t IDR;
    __IO uint32_t ODR;
} GPIO_TypeDef;
typedef struct{
    __IO uint32_t FCR;
    __IO uint32_t FDR;
    __IO uint32_t FPR;
} FND_TypeDef;
#define APB_BASEADDR     0x10000000
#define GPOA_BASEADDR   (APB_BASEADDR + 0x1000)
#define GPIB_BASEADDR   (APB_BASEADDR + 0x2000)
#define GPIOC_BASEADDR   (APB_BASEADDR + 0x3000)
#define GPIOD_BASEADDR   (APB_BASEADDR + 0x4000)
#define FND_BASEADDR   (APB_BASEADDR + 0x5000)
#define GPOA            ((GPO_TypeDef *) GPOA_BASEADDR) //                  ->10001000 
#define GPIB            ((GPI_TypeDef *) GPIB_BASEADDR) //                  ->10001000 
#define GPIOC            ((GPIO_TypeDef *) GPIOC_BASEADDR) //                  ->10001000 
#define GPIOD            ((GPIO_TypeDef *) GPIOD_BASEADDR)
#define FNDE            ((FND_TypeDef *) FND_BASEADDR)

#define FND_ON           1
#define FND_OFF          0


void delay(int n);
void LED_init(GPIO_TypeDef *GPIOx);
void LED_write(GPIO_TypeDef *GPIOx, uint32_t data);
void switch_init(GPIO_TypeDef *GPIOx);
void FND_writeDot(FND_TypeDef *FNDx, uint32_t dot_mask);  // ← 이거 필요

uint32_t switch_read(GPIO_TypeDef *GPIOx);

void FND_init(FND_TypeDef *FNDx,uint32_t ON_OFF);
void FND_writeData(FND_TypeDef *FNDx, uint32_t data);
int main(){
    LED_init(GPIOC);               // LED 초기화
    switch_init(GPIOD);            // 스위치 초기화
    FND_init(FNDE, FND_ON);        // FND 켬

    uint32_t temp;
    uint32_t count = 0;
    uint32_t dot_state = 0;

    while(1)
    {
        temp = switch_read(GPIOD); // 스위치 상태 읽기

        if (temp == 0x00) {
            FND_init(FNDE, FND_OFF);
            count = 0;
        }
        else {
            FND_init(FNDE, FND_ON);
        }

        FND_writeData(FNDE, count);  // 카운트 값을 표시

       if (dot_state == 0) {
            FND_writeDot(FNDE, 0xF);  // DOT ON
            dot_state = 1;
            
        } else {
            FND_writeDot(FNDE, 0x0);  // DOT OFF
            dot_state = 0;
            
        }


        if (count == 9999) {
            count = 0;
        } else {
            count++;
        }

        delay(5000); // 0.5초 지연
    }

    return 0;
}

void delay(int n){
    uint32_t temp =0;
    for (int i=0; i<n;i++){
        temp = 0;
        for(int j=0; j<500;j++){
            temp ++ ;
        }
    }
}

void LED_init(GPIO_TypeDef *GPIOx)
{
    GPIOx->MODER = 0xff;    // *(GPOx) = 0xff
}
void LED_write(GPIO_TypeDef *GPIOx, uint32_t data)
{
    GPIOx->ODR = data;  // *(GPOx + 8) = 0xff
}
void switch_init(GPIO_TypeDef *GPIOx)
{
    GPIOx->MODER = 0x00;  // *(GPOx) = 0xff
}
uint32_t switch_read(GPIO_TypeDef *GPIOx)
{
    return GPIOx->IDR;
}
void FND_init(FND_TypeDef *FNDx, uint32_t ON_OFF)
{
    FNDx->FCR = ON_OFF;
}
void FND_writeData(FND_TypeDef *FNDx, uint32_t data)
{
    FNDx->FDR = data;
}
void FND_writeDot(FND_TypeDef *FNDx, uint32_t dot_mask)
{
    FNDx->FPR = dot_mask;
}
