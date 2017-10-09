#include<stdio.h>
struct myqueue {

    int val;
    myqueue *next;
}*last;

void push(int val, myqueue *&coada) {

    myqueue *p;
    p = new myqueue;
    p->next = NULL;
    p->val = val;

    if(coada == NULL) {
        coada = p;
        last = coada;
    }
    else {

        last->next = p;
        last = p;
    }
}

void pop(myqueue *&coada) {

    myqueue *temp = coada;
    coada = coada->next;
    delete temp;
}

bool emptyqueue(myqueue *&coada) {

    if(coada == NULL)
        return false;
    return true;

}

int firstQueue(myqueue *&coada) {

    return coada->val;

}


int searchqueue(int x, myqueue *&coada) {

    int dist = 0;
    myqueue *i;
    for(i = coada; i != NULL; i = i->next) {
        if(i->val == x)
            return dist;
        dist++;
    }

    return -1;

}

void afisare(myqueue *&coada) {

    myqueue *i;
    for(i = coada; i != NULL; i = i->next) {
        printf("%d ", i->val);
    }

    printf("\n");
}

int main() {

    freopen("date.in", "r", stdin);

    myqueue *coada = NULL;
    int n, x;
    scanf("%d", &n);
    for(int i = 1; i <= n; i++) {
        scanf("%d", &x);
        push(x, coada);
    }

    afisare(coada);
    return 0;
}





