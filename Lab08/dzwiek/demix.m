clear;

[M1,fs]=wavread('mix1.wav');
M2=wavread('mix2.wav');
M3=wavread('mix3.wav');
N=min([length(M1), length(M2), length(M3)]);
M=[M1(1:N)'; M2(1:N)'; M3(1:N)'];

% blind demix based on covariance
C=cov(M');
[P,D]=eig(C);
DM=P'*M; % decorrelation by KLT
subplot(1,2,1), plot(M(1,:),M(2,:),'.');
subplot(1,2,2), plot(DM(1,:),DM(2,:),'g.');
%DM=sqrt(inv(D))*DM; % normalization to unit variance
CD=cov(DM');

if 1
elm=elipsa(C(1:2,1:2),25,100);
eldm=elipsa(CD(1:2,1:2),25,100);
subplot(1,2,1); hold on; plot(elm(1,:),elm(2,:),'r'); hold off
subplot(1,2,2); hold on; plot(eldm(1,:),eldm(2,:),'r'); hold off;
end

wavwrite(DM(1,:)',fs,'demix1.wav');
wavwrite(DM(2,:)',fs,'demix2.wav');
wavwrite(DM(3,:)',fs,'demix3.wav');
