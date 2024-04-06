function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
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