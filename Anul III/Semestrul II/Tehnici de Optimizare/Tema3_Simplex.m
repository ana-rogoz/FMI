% Exemple: 
% minimize z = -x1 - x2 - x3
% 2*x1 + x4 <= 1
% 2*x2 + x5 <= 1
% 2*x1 + x6 <= 1
% x1,...,x6 >= 0

f_coef = [-1 -1 -1 0 0 0]
A = [2 0 0 1 0 0;
     0 2 0 0 1 0;
     0 0 2 0 0 1]
b = [1; 1; 1]

R_ind = [1 2 3]
B_ind = [4 5 6]

x_solutie = StandardMinimizationProblem(f_coef, A, b, B_ind, R_ind)

%%
function [x] = StandardMinimizationProblem(c, A, b, B_ind, R_ind) 
    n = length(A)
    m = length(A(:,1))
    x = zeros(n, 1)
    while 1
        % Pas 1: calculam B si x
        B = A(:, B_ind); 
        r_len = length(R_ind);
        b_len = length(B_ind);
        x = zeros(n, 1);
        aux = inv(B)*b;
        for i = 1:b_len
            x(B_ind(i)) = aux(i)
        end

        r = zeros(1, n);
        
        c_b = c(B_ind);
        solutie_optima = 1
        
        % Pas 2: calculam rj si facem testul de optim
        for i = 1:r_len
           r(R_ind(i)) = c(R_ind(i)) - c_b*inv(B)*A(:,R_ind(i));  
           if r(i) < 0
               solutie_optima = 0;
           end
        end
        
        if solutie_optima == 1
            break;
        end
        
        % Pas 3: calculam dj si facem testul de infinit
        d = zeros(n, n);
        solutie_infinit = 1;
        for i = 1:r_len
            aux = -inv(B)*A(:, R_ind(i));
            for j = 1:r_len
                d(R_ind(j),R_ind(i)) = aux(j) 
            end
            
            for j = 1:n
                if d(j, i) < 0
                    solutie_infinit = 0;
                end
            end
        end
        
        if solutie_infinit == 1
            display ("Solutie infinit");
            break;
        end
        
        % Pas 4: schimbarea bazei
        j_min = 1;
        for j = 2:r_len
            if r(R_ind(j)) < r(R_ind(j_min))
                j_min = j;
            end
        end
        
        i_min = 1;
        for i = 2:b_len
            if x(B_ind(i))/d(B_ind(i), R_ind(j_min)) > x(B_ind(i_min))/d(B_ind(i_min), R_ind(j_min))
                i_min = i;
            end
        end
        
        i_val = B_ind(i_min)
        j_val = R_ind(j_min)
        B_ind = [B_ind(1:i_min-1) B_ind(i_min+1:b_len) j_val]
        R_ind = [R_ind(1:j_min-1) R_ind(j_min+1:r_len) i_val]
    end
end

