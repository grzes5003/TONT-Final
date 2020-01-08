clc;
clear all;
load('../h.mat'); 
h=h';% Aby pomno¿yæ macierze, macierz h musi byæ kolumnowa 
% Utworzenie trzech sygna³ów
u1 = zeros(32,1);
u1(1) = 1;
u2 = zeros (32,1);
u2(1:1:7) = [0,1,1,0.5,0.5,-1,-1];
u3 = zeros(32,1);
for i=0:31 
    u3(i+1)= sin(2*pi*2*i/32) + sin(2*pi*6*i/32);
end
%{ 
u3_wanted = zeros(32,1);
for i=0:31 
    u3_wanted(i+1)= sin(2*pi*2*i/32);
end
%}

% Wektory r1,r2,r3 to pierwsze wiersze u¿yte w celu stworzenia macierzy Toeplitza
r1 = zeros(1,32);
r2 = zeros(1,32);
r3 = zeros(1,32);
r1(1) = u1(1); % Ich pierwsze wyrazy musz± siê zgadzaæ z kolumnami
r2(1) = u2(1);
r3(1) = u3(1);
% Generujemy macierze toeplitza dla poszczególnych sygna³ów 
U1 = toeplitz(u1,r1);
U2 = toeplitz(u2,r2);
U3 = toeplitz(u3,r3);

%disp('Pierwszy sygna³ nadany: ');
u1;
%disp('Pierwszy sygna³ odebrany: ');
y1=U1*h;
%-----------------------------ZADANIE 1------------------------------------
if (y1 == h)
    disp('Otrzymane y jest takie samo jak h');
else
    disp('Otrzymane y jest ró¿ne od h');
end
%-----------------------------ZADANIE 2------------------------------------
%disp('Drugi sygna³ nadany: ');
u2;
%disp('Drugi sygna³ odebrany: ');
y2=U2*h;
P=pinv(h);
P=toeplitz(P);
y2c=P*y2;

figure(1);
subplot(2,1,1);
hold on;
stem(u2, 'filled', 'b');
plot(y2,'r');
title('Sygna³ nadany i odebrany');
subplot(2,1,2);
hold on;
plot(y2c,'r');
title('Sygna³ odebrany - skorygowany');
%-----------------------------ZADANIE 3------------------------------------
%disp('Trzeci sygna³ nadany: ');
u3;
%disp('Trzeci sygna³ odebrany: ');
y3=U3*h;

figure(2);
hold on;
freqz(u3);

figure(3);
subplot(2,1,1);
hold on;
plot(u3, 'b');
subplot(2,1,2);
hold on;
plot(y3,'r');
%
