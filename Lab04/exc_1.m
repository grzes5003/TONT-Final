clear all;
% input values
xy = [ 5 6 8 11; 1 2 7 15 ];

% lagrange method
y1 = inter_L(xy);
y2 = inter_N(xy);

figure(1)
plot(y1(1,:),y1(2,:))
hold on
plot(y2(1,:),y2(2,:))
scatter(xy(1,:),xy(2,:))
legend({'Langrang', 'Newton', 'Input'})
