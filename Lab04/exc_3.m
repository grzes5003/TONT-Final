clear all;

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

out1 = inter_zero(in, Xi, Yi, N);
imwrite(out1, 'checkBoard_out1.png', 'png');
