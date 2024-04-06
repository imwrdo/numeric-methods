function Zad_2
format long
f = @(x) x.^2 - 4.01;
a = 0;
b = 4;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,f)
end

function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego
% b - prawa granica przedziału poszukiwań miejsca zerowego
% max_iterations - maksymalna liczba iteracji działania metody bisekcji
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od xtab(1)= (a+b)/2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));


    xsolution = [];
    ysolution = [];
    iterations = [];
    xtab = [];
    xdif = [];

    count = 0;
  
    while true
        count = count + 1;
        c = (a + b) / 2;
        xtab = [xtab; c];
        
        if size(xtab,1) >= 2
            xdif = [xdif; abs(xtab(end) - xtab(end - 1))];
        end
        fc = fun(c);
        if abs(fc) < ytolerance
            xsolution = c;
            ysolution = fc;
            iterations = count;
            count = 0;
            break;
        elseif count == max_iterations
            break;
        elseif fun(a) * fun(c) < 0
            b = c;
        else
            a = c;
        end
    end
end