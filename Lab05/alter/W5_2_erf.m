
clear all; close all;

c_erf = erf(3/sqrt(2))

f=inline('1/sqrt(2*pi)*exp(-x.^2/2)');

x=-3:0.6:3; w=ones(size(x)); w(2:2:end-1)=2;
c_trapez=0.6/2*w*f(x)',

x=-3:0.6:3; e=length(x); w=ones(1,e);
w(3:2:e-2)=2; w(2:2:e-1)=4; c_simpson13=0.6/3*w*f(x)',

x=[-sqrt(3/5) 0 sqrt(3/5)]; w=1/9*[5 8 5];
c_gauss3=3*w*f(3*x)',

x=[-sqrt(3/5) 0 sqrt(3/5)]; w=1/9*[5 8 5];
c_gauss33=w*f(x-2)'+w*f(x)'+w*f(x+2)',

[c_quad,i]=quad(f,-3,3),

[c_quadl,i]=quadl(f,-3,3),