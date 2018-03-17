function [suma] = adunaElemente(A)
minMatrice = min(A(:));
suma=0;
for i=1:size(A,1)
    for j=1:size(A,2)
        if A(i,j) == minMatrice
            return;
        else
            suma = suma + A(i,j);
        end
    end
end
end
