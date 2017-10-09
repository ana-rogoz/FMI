#include<stdio.h>
int main()
{
    /*short int i, n;
    scanf("%hd", &n);
    for(i = 15; i >= 0; i--)
        printf("%hd", (n>>i)&1);
    printf("\n"); */


    int n, op, sum;
    scanf("%d", &n);
    scanf("%d", &op);

    switch(op)
    {
        case 1: {
            sum = 0;
            do
            {
                sum += n%10;
                n/=10;
            } while(n > 0);

            printf("%d", sum);
            break;
        }

        case 2: {
            printf("%d", n%9);
            break;
        }

        default:
            break;

    }
    return 0;
}
