#include<stdio.h>
int main()
{
	int p, k;
	scanf("%d", &p);
	for(int i = 1; i <= p; i++)
        for(int j = 1; j <= p; j++)
        {
            k = p - (i+j);
            if( i + j > k && i + k > j && j + k > i)
                printf("%d %d %d\n", i, j, k);
        }

    return 0;
}
