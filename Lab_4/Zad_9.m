function Zad_9
options = optimset('Display','iter');
[x_01,fval_01,exitflag_1,output_1]=fzero(@tan,6, options);
fprintf('\nPunkt startowy 6 :\n')
fprintf('Wartosc x01: %f\n',x_01);
fprintf('Wartosc funkcji: %f\n',fval_01);
fprintf('Wartosc flagi wyjsciowej: %f\n',exitflag_1);
fprintf('Dodatkowa informacja: \n');
disp(output_1.message);

[x_02,fval_02,exitflag_2,output_2]=fzero(@tan,4.5, options);
fprintf('\nPunkt startowy 4.5 :\n');
fprintf('Wartosc x02: %f\n',x_02);
fprintf('Wartosc funkcji: %f\n',fval_02);
fprintf('Wartosc flagi wyjsciowej: %f\n',exitflag_2);
fprintf('Dodatkowa informacja: \n');
disp(output_2.message);
end