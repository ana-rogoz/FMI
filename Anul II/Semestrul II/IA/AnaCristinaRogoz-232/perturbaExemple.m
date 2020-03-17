function [XnPerturbat] = perturbaExemple(Xn, sigma) 

nrLinii = size(Xn,1);
nrColoane = size(Xn, 2);

XnPerturbat = Xn + randn(nrLinii, nrColoane)*sigma;
for i = 1:nrLinii
    for j = 1:nrColoane
        if XnPerturbat(i,j) < 0
            XnPerturbat(i,j) = 0;
        end
        if XnPerturbat(i, j) > 1
            XnPerturbat(i,j) = 1;
        end
    end
end

end
