clc;
clear all;
h=0.025;
k=0.0005;
x=0:h:1;
M=length(x);
t=0:k:1.5;
N=length(t);
d=1;
delta=d*(k/h^2);
U=zeros(N,M);
A=zeros(M,M); %karena adanya syarat batas yang =0 maka kolom dikurangi 2
C=zeros(M,1);
C(M,1)=delta+0.25;

%Inisialisasi nilai awal
for j=1:M
     U(1,j)=sin(pi*x(j));
end

%Inisialisasi syarat batas

for n=2:N
    U(n,1)=0;
    U(n,M)=0.025+U(n-1,M);
end


%Membuat matriks A
for i=1:M
    if i==1
        A(1,1)=1;
    elseif i==M
            A(M,M-1)=-delta;
            A(M,M)=1+delta;
        else
            A(i,i)=1+2*delta;
            A(i,i-1)=-delta;
            A(i,i+1)=-delta;
        end
end

%Menghitung SPL
for n=2:N
    U(n,:)=A\(U(n-1,:)'+C(:,:));
    figure(1)
    plot(x,U(n,:));
    drawnow;
end

