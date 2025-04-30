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

void Button_init(GPIO_TypeDef *GPIOx);
uint32_t Button_getState(GPIO_TypeDef *GPIOx);

void btn(GPIO_TypeDef *GPIOx);

int main(){
    LED_init(GPIOC);
    Button_init(GPIOD);
    
    uint32_t led = 0;
    uint32_t prevButtonState = 0;
    
    while(1) {
        
        uint32_t currentButtonState = Button_getState(GPIOD);
        
        if ((prevButtonState & (1<<4)) && !(currentButtonState & (1<<4))) {
            led ^= (1<<0);
            LED_write(GPIOC, led);
        }
        
        if ((prevButtonState & (1<<5)) && !(currentButtonState & (1<<5))) {
            led ^= (1<<1);
            LED_write(GPIOC, led);
        }
        
        if ((prevButtonState & (1<<6)) && !(currentButtonState & (1<<6))) {
            led ^= (1<<2);
            LED_write(GPIOC, led);
        }
        
        if ((prevButtonState & (1<<7)) && !(currentButtonState & (1<<7))) {
            led ^= (1<<3);
            LED_write(GPIOC, led);
        }
        prevButtonState = currentButtonState;
        
        delay(20);
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

void btn(GPIO_TypeDef *GPIOx){
    uint32_t currentButtonState = Button_getState(GPIOD);
    for (int i = 0; i < 4; i++)
    {
        if ((prevButtonState & (1<<i)) && !(currentButtonState & (1<<i))) {
            led ^= (1<<i-4);
            LED_write(GPIOC, led);
        }
    }
    prevButtonState = currentButtonState;
    
}