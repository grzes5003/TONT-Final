clear all;
clc; 

fir = firls(4, [0 0.5 0.7 1], [0 0.5*pi 0 0], 'differentiator');

x = 0:(2*pi)/100:2*pi;
x1 = zeros(1,100);
x2 = zeros(1,99);
for i=1:100
    x1(i) = x(i);
end
for i=1:99
    x2(i) = x(i);
end

y1 = sin(x);
y1 = awgn(y1, 60);
y2 = cos(x);
P = zeros(1,101);
wstecz = zeros(1,100);
centralny = zeros(1,99);
for i=1:100
    wstecz(i) = (y1(i+1)-y1(i))/(x(i+1)-x(i));
end
for i=2:100
    centralny(i-1) = (y1(i+1)-y1(i-1))/(x(i+1)-x(i-1));
end
filtr = filter(fir, 1, y1);

%{
M = 10;
m = -M:1:M;
h = cos(pi*m)./m;
h(M+1) = 0;
% w = blackman(2*M+1)'; h = h.*w; % Opcjonalne wyg³adzanie
y2e = conv (y1,h);

for i=2*M+1:1:length(y2e)-2*M;
    wstecz2(i) = (y2e(i+1)-y2e(i))/(x(i+1-2*M)-x(i-2*M));
end
%}

hold all;
plot(x,y2,'r');
plot(x1,wstecz,'b');
plot(x2,centralny,'g');
plot(x,filtr,'k');