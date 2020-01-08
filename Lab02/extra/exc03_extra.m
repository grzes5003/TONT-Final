clc;
clear all;
d=ones(1,1024);
for i=10:1024
    d(i)=xor(d(i-4),d(i-9));
end
x = xcorr(d, 'unbiased');
plot(x);
% Sekwencja posiada 511 bitów d³ugoœci, powtarza siê 2 razy, 2 ostatnie
% bity nale¿¹ ju¿ do 3ciej sekwencji bitów. 