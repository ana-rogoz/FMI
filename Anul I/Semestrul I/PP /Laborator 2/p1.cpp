#include<stdio.h>
int main()
{
    int n;
    scanf("%d", &n);
    for(int i = 15; i >= 0; i--)
        printf("%d", (n>>i)&1);
    printf("\n");
    return 0;
}
