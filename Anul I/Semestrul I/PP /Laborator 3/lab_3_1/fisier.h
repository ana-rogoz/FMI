char switch_litera(char a)
{
    if(a >= 'a' && a <= 'z')
        return a - 32;
    else
        return a + 32;

}


int eval(int a, char op, int b)
{
    switch(op)
    {
        case '+':
            return a + b;

        case '-':
            return a-b;
        case '*':
            return a*b;
        case '/':
        {
            if(b == 0)
                return -1;
            return a/b;
        }
        case '%':
            return a%b;
        default:
            return -1;

    }

}
