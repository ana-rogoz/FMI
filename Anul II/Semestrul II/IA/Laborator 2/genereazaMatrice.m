function [matrice] = genereazaMatrice(n) 

%for i=1:n
%   for j=max(1,i-1):i+1
%       matrice(i,j) = -1 + 3*(i==j)
%   end
%end

% -1 de sub diagonala -- matrice nxn 
E = [zeros(1,n);-eye(n-1) zeros(n-1,1)];
% -1 de deasupra diagonalei -- matrice nxn
F = [zeros(n-1,1) -eye(n-1);zeros(1,n)];
% 2 de pe diagonala principala -- matrice nxn
D = 2*eye(n);
% Coloana n+1 cu -1 pe ultima pozitie
C = zeros(n,1);
C(n) = -1;

B = E + F + D;
matrice = [B C];
end
