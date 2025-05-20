#include <stdio.h>
#include <stdint.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"

#define SPI_BASEADDR 0x44a00000U

typedef struct{
	volatile u_int32_t CR;
	volatile u_int32_t SOD;
	volatile u_int32_t SID;
	volatile u_int32_t SR;
}SPI_Master_TypeDef;

#define GPSPI ((SPI_Master_TypeDef*)SPI_BASEADDR)

int main()
{
	init_platform();
	GPSPI->CR = 0b001;
	usleep(100);
	GPSPI->SOD = 0b11111110;
	usleep(100);
	GPSPI->CR = 0b000;
	usleep(10);

	if (GPSPI->SR && 0b10)
		xil_printf("rx_data : %d\n, rx_done : %d\n, rx_ready : %d\n", GPSPI->SID, GPSPI->SR && 0b10, GPSPI->SR && 0b01);
    cleanup_platform();
	return 0;

}
