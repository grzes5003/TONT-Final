clc;
clear all;
d=ones(1,1024);
for i=10:1024
    d(i)=xor(d(i-4),d(i-9));
end
x = xcorr(d, 'unbiased');
plot(x);
% Sekwencja posiada 511 bit�w d�ugo�ci, powtarza si� 2 razy, 2 ostatnie
% bity nale�� ju� do 3ciej sekwencji bit�w. 