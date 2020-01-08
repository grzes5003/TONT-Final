clear all;
a = double(0.1);
b = double(-100);
c = double(0.1);

a1 = single(0.1);
b1 = single(-100);
c1 = single(0.1);

b1_2 = single(-101);

x1 = (-b+sqrt(b^2-4*a*c))/(2*a);
x1_1 = (-b1+sqrt(b1^2-4*a1*c1))/(2*a1);

x2 = (-b-sqrt(b^2-4*a*c))/(2*a);
x2_1 = (-b1-sqrt(b1^2-4*a1*c1))/(2*a1);
x2_2 = (-b1_2-sqrt(b1_2^2-4*a1*c1))/(2*a1);


x3 = (-2*c)/(b+sqrt(b^2-4*a*c));
x4 = (-2*c)/(b-sqrt(b^2-4*a*c));

d = (x2_1-1.01*x2_1)/x2_1
e = (b1-1.01*b1)/b1

condx1=abs(((x2-1.01*x2)/x2)/((b-1.01*b)/b))

condx2=abs(((x2_1-1.01*x2_1)/x2_1)/((b1-1.01*b1)/b1))