function xy_cont = inter_N(xy)
%INTER_N Summary of this function goes here
%   Detailed explanation goes here
    N = length(xy);    

    % d parameter
    d(:,1) = xy(2,:);
    for j=2:N
        for k=j:N
            d(k,j)=( d(k,j-1)-d(k-1,j-1) )/( xy(1,k)-xy(1,k-j+1) );
        end
    end
    
    l = xy(1,1):0.1:xy(1,end);
    y = zeros(1,length(l));
    
    % y(1) = d(1,1);
    
    sum = 0; % tmp var
    mult = 1;
    for i = 1:length(l)
        for k = 1:N-1
            for j = 1:k
                mult = mult * ( l(1,i) - xy(1,j) );
            end
            mult = mult * d(k+1,k+1);
            sum = sum + mult;
            mult = 1;
        end
        y(i) = sum + d(1,1);
        sum = 0;
    end
    xy_cont = [ l ; y ];
end

