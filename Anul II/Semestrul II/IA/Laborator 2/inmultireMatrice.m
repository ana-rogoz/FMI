function [timp1,timp2] = inmultireMatrice(n) 

A=[];
B=[];
C=zeros(n);

for i = 1:n 
    for j = 1:n
        A(i,j) = i*j;
    end
end
        
for i = 1:n
    for j = 1:n
        B(i,j) = i + j;
    end
end
        
tic
for i = 1:n
    for j = 1:n
        suma = 0;
        for k = 1:n
            suma = suma + A(i,k).*B(k,j);
        end
        C(i,j) = suma;
    end
end

timp1 = toc;

tic 
C = A * B;
timp2 = toc;

end