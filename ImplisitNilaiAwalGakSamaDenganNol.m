clear all;
clc;
h=0.025;
k=0.0002;
%Program yg nilai awalnya gak = 0
x=0:h:1;
M=length(x);
t=0:k:2;
N=length(t);
d=1;
delta=d*(k/h^2);
u=zeros(N,M);
A=zeros(M,M);

%inisialisasi nilai awal
for j=1:M
    if x(j)<0.5
        u(1,j)=2;
    else
        u(1,j)=5;
    end
end
figure(1)
    plot(x,u(1,:));
    drawnow;

%inisialisasi syarat batas
for n=2:N
    u(n,1)=2;
    u(n,M)=5;
end

for i=1:M
    if i==M 
        A(M,M)=1;
    elseif i==1
        A(i,i)=1;
    else
        A(i,i)=1+(2*delta);
        A(i,i-1)=-delta;
        A(i,i+1)=-delta;
    end
end
for n=2:N
    u(n,:)=A\u(n-1,:)';
    figure(1)
    plot(x,u(n,:));
    drawnow;
end