clear all;
load('../h.mat'); 
h=h';% Aby pomno¿y? macierze musz? si? zgadza? ich wymiary 
u1 = zeros(32,1);
u1(1) = 1;
u1(1) = 1;
u2 = zeros (32,1);
u2(1:1:7) = [0,1,1,0.5,0.5,-1,-1];
u3 = zeros(32,1);
for i=1:32 
    u3(i)=sin(2*pi*2*i/32) + sin(2*pi*6*i/32);
end
zadanie1(u1,u2,u3,h);
disp(y3c);