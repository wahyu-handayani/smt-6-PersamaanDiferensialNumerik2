clear all;
clc;
h=0.0025; %k h diluar syarat kestabilan
k=0.0003;
%Program teta yg nilai awalnya gak = 0
x=0:h:1;
M=length(x);
t=0:k:2;
N=length(t);
d=1;
delta=d*(k/h^2);
u=zeros(N,M);
theta=0;


for j=1:M
    if x(j)<0.5
        u(1,j)=2;
    else
        u(1,j)=5;
    end
end

for n=2:N
    u(n,1)=2;
    u(n,M)=5;
end

A=zeros(M,M);
for i=1:M
    if i==1
        A(1,1)=1;
        
    elseif i==M
        A(M,M)=1;
            
    else
            A(i,i)=1+(2*delta*theta);
            A(i,i-1)=-delta*theta;
            A(i,i+1)=-delta*theta;
    end
end
    
B=zeros(M,M);
for i=1:M
    if i==1
        B(1,1)=1;
        
    elseif i==M
        B(M,M)=1;
            
    else
            B(i,i)=1-(2*delta*(1-theta));
            B(i,i-1)=delta*(1-theta);
            B(i,i+1)=delta*(1-theta);
    end
end

for n=2:N
    u(n,:)=A\B*u(n-1,:)';
    figure(1)
    plot(x,u(n,:));
    
    drawnow;
end