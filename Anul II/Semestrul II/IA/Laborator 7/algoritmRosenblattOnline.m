function [wstar, bstar, Err] = algoritmRosenblattOnline(X,T,nrMaximEpoci)

if nargin < 3
    nrMaximEpoci = 100;
end

%initializare parametri hiperplan - w si b
w = zeros(size(X,1),1);
b = 0;

epocaCurenta = 1;
nrExempleAntrenare = size(X,2);
Err = [];
while (epocaCurenta <= nrMaximEpoci)
   nrExempleMisclasate = 0;
   for i=1:nrExempleAntrenare
       y = hardlims(w'*X(:,i)+b);
       if y ~= T(i) 
           nrExempleMisclasate = nrExempleMisclasate + 1;
           w = w + T(i)*X(:,i);
           b = b + T(i);
       end
   end
   Err(epocaCurenta) = nrExempleMisclasate/nrExempleAntrenare;
         
   if nrExempleMisclasate ==0
       break;
   end
   epocaCurenta = epocaCurenta + 1;
end
wstar = w;
bstar = b;