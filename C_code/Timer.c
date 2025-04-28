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

typedef struct{
    __IO uint32_t TCR;
    __IO uint32_t TCNT;
    __IO uint32_t PSC;
    __IO uint32_t ARR;
} TIM_TypeDef;

#define APB_BASEADDR     0x10000000
#define GPOA_BASEADDR   (APB_BASEADDR + 0x1000)
#define GPIB_BASEADDR   (APB_BASEADDR + 0x2000)
#define GPIOC_BASEADDR  (APB_BASEADDR + 0x3000)
#define GPIOD_BASEADDR  (APB_BASEADDR + 0x4000)
#define FND_BASEADDR    (APB_BASEADDR + 0x5000)
#define TIM_BASEADDR    (APB_BASEADDR + 0x6000)

#define GPOA            ((GPO_TypeDef *) GPOA_BASEADDR) //                  ->10001000 
#define GPIB            ((GPI_TypeDef *) GPIB_BASEADDR) //                  ->10001000 
#define GPIOC           ((GPIO_TypeDef *) GPIOC_BASEADDR) //                  ->10001000 
#define GPIOD           ((GPIO_TypeDef *) GPIOD_BASEADDR)
#define FNDE            ((FND_TypeDef *) FND_BASEADDR)
#define TIM0            ((TIM_TypeDef *) TIM_BASEADDR)

#define FND_ON           1
#define FND_OFF          0

#define BUTTON_1         4
#define BUTTON_2         5
#define BUTTON_3         6
#define BUTTON_4         7


void delay(int n);
void LED_init(GPIO_TypeDef *GPIOx);
void LED_write(GPIO_TypeDef *GPIOx, uint32_t data);

void switch_init(GPIO_TypeDef *GPIOx);
uint32_t switch_read(GPIO_TypeDef *GPIOx);

void Button_init(GPIO_TypeDef *GPIOx);
uint32_t Button_getState(GPIO_TypeDef *GPIOx);

void FND_writeDot(FND_TypeDef *FNDx, uint32_t dot_mask);  // ← 이거 필요
void FND_init(FND_TypeDef *FNDx,uint32_t ON_OFF);
void FND_writeData(FND_TypeDef *FNDx, uint32_t data);

void TIM_start(TIM_TypeDef *tim);
void TIM_stop(TIM_TypeDef *tim);
uint32_t TIM_readCounter(TIM_TypeDef *tim);
void TIM_writePrescaler(TIM_TypeDef *tim, uint32_t psc);
void TIM_writeAutoReload(TIM_TypeDef *tim, uint32_t arr); // write
void TIM_clear(TIM_TypeDef *tim);

void func1(uint32_t *prevTime, uint32_t *data){
    uint32_t curTime = TIM_readCounter(TIM0);
    if (curTime - *prevTime < 200) return;
    *prevTime = curTime;
    
    *data ^= 1<<1;
    LED_write(GPIOD, *data);
}

void func2(uint32_t *prevTime, uint32_t *data){
    uint32_t curTime = TIM_readCounter(TIM0);
    if (curTime - *prevTime < 500) return;
    *prevTime = curTime;

    *data ^= 1<<2;
    LED_write(GPIOD, *data);
}

void func3(uint32_t *prevTime, uint32_t *data){
    uint32_t curTime = TIM_readCounter(TIM0);
    if (curTime - *prevTime < 1000) return;
    *prevTime = curTime;
    
    *data ^= 1<<3;
    LED_write(GPIOD, *data);
}

void func4(uint32_t *prevTime, uint32_t *data){
    uint32_t curTime = TIM_readCounter(TIM0);
    if (curTime - *prevTime < 1500) return;
    *prevTime = curTime;
    
    *data ^= 1<<4;
    LED_write(GPIOD, *data);
}

void power(uint32_t *prevTime, uint32_t *data){
    uint32_t curTime = TIM_readCounter(TIM0);
    if (curTime - *prevTime < 500) return;
    *prevTime = curTime;
    
    *data ^= 1<<0;
    LED_write(GPIOD, *data);
}

