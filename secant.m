function [result,time,iter,xc,e] = secant(f, n, epsilon, xp, xc)
    tic;
    fp = f(xp);
    fc = f(xc);
    e = 100;
    for i = 1:n
        iter=i;
        xn = xc - fc * (xp - xc) / (fp - fc);
        e = abs ((xn - xc) / xn) * 100 ;
        result(i,1)=i;
        result(i,2)=xp;
        result(i,3)=xc;
        result(i,4)=fp;
        result(i,5)=fc;
        result(i,6)=xn;
        result(i,7)=e;
        fn = f(xn);
        xp = xc;
        fp = fc;
        xc = xn;
        fc = fn;
        if(e <= epsilon)
            break;
        end
        
    end
   time= toc;
end