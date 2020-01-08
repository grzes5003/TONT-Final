% L5_1: Ró¿niczkowanie sygna³u GPS + FIR 1) 2)

clear all; close all;

load('pozycje.txt');
t   = pozycje(:,1)/1000;      % ms --> s
lat = pi*pozycje(:,2)/180;    % szerokoœæ geo: deg --> rad
lon = pi*pozycje(:,3)/180;    % d³ugoœæ geo
hei = pozycje(:,4);           % wysokoœæ

t = t - 1380000000000;
t = t - t(1);

dxyz = calc_dxyz( lat, lon, hei );

v =  dxyz   ./  (t(2:end)-t(1:end-1));      % lub diff(t)
a = diff(v) ./  ((t(3:end)-t(1:end-2))/2);  
d = cumsum( dxyz);
disp('Czas podró¿y w [min]      = '); t(end)/60,
disp('Przebyty dystans w [km]   = '); d(end)/1000,
disp('Œrednia prêdkoœæ w [km/h] = '); 3600*mean(v)/1000, pause

figure
subplot(411); plot(t/60); title('t[n] [min]');
subplot(412); plot((t(1:end-1)+t(2:end))/2,3600*v/1000); title('v(t) [km/h]');
subplot(413); plot(t(2:end-1),a); title('a(t) [m/s^2]');
subplot(414); plot(t,[ 0; d/1000] ); title('d(t) [km]'); xlabel('t [s]')
pause

r = 1/12*[-1 8 0 -8 1] / mean(diff(t));     Nr = length(r);
%r =       [ 1 0 -1]   / (2*mean(diff(t))); Nr = length(r);

v2 = conv( d, r );   v2=v2(Nr:end-Nr+1);
a2 = conv( v2, r );  a2=a2(Nr:end-Nr+1);
figure
subplot(211); plot(v2); title('v2(t) [m/s]');
subplot(212); plot(a2); title('a2(t) [m/s^2]');

% L5_4: ca³kowanie prêdkoœci
v=v(:); L=length(v);
w = ones(L,1); w(2:2:L-1)=4; w(3:2:L-2)=2;
dd = (1/3) * cumsum( v.*w.*diff(t) );
figure
subplot(111); plot(t,[ 0; d/1000],'r', t,[ 0; dd/1000],'b'); title('d(t) [km]'); xlabel('t [s]')
pause
