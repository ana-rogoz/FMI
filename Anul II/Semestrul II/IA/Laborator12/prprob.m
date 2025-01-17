function [alphabet,targets] = prprob()
%PRPROB Character recognition problem definition
%  [ALHABET,TARGETS] = PRPROB()
letterA =  [0 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1]';
letterB =  [ 1 1 1 1 1 1 1 1 0 ...
             1 1 1 1 1 1 1 1 0 ...
             1 1 0 0 0 0 1 1 1 ...
             1 1 0 0 0 0 1 1 1 ...
             1 1 1 1 1 1 1 1 1 ...
             1 1 1 1 1 1 1 1 0 ...
             1 1 0 0 0 0 1 1 1 ...
             1 1 0 0 0 0 1 1 1 ...
             1 1 1 1 1 1 1 1 1 ...
             1 1 1 1 1 1 1 1 0]';
letterC =  [0 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 0]';
letterD =  [1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0]';
letterE =  [1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1]';
letterF =  [1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ... 
            1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0]';
letterG =  [0 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 1 1 1 1 1 ...
            1 1 0 0 1 1 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 1 1 1 1 1 1 1 0]';
letterH =  [1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1]';
letterI =  [0 0 1 1 1 1 1 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 1 1 1 1 1 0 0]';
letterJ =  [0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 1 1 1 1 1 1 1 0]';
letterK =  [1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 1 1 1 0 ...
            1 1 0 0 1 1 0 0 0 ...
            1 1 1 1 1 1 0 0 0 ...
            1 1 1 1 1 1 0 0 0 ...
            1 1 0 0 1 1 0 0 0 ...
            1 1 0 0 1 1 1 1 0 ...
            1 1 0 0 0 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1]';
letterL =  [1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0]';
letterM =  [1 1 0 0 0 0 0 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 1 0 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 0 1 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1]';
letterN =  [1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 0 0 0 0 1 1 ...
            1 1 1 1 0 0 0 1 1 ...
            1 1 1 1 1 1 0 1 1 ...
            1 1 0 1 1 1 1 1 1 ...
            1 1 0 0 0 1 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1]';
letterO =  [0 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 1 1 1 1 1 1 1 0]';
letterP =  [1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 0 0 0 0 0 0 0]';
letterQ =  [0 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 0 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 1 1 1 1 1 1 1 0 ...
            0 0 0 0 0 0 1 1 1]';
letterR =  [1 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 1 1 1 0 0 ...
            1 1 0 0 0 1 1 0 0 ...
            1 1 0 0 0 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1]';
letterS =  [0 1 1 1 1 1 1 1 0 ...
            1 1 1 1 1 1 1 1 0 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 0 0 0 ...
            1 1 1 1 1 1 1 1 0 ...
            0 1 1 1 1 1 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            1 1 0 0 0 0 1 1 1 ...
            0 1 1 1 1 1 1 1 0]';
letterT =  [1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0]';
letterU =  [1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 1 1 1 1 1 1 1 0]';
letterV =  [1 0 0 0 0 0 0 0 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 0 0 0 0 0 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            0 1 1 0 0 0 1 1 0 ...
            0 1 1 1 0 1 1 1 0 ...
            0 0 1 1 1 1 1 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 0 1 0 0 0 0]';
letterW =  [1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 0 1 1 1 0 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 1 1 1 0 1 1 1 0]';
letterX =  [1 1 0 0 0 0 0 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            0 1 1 1 0 1 1 1 0 ...
            0 0 1 1 1 1 1 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 1 1 1 1 1 0 0 ...
            0 1 1 1 0 1 1 1 0 ...
            1 1 1 0 0 0 1 1 1 ...
            1 1 0 0 0 0 0 1 1]';
letterY =  [1 1 0 0 0 0 0 1 1 ...
            1 1 1 0 0 0 1 1 1 ...
            0 1 1 0 0 0 1 1 0 ...
            0 1 1 1 1 1 1 1 0 ...
            0 0 1 1 1 1 1 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 0 0 1 1 1 0 0 0]';
letterZ =  [1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1 ...
            0 0 0 0 0 0 1 1 1 ...
            0 0 0 0 0 1 1 1 1 ...
            0 0 0 0 1 1 1 1 0 ...
            0 0 0 1 1 1 0 0 0 ...
            0 1 1 1 1 0 0 0 0 ...
            1 1 1 1 0 0 0 0 0 ...
            1 1 1 1 1 1 1 1 1 ...
            1 1 1 1 1 1 1 1 1]';
alphabet = [letterA,letterB,letterC,letterD,letterE,letterF,letterG,letterH,...
            letterI,letterJ,letterK,letterL,letterM,letterN,letterO,letterP,...
            letterQ,letterR,letterS,letterT,letterU,letterV,letterW,letterX,...
            letterY,letterZ];
targets = eye(26);
  end