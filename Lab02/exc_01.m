clear all;
load("h.mat");
h = h';
L = 32;

u1 = zeros(L,1);
u1(1) = 1;

u2 = zeros(L,1);
u2(1:1:7) = [0,1,1,0.5,0.5,-1,-1];

u3 = zeros(L,1);
for i = 0:L-1
    u3(i+1) = sin(4*pi*i/L) + sin(12*pi*i/L);
end

U1 = toeplitz(u1);
U2 = toeplitz(u2);
U3 = toeplitz(u3);

% wyniki
y1 = U1*h;
y2 = U2*h;
y3 = U3*h;

% yn  = cell(y1,y2,y3);
% Un  = cell(U1,U2,U3);
% 
% for i=1:3
%     if yn(i) == Un(i)
%         disp("TRUE")
%     else
%         disp("FALSE")
%     end
% end

P = pinv(h);
P = toeplitz(P);

u2_dec = P*y2;

subplot(2,1,1);
hold on;
stem(u2, 'filled', 'b');
plot(y2,'r');
title('sent and receved');
subplot(2,1,2);
hold on;
plot(u2_dec,'r');
title('receved skorygowany');


figure(2);

subplot(2,1,1)
hold on;
freqz(u3);

subplot(2,1,2)
hold on;
freqz(y3);

figure(3);

subplot(2,1,1);
hold on;
plot(u3, 'b');

subplot(2,1,2)
hold on;
plot(y3, 'r')
