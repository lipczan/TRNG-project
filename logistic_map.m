function [x]=logistic_map(x0,r,N)


x(1)=x0;


for n=1:N
    x(n+1)=r.*x(n).*(1-x(n));
end
figure
subplot(2, 1, 1)
plot(x(1:N), x(2:N+1),'rs-')
ylabel('x(i+1)')
xlabel('x(i)')
title('x(i+1) vs x(i)')

subplot(2, 1, 2)
plot(1:N+1,x)
axis([0 N 0.2 1])
ylabel('x(i)')
xlabel('(i)')
title('x[i] vs. i')

end