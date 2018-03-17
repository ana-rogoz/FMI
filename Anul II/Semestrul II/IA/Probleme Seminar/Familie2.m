function p = Familie2(N) 

copii = [0 0 1 1; 0 1 0 1]
suma = 0;
n = 0;

for i = 1:N 
    idx = randi(4);
    pereche = copii(:,idx);
    if (pereche(1) == 0)
        n = n + 1;
        suma = suma + (1 - pereche(2));
    elseif (pereche(2) == 0)
        n = n + 1;
        suma = suma + (1 - pereche(1));
    end
end

p = suma / n;
end