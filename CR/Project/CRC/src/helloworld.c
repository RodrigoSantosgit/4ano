#include <stdlib.h>
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "fsl.h"
#include "xtmrctr_l.h"
#include "xil_printf.h"

#include "stdbool.h"

#define min(a, b)	((a < b) ? a : b)

#define N	4000

void CRCsw(uint16_t* crc_out, uint32_t* data)
{
	size_t j;
	uint32_t crc = 0;

	crc ^= (*data);              /* data at top end, not bottom */
	//printf( "[4]%u \n",*data);
	for (j = 0; j < 32; j++) {
		if (((crc) & 0x80000000) == 0x80000000)   /* top bit, not bottom */
			crc = (crc << 1) ^ ((0x8005)<<16);  /* shift left, not right */
		else
			crc <<= 1;                  /* shift left, not right */
	}


	*crc_out =  crc>>16;
}

//MicroBlaze Processor Fast Simplex Link (FSL) Interface Macros
//The FSL channels are dedicated unidirectional point-to-point data streaming interfaces.
void CRChw(uint32_t* crc_outhw, uint32_t* data)
{
	//int* p;


		//xil_printf("\n Before putslx iteracao ", i);
		//int bit = *data & 0x80000000;
		//xil_printf("\n Bit to send (0x%x)",bit);
		putfslx(*data,0,FSL_DEFAULT);
		//getfslx(*crc_out, 0, FSL_DEFAULT);
		//*data = *data << 1;

		//xil_printf("\n Before getslx iteracao ");
		getfslx(*crc_outhw, 0, FSL_DEFAULT);

/*
	for (p = pSrc; p < pSrc + size; p++, pDst++)
	{
		putfslx(*p, 0, FSL_DEFAULT);	//macros: *p - o valor a passar, 0 - o n�mero da interface, FSL_DEFAULT - flags (by default)
//		Performs a get function on an input FSL of the MicroBlaze processor;
//		id is the FSL identifier and is a literal in the range of 0 to 7 (0 to 15 for MicroBlaze v7.00.a and later).
//		The semantics of the instruction is determined by the valid FSL macro flags, which are listed in Table 2
		getfslx(*pDst, 0, FSL_DEFAULT);
	}*/
}

/*bool CheckReversedEndianness(int* pData1, int* pData2, unsigned int size)
{
	int* p;

	for (p = pData1; p < pData1 + size; p++, pData2++)
	{
		if (*pData2 != ((((*p) << 24) & 0xFF000000) | (((*p) <<  8) & 0x00FF0000) |
						(((*p) >>  8) & 0x0000FF00) | (((*p) >> 24) & 0x000000FF)))
		{
			return FALSE;
		}
	}

	return TRUE;
}*/

void PrintDataArray(uint32_t *crc)
{
	//int* p;

	xil_printf("\n crc:  %u (0x%x)\n", *crc, *crc);
	/*for (p = pData; p < pData + size; p++)
	{
		xil_printf("%08x  ", *p);
	}*/
}

void PrintDataArray2(uint16_t *crc)
{
	//int* p;

	xil_printf("\n crc:  %u (0x%x)\n", *crc, *crc);
	/*for (p = pData; p < pData + size; p++)
	{
		xil_printf("%08x  ", *p);
	}*/
}

void ResetPerformanceTimer()
{
	// Disable a timer counter such that it stops running (base address of the device, the specific timer counter within the device)
	XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR, 0);
	/*
	 * Set the value that is loaded into the timer counter and cause it to
	 * be loaded into the timer counter
	 */
//	Set the Load Register of a timer counter to the specified value.
//	(the base address of the device, specific timer counter within the device, 32 bit value to be written to the register)
	XTmrCtr_SetLoadReg(XPAR_TMRCTR_0_BASEADDR, 0, 0);
//	Cause the timer counter to load it's Timer Counter Register with the value in the Load Register.
//	(the base address of the device, the specific timer counter within the device)
	XTmrCtr_LoadTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, 0);
//	Set the Control Status Register of a timer counter to the specified value.
//	(base address of the device, specific timer counter within the device, 32 bit value to be written to the register)
	XTmrCtr_SetControlStatusReg(XPAR_TMRCTR_0_BASEADDR, 0, 0x00000000);
}

void RestartPerformanceTimer()
{
	ResetPerformanceTimer();
	XTmrCtr_Enable(XPAR_TMRCTR_0_BASEADDR, 0);
}

unsigned int GetPerformanceTimer()
{
	return XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, 0);
}

unsigned int StopAndGetPerformanceTimer()
{
	XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR, 0);
	return GetPerformanceTimer();
}

int main()
{
	//int srcData[N], dstData[N];

	unsigned int timeElapsed;

	uint32_t value = 0xF9DDFA01;
	uint32_t value2 = 0xF9DDFA01;
	uint16_t crc_val_sw = 0x0000;
	uint32_t crc_val_hw = 0x00000000;

    init_platform();

    xil_printf("\n\rSoftware Only vs. Hardware Assisted CRC ENCODER Demonstration\n\r");
    // Software only

    RestartPerformanceTimer();

    //ReverseEndiannessSw(dstData, srcData, N);

    CRCsw(&crc_val_sw,&value);
    timeElapsed = StopAndGetPerformanceTimer();
    xil_printf("\n\rSoftware only crc time: %d microseconds ",
    		   timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
    PrintDataArray2(&crc_val_sw);
    //xil_printf("\n\rChecking result: %s\n\r",
    		   //CheckReversedEndianness(srcData, dstData, N) ? "OK" : "Error");

    // Hardware assisted



    RestartPerformanceTimer();
    CRChw(&crc_val_hw, &value2);
    timeElapsed = StopAndGetPerformanceTimer();
    xil_printf("\n\rHardware assisted crc enc time: %d microseconds",
    		   timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
    PrintDataArray(&crc_val_hw);
    //xil_printf("\n\rChecking result: %s\n\r",
   // 		   CheckReversedEndianness(srcData, dstData, N) ? "OK" : "Error");

    cleanup_platform();
    return 0;


}
