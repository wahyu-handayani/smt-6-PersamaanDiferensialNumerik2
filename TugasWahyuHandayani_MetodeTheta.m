clc;
clear all;
h=0.025;
k=0.0005;
theta=0.5; %Crank Nicholson (theta=0.5)
x=0:h:1;
M=length(x);
t=0:k:0.25;
N=length(t);
d=0.25;
delta=d*(k/h^2);
u=zeros(N,M);

for j=1:M
    if x(j)<0.5
        u(1,j)=2*x(j);
    else
        u(1,j)=2-2*x(j);
    end
end

for n=2:N
    u(n,1)=0;
    u(n,M)=0;
end

A=zeros(M-2,M-2);
for i=1:M-2
    if i==1
        A(1,1)=1+(2*delta*theta);
        A(1,2)=-delta*theta;
    elseif i==M-2
            A(M-2,M-3)=-delta*theta;
            A(M-2,M-2)=1+(2*delta*theta);
    else
            A(i,i)=1+(2*delta*theta);
            A(i,i-1)=-delta*theta;
            A(i,i+1)=-delta*theta;
    end
end
    
B=zeros(M-2,M-2);
for i=1:M-2
    if i==1
        B(1,1)=1-(2*delta*(1-theta));
        B(1,2)=delta*(1-theta);
    elseif i==M-2
            B(M-2,M-3)=delta*(1-theta);
            B(M-2,M-2)=1-(2*delta*(1-theta));
    else
            B(i,i)=1-(2*delta*(1-theta));
            B(i,i-1)=delta*(1-theta);
            B(i,i+1)=delta*(1-theta);
    end
end

for n=2:N
    u(n,2:M-1)=A\B*u(n-1,2:M-1)';
    figure(1)
    plot(x,u(n,:));
    axis([0 1 0 1]);
    drawnow;
end