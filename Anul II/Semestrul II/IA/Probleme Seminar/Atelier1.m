function p = Atelier1(N) 
 
suma = 0; 

for i = 1:N
    idx = rand(); 
    if (idx <= 0.3 && idx <= 0.006) %idx a picat pe M1, adica <= 0.3 si verific daca a picat pe piesele rebut din M1 adica <= 0.006
        suma = suma + 1;
    end
   
    if (idx > 0.3 && idx <= 0.5 && idx <= 0.306) %idx a picat pe M2, adica <= 0.5 si > 0.3 si verific daca a picat pe piesele rebut din M2 adica <= 0.306
        suma = suma + 1;
    end
    
    if (idx > 0.5 && idx <= 1 && idx <= 0.505) %idx a picat pe M3, adica <= 1 si > 0.5 si verific daca a picat pe piesele rebut din M3 adica <= 0.505
        suma = suma + 1;

    end
end

p = suma / N;
end