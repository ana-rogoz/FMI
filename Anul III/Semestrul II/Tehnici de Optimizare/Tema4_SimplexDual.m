%% Minimize z = 29y1 + 10y2
% 3y1 + 2y2 >= 2
% 5y1 + y2 >= 3
% y1, y2 >= 0

% Minimizam functia obiectiv folosind duala
%% Maximize z = 2x1 + 3x2
% 3x1 + 5x2 <= 29
% 2x1 + x2 <= 10
% x1, x2 >= 0

A = [3 2; 5 1]
b = [2;3]
c = [29 10 0]

x_solutie = simplexDual(A,b,c);
% val. x1 = 0.57, x2 = 0.14 => val min = 18
function table = simplexDual(A, b, c)

    % convertim standard min in standard max
    A_ext = [A b; c]
    A_dual = transpose(A_ext)
    [n, m] = size(A_dual)
    table = [A_dual(1:n-1,1:m-1) eye(m-1) zeros(n-1, 1) A_dual(1:n-1, m);
             A_dual(n, 1:m-1)*(-1) zeros(1, m-1) 1 A_dual(n,m)]

    [n, m] = size(table);
    while 1
       coloana_most_negative = 1
       for i = 2:m
        if table(n, i) < table(n, coloana_most_negative)
            coloana_most_negative = i;
        end
       end
       
       if (table(n, coloana_most_negative) >= 0)
        break;
       end
       linia_min = 1;
        for i = 2:n-1
            if (table(i,m)/table(i,coloana_most_negative) < table(linia_min,m)/table(linia_min,coloana_most_negative))
                linia_min = i;
            end
        end
       table(linia_min,:) = table(linia_min,:)/table(linia_min, coloana_most_negative);
        
        for i = 1:n
            if i ~= linia_min
                l = table(i, coloana_most_negative)/table(linia_min, coloana_most_negative);
                table(i,:) = table(i,:) - l*table(linia_min,:);
            end
            
        end
        
    end

end