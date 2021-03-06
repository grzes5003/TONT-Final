function [ y1,y2,y3,y1c,y2c,y3c ] = zadanie1(u1,u2,u3,h)
% Wektory r1,r2,r3 to pierwsze wiersze u�yte w celu stworzenia macierzy
% Toeplitza
%{ 
r1 = zeros(1,32);
r2 = zeros(1,32);
r3 = zeros(1,32);
r1(1) = u1(1); % Ich pierwsze wyrazy musz� si� zgadza� z kolumnami
r2(1) = u2(1);
r3(1) = u3(1);
% Generujemy macierze toeplitza dla poszczeg�lnych sygna��w 
U1 = toeplitz(u1,r1);
U2 = toeplitz(u2,r2);
U3 = toeplitz(u3,r3);
%}
% Tworzymy macierz "pseudo odwrotn�" do macierzy h
P = pinv(h);
U1 = toeplitz(u1);
U2 = toeplitz(u2);
U3 = toeplitz(u3);

disp('Pierwszy sygna� nadany: ');
u1
disp('Pierwszy sygna� odebrany: ');
y1=U1*h
disp('Pierwszy sygna� odebrany - po korekcie: ');
y1c=P*y1

disp('Drugi sygna� nadany: ');
u2
disp('Drugi sygna� odebrany: ');
y2=U2*h
disp('Drugi sygna� odebrany - po korekcie: ');
y2c=P*y2

disp('Trzeci sygna� nadany: ');
u3
disp('Trzeci sygna� odebrany: ');
y3=U3*h
disp('Trzeci sygna� odebrany - po korekcie: ');
y3c=P*y3

end

