function [x, y] = FunctionBeta_Executor(F)
% Note that F function expression is defined via Function Handle: F = @(x, y)(x+y)               
% change the function as you desire
h=0.15;                                             % step size (smaller step size gives more accurate solutions)
x = 0:h:3;                                          % x space
y = zeros(1,length(x));                             % Memory allocation
y(1) = 5;                                           % initial condition
for i=1:(length(x)-1)                             
% i=1:(length(x)-1)                              % calculation loop
    k1 = F(x(i),y(i));
    k2 = F(x(i)+0.5*h,y(i)+0.5*h*k1);
    k3 = F((x(i)+0.5*h),(y(i)+0.5*h*k2));
    k4 = F((x(i)+h),(y(i)+k3*h));
    y(i+1) = y(i) + (1/6)*(k1+2*k2+2*k3+k4)*h;  % main equation
end
figure, plot(x, y)  % To see the solution results
end