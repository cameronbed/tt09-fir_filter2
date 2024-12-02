#include <stdio.h>

typedef int data_t;
void fir(data_t *y, data_t x);

int main(){
	int y;
	for (int i =0; i < 30; i++)
	{
		fir(&y, i);
		printf("i: %d - y: %d\n", i, y);
	}
	return 0;
}
