#include <stdio.h>
#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"

typedef struct{
	volatile uint32_t DR;
	volatile uint32_t CR;
}GPIOA_TypeDef;

typedef struct{
	volatile u_int32_t MODER;
	volatile u_int32_t ODR;
	volatile u_int32_t IDR;
}GPIOB_TypeDef;

#define GPIOA_BASEADDR 	0x40000000U
#define GPIOA			((GPIOA_TypeDef*)GPIOA_BASEADDR)

#define GPIOB_BASEADDR 	0x44A00000U
#define GPIOB			((GPIOB_TypeDef*)GPIOB_BASEADDR)

int Switch_getState(GPIOA_TypeDef *GPIOx, int bit);

int main()
{
	int counter = 0;
	GPIOA->CR = 0xff00;
	GPIOB->MODER = 0x0f;

	while(1){
		xil_printf("counter : %d\n", counter ++);
		if(Switch_getState(GPIOA, 13)){
			GPIOA->DR ^= 0xf0;
		}
		if(Switch_getState(GPIOA, 8)){
			GPIOA->DR ^= 0x0f;
		}
		if(GPIOB->IDR & (1<<4)){
			GPIOB->ODR ^= 0x0f;
		}
		sleep(1);
	}
	return 0;
}

int Switch_getState(GPIOA_TypeDef *GPIOx, int bit){
	int temp;
	temp = GPIOx->DR & (1U << bit);
	return (temp == 0) ? 0 : 1;
}
