clear all;
clc;
h=0.005;
k=0.01;
x=0:h:4;
M=length(x);
t=0:k:2;
N=length(t);
d=0.5;
delta=d*(k/h);
u=zeros(N,M);

%inisialisasi nilai awal
for j=1:M
    u(1,j)=exp(-50*(x(j)-0.5)^2);
end

%inisialisasi syarat batas
for n=2:N
    u(n,1)=0;
    u(n,M)=0;
end

%untuk mengisi tengah lax wendrof
for n=1:N
    for j=2:M-1
        u(n+1,j)=u(n,j)-0.5*delta*(u(n,j+1)-u(n,j-1))+0.5*(delta^2)*(u(n,j+1)-2*u(n,j)+u(n,j-1));       
    end
u2=u;
subplot(3,1,1)
plot(x,u(n,:)); %digunakan u(1,:) untuk menyesuaikan tampilan pada soal (berhenti saat x=0.5)
title('Metode Lax Wendroff');
grid on;
axis([0 4 0 1]);
drawnow;
end


%untuk mengisi tengah lax friedrich
for n=2:N
    for j=2:M-1
        u(n,j)=0.5*((1-delta)*u(n-1,j+1)+(1+delta)*u(n-1,j-1));   
    end
u1=u;
subplot(3,1,2);
plot(x,u(n,:)); %digunakan u(1,:) untuk menyesuaikan tampilan pada soal (berhenti saat x=0.5)
title('Metode Lax Friedrich');
grid on;
axis([0 4 0 1]);
drawnow;
end

%Solusi eksak
for n=1:N
    for j=1:M
        ueksak(n,j)=exp(-50*((x(j)-d*t(n))-0.5)^2);
    end
subplot(3,1,3);
plot(x,ueksak(n,:)); %digunakan u(1,:) untuk menyesuaikan tampilan pada soal (berhenti saat x=0.5)
title('Eksak');
grid on;
axis([0 4 0 1]);
drawnow
end

%MSE
for n=1:N
    err1(n)=sqrt((1/M)*sum((u1(n,:)-ueksak(n,:)).^2)); %lax friedrich
    err2(n)=sqrt((1/M)*sum((u2(n,:)-ueksak(n,:)).^2)); %lax wendroff
end
figure(2)
plot(err1,'x');
hold on;
plot(err2,'-r');
grid on;
legend('Error Lax Friedrich','Error Lax Wendroff');
