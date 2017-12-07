#include<cstdio>
using namespace std;

struct punct {

    double x, y, z;
};

bool dif(punct a, punct b) {

    if(a.x == b.x && a.y == b.y && a.z == b.z)
        return false;
    return true;
}

void verificare(punct a1, punct a2, punct a3) {

    double a;
    if(dif(a1, a2) == false) {
        printf("Punctele sunt coliniare.\n");
        printf("A1 = 1 * A2 + 0 * A3\n");
    }
    else
    if(dif(a1, a3) == false) {
        printf("Punctele sunt coliniare.\n");
        printf("A1 = 1 * A3 + 0 * A2\n");
    }
    else
    if(dif(a2, a3) == false) {
        printf("Punctele sunt coliniare.\n");
        printf("A2 = 1 * A3 + 0 * A1\n");
    }
    else
    if(dif(a1, a2) == true) {

        if(a2.x != a1.x) {

            a = (a3.x - a1.x) / (a2.x - a1.x);

            if((a3.y - a1.y == a * (a2.y - a1.y)) && (a3.z - a1.z == a * (a2.z - a1.z))) {
                printf("Punctele sunt coliniare.\n", a);
                printf("A3 = (%.2lf) * A1 + (%.2lf) * A2\n", 1-a, a);
            }
            else
                printf("Punctele nu sunt coliniare.\n");
        }
        else
        if(a2.y != a1.y) {

            a = (a3.y - a1.y) / (a2.y - a1.y);

            if((a3.x - a1.x == a * (a2.x - a1.x)) && (a3.z - a1.z == a * (a2.z - a1.z))) {
                printf("Punctele sunt coliniare.\n", a);
                printf("A3 = (%.2lf) * A1 + (%.2lf) * A2\n", 1-a, a);
            }
            else
                printf("Punctele nu sunt coliniare.\n");
        }
        else {

            a = (a3.z - a1.z) / (a2.z - a1.z);

            if((a3.x - a1.x == a * (a2.x - a1.x)) && (a3.y - a1.y == a * (a2.y - a1.y))) {
                printf("Punctele sunt coliniare.\n", a);
                printf("A3 = (%.2lf) * A1 + (%.2lf) * A2\n", 1-a, a);
            }
            else
                printf("Punctele nu sunt coliniare.\n");
        }
    }
}

int main() {

    freopen("date.in", "r", stdin);
    freopen("date.out", "w", stdout);

    punct a1, a2, a3;
    scanf("%lf%lf%lf", &a1.x, &a1.y, &a1.z);
    scanf("%lf%lf%lf", &a2.x, &a2.y, &a2.z);
    scanf("%lf%lf%lf", &a3.x, &a3.y, &a3.z);

    verificare(a1, a2, a3);

    return 0;
}
