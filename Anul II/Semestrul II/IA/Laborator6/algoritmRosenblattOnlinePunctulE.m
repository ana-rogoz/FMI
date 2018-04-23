
function [wstar,bstar,er,lungimeMax] =  algoritmRosenblattOnlinePunctulE(X, T, nrMaxEpoci)

n = size(X,2); %(X,2) e numarul de coloane  
               %(X,1) e numarul de linii
d = size(X,1);

epocaCurenta = 1;
w = rand(d,1);
b = 0;
er = [];

bestW = zeros(d,1); %in caz ca multimile nu sunt liniar separabile
bestB = 0;          %cautam w si b care clasifica corect cel mai mare  
lungimeMax = 0;     %numar de exemple consecutiv
lungimeCurenta = 0;

while (epocaCurenta <= nrMaxEpoci) 
    permutare = randperm(n); %alegem o ordine aleatoare pentru parcurgerea
                             %multimii de antrenare 
    nrExempleGresite = 0;
    for i=1:n
       index = permutare(i); %luam indicele exemplului dat de permutare
       y = hardlims(w'*X(:,index) + b);
       if (y ~= T(index))
           if(lungimeCurenta > lungimeMax)
               lungimeMax = lungimeCurenta;
               bestW = w;
               bestB = b;
           end
           lungimeCurenta = 0;
           w = w + X(:,index)*T(index);
           b = b + T(index);
           nrExempleGresite = nrExempleGresite + 1;
       else
           lungimeCurenta = lungimeCurenta + 1; %exemplul e corect clasificat
       end
    end
    
    er(epocaCurenta) = nrExempleGresite / n;
    epocaCurenta = epocaCurenta + 1;
    if (nrExempleGresite == 0)
        break;
    end
end

% verificam si ultimele valori pentru w si b 
if(lungimeCurenta > lungimeMax)
    lungimeMax = lungimeCurenta;
    bestW = w;
    bestB = b;
end

if (epocaCurenta == nrMaxEpoci + 1) %multimea nu este liniar separabila
    wstar = bestW;
    bstar = bestB;
else                                %multimea este liniar separabila
    wstar = w;
    bstar = b;
end

end