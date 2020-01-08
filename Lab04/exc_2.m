clear all;

xy = [ -5:1:5 ; arrayfun( @(z) 1/(1+z^2), -5:1:5 )];

res = 10;
x = (-5:1/res:5);
y = 1./(1+x.^2);

y1 = inter_L(xy);
y2 = inter_N(xy);
y3 = inter_linear(xy);
y4 = inter_cubic_spline(xy);

%%

figure(2)
scatter(xy(1,:),xy(2,:))
hold on
plot(x,y)
plot(y1(1,:),y1(2,:))
plot(y2(1,:),y2(2,:))
plot(y3(1,:),y3(2,:))
plot(y4(1,:),y4(2,:))
legend({'input', 'Lag', 'Newton', 'linear', 'cubic'})

%%

Diff(:,1) = abs (y1(2,:) - y);
maxDiff(1) = max(Diff(:,1));

Diff(:,2) = abs (y2(2,:) - y);
maxDiff(2) = max(Diff(:,2));

Diff(:,3) = abs (y3(2,:) - y);
maxDiff(3) = max(Diff(:,3));

Diff(:,4) = abs (y4(2,:) - y);
maxDiff(4) = max(Diff(:,4));

maxDiff % 'Lag' 'Newton' 'linear' 'cubic'