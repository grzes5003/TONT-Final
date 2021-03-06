function xy_cont = inter_linear(xy)
%INTER_LINEAR Summary of this function goes here
%   Detailed explanation goes here
    res = 10;

    N = length(xy);
    l = xy(1,1):1/res:xy(1,end);
    y = zeros(1,length(l));
    
    for i = 1:N-1
        for k = 1:res
            y((i-1)*res+k) = xy(2,i) + ( l((i-1)*res+k) - xy(1,i) ) * ( xy(2,i+1) - xy(2,i) / ( xy(1,i+1) - xy(1,i)) );
        end
    end
    xy_cont = [ l ; y ];
end

