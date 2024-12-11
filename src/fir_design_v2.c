#define N_TAPS 13
#include "ac_int.h"

typedef ac_int<8,false> coef_t;
typedef ac_int<16,false> data_t;
typedef ac_int<8,false> acc_t;

void fir(data_t *y, data_t x) { 
	coef_t c[N_TAPS] = {1, 0, 10, 0, 50, 0, 100, 0, 50, 0, 10, 0, 1};
	static data_t shift_reg[N_TAPS];
	acc_t acc;
	int i;
	acc = 0;
Shift_Accum_Loop:
	for (i = N_TAPS-1; i >= 0; --i){
		if( i == 0 ){
			shift_reg[i] = x;	
		}else {
			shift_reg[i] = shift_reg[i-1];	
		}
		acc += shift_reg[i] * c[i];
	}
	*y = acc;
}

