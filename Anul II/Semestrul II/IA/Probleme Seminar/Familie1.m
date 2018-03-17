function p = Familie1(N) 

copii = [0 0 1 1; 1 0 1 0]
suma = 0;
n = 0;

for i=1:N 
    idx = randi(4);
    pereche = copii(:,idx);
    if(pereche(1) == 0)
        suma = suma + (1 - pereche(2));
        n = n + 1;
    end
end

p = suma / n;
end