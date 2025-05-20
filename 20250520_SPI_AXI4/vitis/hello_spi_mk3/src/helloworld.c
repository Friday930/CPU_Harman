#include <sleep.h>
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"

#define SPI_BASEADDR 0x44a00000U
typedef struct {
   volatile uint32_t CD;
   volatile uint32_t SOD;
   volatile uint32_t SID;
   volatile uint32_t SR;
}SPI_typedef;

#define GPSPI ((SPI_typedef*) SPI_BASEADDR)

int main()
{
    GPSPI->CD = 0b001;
    usleep(100);
    GPSPI->SOD = 'a';
    usleep(100);
    GPSPI->CD = 0b000;
    usleep(100);
    printf("SID: %c\n", GPSPI->SID);
    return 0;
}
