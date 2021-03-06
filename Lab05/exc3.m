clear all

central = diff( [], @(x, y, z, a, b, c) (z-x)/(c-a), 0:(2*pi)/100:2*pi);
wstecz  = diff( [], @(x, y, z, a, b, c) (y-x)/(b-a), 0:(2*pi)/100:2*pi);
target  = arrayfun(@(x) cos(x), 0:(2*pi)/100:2*pi);

% with noise
noise = arrayfun( @(x) awgn(sin(x), 50), 0:(2*pi)/100:2*pi);
central_noise = diff_noise( [], @(x, y, z, a, b, c) (z-x)/(c-a), [ 0:(2*pi)/100:2*pi; noise ]);
wstecz_noise  = diff_noise( [], @(x, y, z, a, b, c) (y-x)/(b-a), [ 0:(2*pi)/100:2*pi; noise ]);

figure(1)
plot( 0:(2*pi)/100:(2*pi-4*pi/100), central )
hold on
plot( 0:(2*pi)/100:2*pi, target )
legend({'cental', 'target'}, 'Location','southwest')

figure(2)
plot( 0:(2*pi)/100:(2*pi-4*pi/100), central_noise )
hold on
plot( 0:(2*pi)/100:2*pi, noise )
legend({'cental with noise', 'noise'}, 'Location','southwest')

function out = diff(out, funct, in)
    if size(in, 2) == 2
        return
    end
    out = [ out , funct( sin(in(1,1)), sin(in(1,2)), sin(in(1,3)), in(1,1), in(1,2), in(1,3) ), diff(out, funct, in(1, 2:end)) ];
end

function out = diff_noise(out, funct, in)
    if size(in, 2) == 2
        return
    end
    out = [ out, funct( in(2,1), in(2,2), in(2,3), in(1,1), in(1,2), in(1,3) ), diff(out, funct, in(:, 2:end)) ];
end




