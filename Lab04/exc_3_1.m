clear all;

% Kod z zadania  
t = pi / 6;
rot_mtx = [cos(t), -sin(t); sin(t), cos(t)]; 
T=[50; -20];

in = imread( 'checkerBoard_20_200.png' );
in = double( rgb2gray( in ) );

N = size( in, 1 );
[X,Y] = meshgrid( 1:N );

XY = [ reshape(X, 1, N*N); reshape(Y, 1, N*N) ]; 
XYr = rot_mtx * (XY + repmat(T, 1, N*N));

Xi = reshape(XYr(1,:), N, N);
Yi = reshape(XYr(2,:), N, N);

% Rozwiązanie inteligentne - funkcja Matlab
out1 = interp2(X, Y, in, Xi, Yi, 'nearest'); % Interpolacja zerowego stopnia 
out2 = interp2(X, Y, in, Xi, Yi, 'linear'); % Interpolacja liniowa (biliniowa)

% Rozwiązanie żmudne - ręczne 
% Interpolacja zerowego stopnia (najbliższy sąsiad)
for i=1:200 % Rozmiary obrazka 
    for j=1:200 % Rozmiary obrazka
        if (round(Xi(i,j))>=1 & round(Yi(i,j))>=1 & round(Xi(i,j))<=200 & round(Yi(i,j))<=200) % Rozmiary obrazka
            out3(i,j) = in( round(Xi(i,j)), round(Yi(i,j)) ); % Przypisz najbliższe wartości
        else
            out3(i,j)=255; % Pozostaw kolor biały tam, gdzie poza zakresem
        end
    end
end

% Interpolacja liniowa (biliniowa)
for i=1:200
    for j=1:200
        if (Xi(i,j)>=1 & Yi(i,j)>=1 & Xi(i,j)<=200 & Yi(i,j)<=200)
            Q11(i,j)= ( in(floor(Xi(i,j)), floor(Yi(i,j)))) * (ceil(Xi(i,j))-Xi(i,j))*(ceil(Yi(i,j))-Yi(i,j));
            Q12(i,j)=(in(floor(Xi(i,j)),ceil(Yi(i,j))))*(ceil(Xi(i,j))-Xi(i,j))*(Yi(i,j)-floor(Yi(i,j)));
            Q21(i,j)=(in(ceil(Xi(i,j)),floor(Yi(i,j))))*(Xi(i,j)-floor(Xi(i,j)))*(ceil(Yi(i,j))-Yi(i,j));
            Q22(i,j)=(in(ceil(Xi(i,j)),ceil(Yi(i,j))))*(Xi(i,j)-floor(Xi(i,j)))*(Yi(i,j)-floor(Yi(i,j)));
            C(i,j)=(ceil(Xi(i,j))-floor(Xi(i,j)))*(ceil(Yi(i,j))-floor(Yi(i,j)));
            out4(i,j)=(Q11(i,j)+Q12(i,j)+Q21(i,j)+Q22(i,j))/C(i,j);
        else
            out4(i,j)=255;
        end
    end
end

% Zapisanie obrazków do plików
imwrite(out1, 'nearest.png', 'png');
imwrite(out2, 'linear.png', 'png');
imwrite(out3, 'nearest_manual.png', 'png');
imwrite(out4, 'linear_manual.png', 'png');