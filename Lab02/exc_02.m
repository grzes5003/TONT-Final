clear all;
load('h.mat');
L=32;


x = zeros(L,1);
for i = 0:L-1
    x(i+1) = sin(4*pi*i/L) + sin(12*pi*i/L);
end

for n = 0:L-1
    for m = 0:L-1
        F(n+1,m+1)=(1/sqrt(L))*cos(2*(pi/L)*n*m)-1i*(1/sqrt(L))*sin(2*(pi/L)*n*m);
    end
end

X = F*x;
figure(1)
X_show=20*log(abs(X));
plot(X_show);
title('Widmo gêstoœci mocy');

x1=inv(F)*X;
x2=inv(F.')*X;

% -------------------------------
for n=0:62
    for m=0:62
        Fy(n+1,m+1)=(1/sqrt(L))*cos(2*(pi/L)*n*m)-i*(1/sqrt(L))*sin(2*(pi/L)*n*m);
    end
end

% Macierz F transformaty DFT - drugi wzór %
for n=0:62
    for m=0:62
        Fy_e(n+1,m+1)=(1/sqrt(L))*exp(-i*2*(pi/L)*n*m);
    end
end

y=conv(h,x);

Y=Fy*y;
y1=inv(Fy)*Y;
y2=inv(Fy.')*Y;

% --------------------------------
rs = randn(32,1);
RS=F*rs;
rs1=inv(F)*RS;
rs2=inv(F.')*RS;