function E = calculeazaEroare ( S , P )

predictii = polyval ( P, S(1,:) );

E = sum( ( S( 2, :) - predictii ).^2 );

