clear all
close all
X=csvread('../LoudnessWarNumbers.csv');

rok=X(:,1);
avg=X(:,2);
min=X(:,3);
max=X(:,4);
N=length(rok);

% dla minimum
x=sum(rok)/N;
y=sum(min)/N;
xy=sum(rok.*min)/N;
x_kw=sum(rok.*rok)/N;
a=(xy-x*y)/(x_kw-x^2);
b=y-a*x;

figure(1);
title('minimum');
hold on
plot(rok,min,'o')
plot(rok,a*rok+b)

% dla sredniej
x=sum(rok)/N;
y=sum(avg)/N;
xy=sum(rok.*avg)/N;
x_kw=sum(rok.*rok)/N;
a=(xy-x*y)/(x_kw-x^2);
b=y-a*x;

figure(2);
title('srednia');
hold on
plot(rok,avg,'o')
plot(rok,a*rok+b)

% dla maksimum
x=sum(rok)/N;
y=sum(max)/N;
xy=sum(rok.*max)/N;
x_kw=sum(rok.*rok)/N;
a=(xy-x*y)/(x_kw-x^2);
b=y-a*x;

figure(3);
title('maksimum');
hold on
plot(rok,max,'o')
plot(rok,a*rok+b)