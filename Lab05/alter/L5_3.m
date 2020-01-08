% L5_3: rózniczkowanie zasumionego sinusa

clear all; close all;

dx = (2*pi)/100;
x = 0 : dx : 4*pi;
N = length(x);
y = sin(x);  yr = cos(x);

if(0) 
  d1 = [ -1 1];               d1=fliplr(d1);   N1=length(d1);
  d2 = [ -1 0 1];             d2=fliplr(d2);   N2=length(d2);
  d3 = 1/12*[1 -8 0 8 -1];    d3=fliplr(d3);   N3=length(d3);

  SNR = [240, 80, 50, 30, 20 ];
  for k = 1 : length(SNR)
      k, SNR(k),
      yn = awgn(y,SNR(k));

      yd1 = conv(yn, d1 ) / dx;
      yd2 = conv(yn, d2 ) / (2*dx);
      yd3 = conv(yn, d3 ) / dx;
    
      figure
      plot( x,yr,'k',x(1:N-1)+pi/100,yd1(N1:end-N1+1),'r',x(2:N-1),yd2(N2:end-N2+1),'g',...
      x(3:N-2),yd3(N3:end-N3+1),'b'); pause
  end
end

% Filtr ró¿niczkuj¹cy z DSP
if(0)
  MM = [10,25,50];
  for k = 1 : length(MM)
      yn = awgn(y,20);                               % zaszumienie
      M=MM(k); m=-M:1:M; h = cos(pi*m)./m; h(M+1)=0;  % odp. impulsowa filtru ró¿nicz.
      w = blackman(2*M+1)'; h = h .* w;               % opcjonalne wyg³adzenie brzegów
      yd4 = conv(yn, h)/dx;                               % operacja splotu (filtracji)

      figure
      plot( x,yr,'k',x(M+1:N-M),yd4(2*M+1:end-2*M),'r'); grid; pause
  end
end