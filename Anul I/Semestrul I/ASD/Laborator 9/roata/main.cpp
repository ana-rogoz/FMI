#include<stdio.h>
#include<stdlib.h>
struct str
{
	long v;
	int nr;
};

const int NMAX = 100000;
str s[NMAX + 2];

int cmp(const void *a, const void *b)
{
	str *pa,*pb;
	pa = (str*)a;
	pb = (str*)b;
	if(pa->v == pb->v) {

			if(pa->nr < pb->nr)
				return -1;
			else
				return 0;
    }

	if(pa->v < pb->v)
		return -1;
	return 1;
}

int main()
{
	freopen("roata.in","r",stdin);
	freopen("roata.out","w",stdout);

	int n;
	int p, minim, suma=0, maxim, i, j;

	scanf("%d %d", &n, &p);

	for(i = 1; i <= p; ++i) {

		scanf("%d", &s[i].v);
		s[i].nr = i;
		suma += s[i].v;
	}

	printf("%d\n", suma);

	while(n < p) {

		minim = s[1].v;

		for(i = 2; i <= n; ++i)
			if(s[i].v < minim) {

					minim = s[i].v;
					if(minim == 0)
						break;
            }

		if(minim!=0) {

            for(i = 1;i <= n; ++i)
                s[i].v = s[i].v - minim;
		}

		for(i = 1;i <= n; ++i)
			if(s[i].v == 0) {

				printf("%d ", s[i].nr);
				s[i].v = s[n + 1].v;
				s[i].nr = s[n + 1].nr;
				for(j = n + 1; j <= p; ++j) {

					s[j].v = s[j + 1].v;
					s[j].nr = s[j + 1].nr;
				}

				--p;
				break;
			}
	}

	maxim = p;

	for(i = p-1; i >= 1; --i)
		if(s[i].v > s[maxim].v)
			maxim = i;

	qsort(s + 1, p, sizeof(s[0]),cmp);

	for(i = 1; i <= p; ++i)
		printf("%d ",s[i].nr);

	printf("\n%d\n",maxim);
	return 0;
}
