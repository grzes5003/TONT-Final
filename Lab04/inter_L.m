function xy_cont = inter_L(xy)
%INTER_LAGRANGE Summary of this function goes here
%   Detailed explanation goes here
    % change in the future 
    N = length(xy);
    sum = 0; % tmp var
    
    l = xy(1,1):0.1:xy(1,end);
    y = zeros(1,length(l));
    
    
    for i = 1:length(l)
        for k = 1:N
            % for every k count Lk and add to sum
            sum = sum + ( xy(2,k)*Lk(l(i),xy,k) );
        end
        y(i) = sum;
        sum = 0;
    end
    xy_cont = [ l ; y];
end

function y = Lk(x, xk, k)
    N = length(xk);
    
    mult1 = 1;
    mult2 = 1;
    for j = 1:N
        if j == k
            continue
        end
        mult1 = mult1*( x - xk(1,j) );
        mult2 = mult2*( xk(1,k) - xk(1,j) );
    end
    y = mult1/mult2;
end