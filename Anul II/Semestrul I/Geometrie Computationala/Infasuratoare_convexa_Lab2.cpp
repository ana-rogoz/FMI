#include<cstdio>
#include<vector>
#include<algorithm>
#include<cmath>
#define eps 1.e-4
using namespace std;

struct st
{
    double x,y;
};
st puncte[10],aux;

int v[120005];
int frecvente[4];
int produs_incrucisat(st a,st b,st c)
{
    double produs;
    produs=(b.x-a.x)*(c.y-b.y)-(b.y-a.y)*(c.x-b.x);
    if(fabs(produs) < eps)
        return 0;
    if(produs>=eps)
        return 1;
    return -1;
}

double distanta(st a, st b) {
    return (b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y);
}

bool cmp(st x,st y)
{
    return produs_incrucisat(puncte[0],x,y)>eps;
}

int main()
{

    freopen("date.in","r",stdin);
    freopen("date.out","w",stdout);

    int i,top;
    scanf("%lf%lf",&puncte[0].x,&puncte[0].y);
    for(i=1;i<4;i++) {
            scanf("%lf%lf",&puncte[i].x,&puncte[i].y);
            if((puncte[i].y-puncte[0].y)<-eps)
                {
                aux=puncte[0];
                puncte[0]=puncte[i];
                puncte[i]=aux;
                }
            else
            if(fabs(puncte[i].y-puncte[i].x)<eps)
                {
                    if(puncte[i].x-puncte[0].x<-eps)
                    {
                        aux=puncte[0];
                        puncte[0]=puncte[i];
                        puncte[i]=aux;
                    }
                }
        }

    sort(puncte+1,puncte+4,cmp);

    v[0]=0;
    v[1]=1;

    puncte[4]=puncte[0];
    top=1;
    i=2;
    while(i<=4)
    {
        if(produs_incrucisat(puncte[v[top-1]],puncte[v[top]],puncte[i])>0)
            {v[++top]=i;i++;}
        else
            if(produs_incrucisat(puncte[v[top-1]],puncte[v[top]],puncte[i]) == 0) {
                if(i != 4 && distanta(puncte[v[top]], puncte[v[top-1]]) < distanta(puncte[v[top-1]], puncte[i]))
                    v[top] = i, i++;
                else
                    break;
            }
            else
                top--;
    }

    if(top == 4)
        printf("Rezultatul este un patrulater. Multimea I este formata din punctele: %.2lf - %.2lf si %.2lf - %.2lf si multimea J din punctele: %.2lf - %.2lf si %.2lf - %.2lf", puncte[v[0]].x, puncte[v[0]].y, puncte[v[2]].x, puncte[v[2]].y, puncte[v[1]].x, puncte[v[1]].y, puncte[v[3]].x, puncte[v[3]].y);
    else
    if(top == 3) {
        int suma = 6 - v[0] - v[1] - v[2];
        printf("Rezultatul este un triunghi. Multimea I este formata din punctele: %.2lf - %.2lf, %.2lf - %.2lf si %.2lf - %.2lf, iar multimea J din punctul %.2lf - %.2lf", puncte[v[0]].x, puncte[v[0]].y, puncte[v[1]].x, puncte[v[1]].y, puncte[v[2]].x, puncte[v[2]].y, puncte[suma].x, puncte[suma].y);
    }
    else {
        frecvente[v[0]] = frecvente[v[1]] = 1;
        printf("Rezultatul este un segment. Multimea I este formata din punctele: %.2lf - %.2lf si %.2lf - %.2lf.", puncte[v[0]].x, puncte[v[0]].y, puncte[v[1]].x, puncte[v[1]].y);
        printf("Multimea J este formata din punctele: ");
        for(int i = 0; i < 4; i++)
            if(frecvente[i] == 0)
                printf("%.2lf - %.2lf ", puncte[i].x, puncte[i].y);
    }

    printf("\n");
    return 0;
}
