function p = MontyHall(N) 

suma = 0;

for i = 1:N
    usaJucator = randi(3);
    usaMasina = randi(3);
    usaMontyHall = 0;
    
    if (usaJucator == usaMasina) 
        usaMontyHall = randi(2);
        if (usaJucator == 1 && usaMontyHall == 1)
            usaMontyHall = 2;
        end
        if (usaJucator == 1 && usaMontyHall == 2)
            usaMontyHall = 3;
        end
        if (usaJucator == 2 && usaMontyHall == 1)
            usaMontyHall = 1;
        end
        if (usaJucator == 2 && usaMontyHall == 2)
            usaMontyHall = 3;
        end
        if (usaJucator == 3 && usaMontyHall == 1)
            usaMontyHall = 1;
        end
        if (usaJucator == 3 && usaMontyHall == 2)
            usaMontyHall = 2;
        end    
    end  
    
    if (usaJucator ~= usaMasina)
        usaMontyHall = 6 - usaJucator - usaMasina;
    end
    
    usaJucator = 6 - usaJucator - usaMontyHall;
    if (usaJucator == usaMasina) 
        suma = suma + 1;
    end
end   
   
p = suma / N;
end
     
        
    