#include<cstdio>
using namespace std;

struct myqueue {

    int val, cheie;
    myqueue *next;
} *first, *last;

void add_value(int x, int k, myqueue *&first, myqueue *&last) {

    myqueue *p;
    p = new myqueue;
    p->val = x;
    p->cheie = k;
    p->next = NULL;
    if(first == NULL) {

        first = p;
        last = first;
    }
    else {

        if(first->cheie > p->cheie) {
            p->next = first;
            first = p;
        }
        else
        if(last->cheie <= p->cheie) {
            last->next = p;
            last = p;

        }
        else {

            myqueue *i, *next;
            i = first;
            while(i!=NULL) {
                next = i->next;
                if(next->cheie > p->cheie) {
                    p->next = next;
                    i->next = p;
                    break;
                }
                i = next;

            }

        }

    }
}


void pop_node(myqueue *&first) {

    myqueue *p;
    p = first->next;
    first = p;

}

void afisare(myqueue *&first) {

    myqueue *i;
    for(i = first; i != NULL; i=i->next)
        printf("%d-%d ", i->val, i->cheie);

    printf("\n");
}
int main() {


    freopen("date.in", "r", stdin);

    int n, x, k;
    scanf("%d", &n);

    for(int i = 1; i <= n; i++) {
        scanf("%d%d", &x, &k);
        add_value(x, k, first, last);
    }

    afisare(first);
    return 0;
}
