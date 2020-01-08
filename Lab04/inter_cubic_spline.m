function xy_cont = inter_cubic_spline(xy)
%INTER_CUBIC_SPLINE Summary of this function goes here
%   Detailed explanation goes here
    res = 10;
    l = xy(1,1):1/res:xy(1,end);

    xk = xy(1,:)';
    yk = 1./(1+xk.^2);
    % funkcje sklejane - III stopieñ
    cs = spline( xk', [0 yk' 0] );
    y3 = ppval( cs, l );
    
    xy_cont = [ l ; y3 ];
end

