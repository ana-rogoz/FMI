function [timp1] = adunaElemente2()

n = [10 100 1000 5000];
timp1 = zeros(size(n));
for i=1:length(n) 
    A = rand(n(i));
    tic;
    s = adunaElemente(A);
    timp1(i) = toc;
end
