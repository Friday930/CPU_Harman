#include <stdio.h>
#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "sleep.h"

typedef struct{
	volatile uint32_t DR;
	volatile uint32_t CR;
}GPIO_TypeDef;

#define GPIO_BASEADDR 	0x40000000U
#define GPIOA			((GPIO_TypeDef*)GPIO_BASEADDR)

int Switch_getState(GPIO_TypeDef *GPIOx, int bit);

int main()
{
	int counter = 0;
	GPIOA->CR = 0xff00;

	while(1){
		xil_printf("counter : %d\n", counter ++);
		if(Switch_getState(GPIOA, 13)){
			GPIOA->DR ^= 0xf0;
		}
		if(Switch_getState(GPIOA, 8)){
			GPIOA->DR ^= 0x0f;
		}
		sleep(1);
	}
	return 0;
}

int Switch_getState(GPIO_TypeDef *GPIOx, int bit){
	int temp;
	temp = GPIOx->DR & (1U << bit);
	return (temp == 0) ? 0 : 1;
}
