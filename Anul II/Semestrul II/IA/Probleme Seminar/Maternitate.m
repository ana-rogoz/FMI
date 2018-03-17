function prob = Maternitate(N,f)

maternitate = [0 0 1 1; 0 1 0 1];
suma = 0;
n = 0;

probabilitati = [];
probabilitati(1) = 0.5 * 4 / (f + 4); % bb
probabilitati(2) = probabilitati(1) + 0.5 * f / (f + 4); % bf 
probabilitati(3) = probabilitati(2) + 0.5 * 3 / (f + 4); % fb
probabilitati(4) = 1; % ff

for i = 1:N
    nr = rand();
    if (nr <= probabilitati(1))
        idx = 1;
    elseif (nr <= probabilitati(2))
        idx = 2;
    elseif (nr <= probabilitati(3))
        idx = 3;
    else
        idx = 4;
    end
    eveniment = maternitate(:,idx);
    nascut = eveniment(1);
    brate = eveniment(2);
    if (brate == 0) % evenimentul tinut in brate baiat conditionat de 
                    % s-a nascut baiat
      suma = suma + (1-nascut);
      n = n + 1;
    end
end

prob = suma / n;
end