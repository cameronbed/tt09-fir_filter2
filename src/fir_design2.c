#define N_TAPS 13
#include "ac_int.h"

typedef int coef_t;
typedef int data_t;
typedef int acc_t;

void fir(data_t *y, data_t x) { 
	coef_t c[N_TAPS] = {-86, 0, 62, 0, 400, 0, 999, 0, 400, 0, 62, 0, -86};
	static data_t shift_reg[N_TAPS];
	acc_t acc;
	int i;
	acc = 0;
Shift_Accum_Loop:
	for (i = N_TAPS-1; i >= 0; i--){
		if( i == 0 ){
			acc += x * c[0];
			shift_reg[0] = x;
		}else {
			shift_reg[i] = shift_reg[i-1];
			acc += shift_reg[i] * c[i];
		}
	}
	*y = acc;
}


