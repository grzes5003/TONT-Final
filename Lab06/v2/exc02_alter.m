clear all
close all
load('sndb_prbs.mat')
% ---------------------

% dla M=50
M=50;                           % d³ugoœæ licznika
L=length(u);                    % maksymalna d³ugoœæ sygna³u do analizy
y=y+0.1*randn(size(y)) ;        % dodawanie szumu

U=[];                           % Metoda parametryczna model FIR o d³ugoœci M
for i=1:M
    U=[U,u(M-i+1:L-i+1)];
end
Y=y(M:L);
b=U\Y;
Hls=freqz(b(1:M),1,round(L/2));
ids=1:L/2;
Freqs=(ids-1)*fs/L;
%y=y(M:round(L/100));
%u=u(M:round(L/100));
%H=(fft(xcorr(y,u)))./fft(xcorr(u,u)) % ma byc kolumna

figure(1);
plot(Freqs',20*log10(abs(Hls(1:end-1))),'r-');

%{
% dla M=100
M=100;                          % d³ugoœæ licznika
L=length(u);                    % maksymalna d³ugoœæ sygna³u do analizy
y=y+0.1*randn(size(y)) ;        % dodawanie szumu

U=[];                           % Metoda parametryczna model FIR o d³ugoœci M
for i=1:M
    U=[U,u(M-i+1:L-i+1)];
end
Y=y(M:L);
b=U\Y;
Hls=freqz(b(1:M),1,round(L/2));
ids=1:L/2;
Freqs=(ids-1)*fs/L;

figure(2);
plot(Freqs',20*log10(abs(Hls(1:end-1))),'r-');

% dla M=200
M=200;                          % d³ugoœæ licznika
L=length(u);                    % maksymalna d³ugoœæ sygna³u do analizy
y=y+0.1*randn(size(y)) ;        % dodawanie szumu

U=[];                           % Metoda parametryczna model FIR o d³ugoœci M
for i=1:M
    U=[U,u(M-i+1:L-i+1)];
end
Y=y(M:L);
b=U\Y;
Hls=freqz(b(1:M),1,round(L/2));
ids=1:L/2;
Freqs=(ids-1)*fs/L;

figure(3);
plot(Freqs',20*log10(abs(Hls(1:end-1))),'r-');


% dla M=1000
M=1000;                         % d³ugoœæ licznika
L=length(u);                    % maksymalna d³ugoœæ sygna³u do analizy
y=y+0.1*randn(size(y)) ;        % dodawanie szumu

U=[];                           % Metoda parametryczna model FIR o d³ugoœci M
for i=1:M
    U=[U,u(M-i+1:L-i+1)];
end
Y=y(M:L);
b=U\Y;
Hls=freqz(b(1:M),1,round(L/2));
ids=1:L/2;
Freqs=(ids-1)*fs/L;
plot(Freqs',20*log10(abs(Hls(1:end-1))),'r-');
%}