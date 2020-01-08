clear all;
clc;



opts = delimitedTextImportOptions("NumVariables", 5);

opts.DataLines = [1, Inf];
opts.Delimiter = ";";

opts.VariableNames = ["time", "szerokosc", "dlugosc", "wysokosc", "dokladnosc"];
opts.VariableTypes = ["double", "double", "double", "double", "double"];

opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

pozycje = readtable("pozycje.txt", opts);

pozycje = table2array(pozycje);
clear opts


R = 6371*1000;
% Przechodzimy na radiany
for i=1:126
    pozycje(i,2) = pozycje(i,2) * (pi/180);
    pozycje(i,3) = pozycje(i,3) * (pi/180);
end

% Zamiana na jednostki kartezjañskie ze sferycznych 
kart = zeros(3,126);
for i=1:126
    kart(1,i) = R * cos(pozycje(i,2)) * cos(pozycje(i,3));
    kart(2,i) = R * cos(pozycje(i,2)) * sin(pozycje(i,3));
    kart(3,i) = R * sin(pozycje(i,2));
end
% Odkomentuj w celu zobaczenia czasu w "czytelnym" systemie
%{
for i=1:126
    pozycje(i,1) = pozycje(i,1)/1000;
end
d = datetime(pozycje(3, 1), 'ConvertFrom', 'posixtime')
%} 
v = zeros(1, 125);
% Wyznaczenie prêdkoœci chwilowej (bez uwzglêdniania wysokoœci)
for i=1:125
    % Prêdkoœæ chwilowa (w m/s)
    v(1,i) = distance(pozycje(i,2), pozycje(i+1,2), pozycje(i,3), pozycje(i+1,3))/((pozycje(i+1,1)-pozycje(i,1))/1000);
    % W kilometrach na godzinê
    % v(1,i) = v(1,i)*(3.6);
end
v_h = zeros(1, 125);

% Wyznaczenie prêdkoœci chwilowej (z uwzglêdnieniem wysokoœci)
for i=1:125
    % Prêdkoœæ chwilowa (w m/s)
    v_h(1,i) = sqrt ((kart(1,i+1)-kart(1,i))^2+(kart(2,i+1)-kart(2,i))^2+(kart(3,i+1)-kart(3,i))^2)/((pozycje(i+1,1)-pozycje(i,1))/1000);
    % W kilometrach na godzinê
    %v(1,i) = v(1,i)*(3.6);
end

a = zeros(1, 124);
% Wyznaczenie przyspieszenia chwilowego (w m/s^2)
for i=1:124
    a(1,i) = (v(i+1)-v(i))/(pozycje(i+1,1)-pozycje(i,1));
end
dist = 0;
% Wyznaczenie dystansu ca³kowitego (w m)
for i=1:125
    dist = dist + distance(pozycje(i,2), pozycje(i+1,2), pozycje(i,3), pozycje(i+1,3));
end
disp(['Prêdkoœæ œrednia wynosi: ', num2str(mean(v)), ' [m/s]']);
disp(['Przyspieszenie œrednie wynosi: ', num2str(mean(a)), ' [m/s^2]']);
disp(['Przebyta droga wynosi: ', num2str(dist), ' [m]']);


function [ d ] = distance( fi1, fi2, lambda1, lambda2 )
    R = 6371*1000; % Promie? Ziemi w metrach
    a = sin((fi2-fi1)/2)^2+cos(fi1)*cos(fi2)*sin((lambda2-lambda1)/2)^2;
    c = 2*atan2(sqrt(a),sqrt(1-a));
    d = R*c;
end