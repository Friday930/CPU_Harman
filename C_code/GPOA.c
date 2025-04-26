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

#define APB_BASEADDR    0x10000000
#define GPOA_BASEADDR   (APB_BASEADDR + 0x1000)
#define GPIB_BASEADDR   (APB_BASEADDR + 0x2000)

#define GPOA            ((GPO_TypeDef *) GPOA_BASEADDR)
#define GPIB            ((GPI_TypeDef *) GPIB_BASEADDR)

#define GPOA_MODER      *(uint32_t *)(GPOA_BASEADDR + 0x00)
#define GPOA_ODR        *(uint32_t *)(GPOA_BASEADDR + 0x04)
#define GPIB_MODER      *(uint32_t *)(GPIB_BASEADDR + 0x00)
#define GPIB_IDR        *(uint32_t *)(GPIB_BASEADDR + 0x04)


void delay(int n);
void LED_init(GPO_TypeDef *GPOx);
void LED_write(GPO_TypeDef *GPOx, uint32_t data);
void Switch_init(GPI_TypeDef *GPIx);
uint32_t Switch_read(GPI_TypeDef *GPIx);

int main(){
    // GPOA_MODER = 0xff;
    // GPIB_MODER = 0x00;
    // GPOA->MODER = 0xff;
    // GPIB->MODER = 0x00;
    LED_init(GPOA);
    Switch_init(GPIB);

    uint32_t temp;
    uint32_t one = 1;
    while(1){
        
        temp = Switch_read(GPIB);
        if (temp & (1<<0)){
           LED_write(GPOA, temp); 
        }
        else if (temp & (1<<1)){
            LED_write(GPOA, one);
            one = (one << 1) | (one >> 7);
            delay(50);
        }
        else if (temp & (1<<2)){
            LED_write(GPOA, one);
            one = (one << 1) | (one >> 7);
            delay(50);
        }
        else{
            LED_write(GPOA, 0xff);
            delay(50);
            LED_write(GPOA, 0x00);
            delay(50);
        }
        // GPOA_ODR = GPIB_IDR;
        // GPOA->ODR = GPIB->IDR;
        // GPOA_ODR = 0xff;
        // delay(500);
        // GPOA_ODR = 0x00;
        // delay(500);
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

void LED_init(GPO_TypeDef *GPOx){
    GPOx->MODER = 0xff;
}

void LED_write(GPO_TypeDef *GPOx, uint32_t data){
    GPOx->ODR = data;
}

void Switch_init(GPI_TypeDef *GPIx){
    GPIx->MODER = 0x00;
}

uint32_t Switch_read(GPI_TypeDef *GPIx){
    return GPIx->IDR;
}