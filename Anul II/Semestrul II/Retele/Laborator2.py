l = [1,3,7,10,'s','a']

def functie(lista):
    
    # comment pentru hello world
    variabila = 'hello "world"'
    print variabila
    
    # int:
    x = 1 + 1
    
    # str:
    xs = str(x) + ' ' + variabila
    
    # tuplu
    tup = (x, xs)
    
    # lista
    l = [1, 2, 2, 3, 3, 4, x, xs, tup]
    print l[2:]
    
    # set
    s = set(l)
    print s
    print s.intersection(set([4, 4, 4, 1]))
    
    # dict:
    d = {'grupa': 123, "nr_studenti": 10}
    print d['grupa'], d['nr_studenti']
    
    
    lista = [1,5,7,8,2,5,2]
    for element in lista:
        print element
    
    for idx, element in enumerate(lista):
        print idx, element
    
    for idx in range(0, len(lista)):
        print lista[idx]
    
    idx = 0
    while idx < len(lista):
        print lista[idx]
        idx += 1
        
    '''
       comment pe
       mai multe
       linii
    '''
    x = 1
    y = 2
    print x + y
    if (x == 1 and y == 2) or (x==2 and y == 1):
        print " x e egal cu:", x, ' si y e egal cu: ', y
    elif x == y:
        print 'sunt la fel'
    else:
        print "nimic nu e adevarat"
        
        
functie(l)