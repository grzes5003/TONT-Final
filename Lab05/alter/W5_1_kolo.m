
clear all; close all;

Methods={
'trapezy1',
'simpson2',
'simpson3',
'bool4'
};
Ns=2:5;
W={
[1 1]/2,
[1 4 1]/3,
[1 3 3 1]*3/8,
[7 32 12 32 7]*2/45
};
for i=1:length(Ns);
  method=Methods{i}
  N=Ns(i);
  h=1/(N-1);
  x=0:h:1;
  y=sqrt(1-x.^2);
  kk=sum(W{i}.*y)*h*4
end