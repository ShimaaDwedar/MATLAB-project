function [result,time,iter,xr,ea] = NewtonRaphson(Fun, NumIteration , DefaultEpsilon, Xguess)
         tic;
         syms x;
         p(1)=Xguess;
         Func(x)=str2sym('Func(x)');
         DFunc(x)=str2sym('DFunc(x)');
         Func(x)=Fun;
         DFunc(x)=diff(Func(x));
         f(1)=(Func(p(1)));
         %DFun=diff(Fun);
         dfdx(1)=(DFunc(p(1)));
         MaxIteration=NumIteration;
         for i=2 : MaxIteration
           p(i)=p(i-1)-(f(i-1)/dfdx(i-1));
           f(i)=(Func(p(i)));
           dfdx(i)=(DFunc(p(i)));
           ea=(abs(p(i)-p(i-1))/p(i))*100;
           if(ea< DefaultEpsilon)
             break;
           end
           iter=i;
         end
         if(iter>=MaxIteration)
           disp('The Root not found');
         end
         for i=2 : length(p)
            result(i-1,1)=i-1;
            result(i-1,2)=p(i);
            result(i-1,3)=p(i-1);
            result(i-1,4)=f(i);
            result(i-1,5)=dfdx(i);
            result(i-1,6)=(abs(p(i)-p(i-1))/p(i))*100;  
            xr=p(i);
         end 
         time=toc;
    end