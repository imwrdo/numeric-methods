function Zad_1
omega = 10;
impedance_delta = impedance_magnitude(omega)
end

function impedance_delta = impedance_magnitude(omega)
if omega<=0
    error("Zła omega");
end
R = 525;
C = 7e-5 ;
L = 3;
M = 75; % docelowa wartość modułu impedancji


Z = 1/sqrt((1/(R^2))+(omega*C-(1/(omega*L)))^2) ;


impedance_delta = Z - M;

end