enum {FUNC1, FUNC2, FUNC3, FUNC4};

int main(){
    uint32_t fucn1PrevTime = 0;
    uint32_t func1Data = 0;
    uint32_t fucn2PrevTime = 0;
    uint32_t func2Data = 0;
    uint32_t fucn3PrevTime = 0;
    uint32_t func3Data = 0;
    uint32_t fucn4PrevTime = 0;
    uint32_t func4Data = 0;
    uint32_t powerPrevTime = 0;
    uint32_t powerData = 0;

    LED_init(GPIOC);               // LED 초기화
    Button_init(GPIOD);
    switch_init(GPIOD);            // 스위치 초기화
    
    TIM_writePrescaler(TIM0, 100000-1);
    TIM_writeAutoReload(TIM0, 0xffffffff); // auto reload -> maximum value
    TIM_start(TIM0);

    uint32_t state = FUNC1;
    
    while(1)
    {
        power(&powerPrevTime, &powerData);

        switch (state)
        {
            case FUNC1:
                func1(&fucn1PrevTime, &func1Data);
            break;
            case FUNC2:
                func2(&fucn2PrevTime, &func2Data);
            break;
            case FUNC3:
                func3(&fucn3PrevTime, &func3Data);
            break;
            case FUNC4:
                func4(&fucn4PrevTime, &func4Data);
            break;
        }

        switch (state)
        {
            case FUNC1:
                if (Button_getState(GPIOD) & (1<<BUTTON_2)) state = FUNC2;
                else if (Button_getState(GPIOD) & (1<<BUTTON_3)) state = FUNC3;
                else if (Button_getState(GPIOD) & (1<<BUTTON_4)) state = FUNC4;
                else state = FUNC1;
            break;
            case FUNC2:
                if (Button_getState(GPIOD) & (1<<BUTTON_1)) state = FUNC1;
                else if (Button_getState(GPIOD) & (1<<BUTTON_3)) state = FUNC3;
                else if (Button_getState(GPIOD) & (1<<BUTTON_4)) state = FUNC4;
                else state = FUNC2;
            break;
            case FUNC3:
                if (Button_getState(GPIOD) & (1<<BUTTON_1)) state = FUNC1;
                else if (Button_getState(GPIOD) & (1<<BUTTON_2)) state = FUNC2;
                else if (Button_getState(GPIOD) & (1<<BUTTON_4)) state = FUNC4;
                else state = FUNC3;
            break;
            case FUNC4:
                if (Button_getState(GPIOD) & (1<<BUTTON_1)) state = FUNC1;
                else if (Button_getState(GPIOD) & (1<<BUTTON_2)) state = FUNC2;
                else if (Button_getState(GPIOD) & (1<<BUTTON_3)) state = FUNC3;
                else state = FUNC4;
            break;
        }

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


/*
=============================
        timer function
=============================
*/

void TIM_start(TIM_TypeDef *tim){
    tim->TCR |= (1<<0); // set enable bit
}
void TIM_stop(TIM_TypeDef *tim){
    tim->TCR &= ~(1<<0); // reset enable bit (해당 비트 0으로)
}
uint32_t TIM_readCounter(TIM_TypeDef *tim){
    return tim->TCNT;
}
void TIM_writePrescaler(TIM_TypeDef *tim, uint32_t psc){
    tim->PSC = psc;
}
void TIM_writeAutoReload(TIM_TypeDef *tim, uint32_t arr){
    tim->ARR = arr;
}
void TIM_clear(TIM_TypeDef *tim){
    tim->TCR |= (1<<1); // set clear bit
    tim->TCR &= ~(1<<1); // reset clear bit
}

/*
=============================
        button driver
=============================
*/

void Button_init(GPIO_TypeDef *GPIOx)
{
    GPIOx->MODER = 0x00;  // *(GPOx) = 0xff
}
uint32_t Button_getState(GPIO_TypeDef *GPIOx)
{
    return GPIOx->IDR;
}