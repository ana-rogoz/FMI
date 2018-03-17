function p = Cartoane(N)

cartoane = [1 1 0; 1 0 0];
suma = 0;
n = 0;

for i = 1:N
    idx = randi(3);
    carton = cartoane (:, idx);
    idx = randi(2);
    fata = carton(idx);
    
    if fata == 1 % evenimentul prima fata este alba conditionat de a doua
                 % fata este alba 
        suma = suma + carton(3-idx); %ambele fete albe 
        n = n + 1; %prima fata alba
    end
end

p = suma / n;
