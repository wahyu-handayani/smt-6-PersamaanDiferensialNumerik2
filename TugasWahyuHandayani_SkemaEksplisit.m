clear all;
clc;
h=0.025;
k=0.005;
x=0:h:5;
M=length(x);
t=0:k:2.5;
N=length(t);
d=5;
delta=d*(k/h^2);
u=zeros(N,M);

for j=1:M
    if x(j)<=2.5
        u(1,j)=-8;
    else
        u(1,j)=5;
    end
end
figure(1)
plot(x,u(1,:));
axis([0 5 -10 10]);
drawnow;

for n=2:N
    u(n,1)=-5;
    u(n,M)=5;
end

for n=1:N-1
    for j=2:M-1
        u(n+1,j)=u(n,j)+delta*(u(n,j+1)-2*u(n,j)+u(n,j-1));
    end
    figure(1);
    plot(x,u(n,:));
    axis([0 5 -10 10]);
    drawnow;
end