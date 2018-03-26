function [w,b,er] =  algoritmRosenblattOnline(X, T, nrMaxEpoci)

n = size(X,2); %(X,2) e numarul de coloane  
               %(X,1) e numarul de linii
d = size(X,1);

epocaCurenta = 1;
w = rand(d,1);
b = 0;
er = [];

while (epocaCurenta <= nrMaxEpoci) 
    nrExempleGresite = 0;
    for i=1:n
       y = hardlims(w'*X(:,i) + b);
       if (y ~= T(i))
           w = w + X(:,i)*T(i);
           b = b + T(i);
           nrExempleGresite = nrExempleGresite + 1;
       end
    end
    
    er(epocaCurenta) = nrExempleGresite / n;
    epocaCurenta = epocaCurenta + 1;
    if (nrExempleGresite == 0)
        return;
    end
end

end