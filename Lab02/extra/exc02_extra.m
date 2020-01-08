clc;
clear all;
load('../h.mat');
N=32;

% -------------------------ANALIZA SYGNA£U X----------------------------- %
% Sygna³ do transformaty %
x = zeros(32,1);
for i=0:31 
    x(i+1)= sin(2*pi*2*i/32) + sin(2*pi*6*i/32);
end
% Sygna³ z exp %
x_e = zeros(32,1);
for i=0:31 
    x_e(i+1)= exp(-i*2*pi*2*i/32) + exp(-i*2*pi*6*i/32);
end

% Macierz F transformaty DFT %
for n=0:31
    for m=0:31
        F(n+1,m+1)=(1/sqrt(N))*cos(2*(pi/N)*n*m)-i*(1/sqrt(N))*sin(2*(pi/N)*n*m);
    end
end

% Macierz F transformaty DFT - drugi wzór %
for n=0:31
    for m=0:31
        F_e(n+1,m+1)=(1/sqrt(N))*exp(-i*2*(pi/N)*n*m);
    end
end
 
% --------------OBLICZENIA NA SINUSIE-------------- %
X=F*x;
figure(1)
X_show=20*log(abs(X));
plot(X_show);
title('Widmo gêstoœci mocy');

x1=inv(F)*X;
x2=inv(F.')*X;
if (x1==x2)
    disp('Macierze x1 i x2 s¹ takie same.');
else
    disp('Macierze x1 i x2 nie s¹ takie same.');
end
% ----------------OBLICZENIA NA EXP---------------- %
X_e=F*x_e;
figure(2)
X_eshow=20*log(abs(X_e));
plot(X_eshow);
title('Widmo gêstoœci mocy');

x_e1=inv(F)*X;
x_e2=inv(F.')*X;
if (x_e1==x_e2)
    disp('Macierze x_e1 i x_e2 s¹ takie same.');
else
    disp('Macierze x_e1 i x_e2 nie s¹ takie same.');
end

% -------------------------ANALIZA SYGNA£U Y----------------------------- %
% Macierz F transformaty DFT %
for n=0:62
    for m=0:62
        Fy(n+1,m+1)=(1/sqrt(N))*cos(2*(pi/N)*n*m)-i*(1/sqrt(N))*sin(2*(pi/N)*n*m);
    end
end

% Macierz F transformaty DFT - drugi wzór %
for n=0:62
    for m=0:62
        Fy_e(n+1,m+1)=(1/sqrt(N))*exp(-i*2*(pi/N)*n*m);
    end
end

y=conv(h,x);

Y=Fy*y;
y1=inv(Fy)*Y;
y2=inv(Fy.')*Y;
if (y1==y2)
    disp('Macierze y1 i y2 s¹ takie same');
else
    disp('Macierze y1 i y2 nie s¹ takie same');
end

% -----------------------ANALIZA SYGNA£U RAND---------------------------- %
rs = randn(32,1);
RS=F*rs;
rs1=inv(F)*RS;
rs2=inv(F.')*RS;