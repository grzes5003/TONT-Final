clear;

[M1,fs]=audioread('mix1.wav');
M2=audioread('mix2.wav');
% M3=wavread('mix3.wav');
N=min([length(M1), length(M2)]);
M=[M1(1:N)'; M2(1:N)'];

% Demix
C=cov(M');  % macierz kowariancji
[P,D]=eig(C);   % jej wektory w³asne - P
DM=P'*M; % dekorelacja

subplot(1,2,1), plot(M(1,:),M(2,:),'.');
subplot(1,2,2), plot(DM(1,:),DM(2,:),'g.');
CD=cov(DM');

elm=elipsa(C(1:2,1:2),25,100);
eldm=elipsa(CD(1:2,1:2),25,100);
subplot(1,2,1); hold on; plot(elm(1,:),elm(2,:),'r'); hold off
subplot(1,2,2); hold on; plot(eldm(1,:),eldm(2,:),'r'); hold off;

audiowrite(DM(1,:)',fs,'demix1.wav');
audiowrite(DM(2,:)',fs,'demix2.wav');
% wavwrite(DM(3,:)',fs,'demix3.wav');
