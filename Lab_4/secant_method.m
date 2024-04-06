function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
xsolution = [];
ysolution = [];
iterations = [];
xtab = [];
xdif = [];
x0 = a;
x1 = b;
    for k = 1:max_iterations
      
        x_next = x1 - fun(x1) * (x1 - x0) / (fun(x1) - fun(x0));
    
        xtab = [xtab; x_next];
        
       
        if k > 1
            xdif = [xdif; abs(xtab(k) - xtab(k - 1))];
        end
        
        if abs(fun(x_next)) < ytolerance
            xsolution = x_next;
            ysolution = fun(x_next);
            iterations = k;
            return;
        end
   
        x0 = x1;
        x1 = x_next;
    end

warning('Maximum number of iterations reached without convergence.');
xsolution = x_next;
ysolution = fun(x_next);
iterations = max_iterations;
end