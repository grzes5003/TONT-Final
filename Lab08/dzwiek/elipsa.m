function x = elipsa(S,r,n)
% Zwraca n punktow elipsy: x'*inv(S)*x=r
% dla S (2x2) symetrycznej i +okreslonej
[P,D] = eig(S);
P = P*sqrt(r*D);
t = linspace(0,2*pi,n);
x = P* [cos(t); sin(t)];
end

