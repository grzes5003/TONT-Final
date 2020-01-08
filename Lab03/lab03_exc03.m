clear all

M = 10;
timer_x1 = zeros(1,M);
timer_x2 = zeros(1,M);

for i = 1:M
    [m_Ra, m_Rb] = matrixgenerator(100);
    t1 = tic; % TIC, pair 1
    x1 = lab03_exc03_seidel(m_Ra,m_Rb);
    timer_x1(i) = toc(t1); % TOC, pair 1
    
    t2 = tic; % TIC, pair 2
    x2 = lab03_exc02_LU(m_Ra,m_Rb);
    timer_x2(i) = toc(t2); % TOC, pair 2
end

%% plotting
figure(1)
subplot(2,1,1)
scatter(1:M, timer_x1)
title("Timers")
grid()
hold on
subplot(2,1,1)
scatter(1:M, timer_x2)
legend('seidel','LU')
subplot(2,1,2)
plot(1:M,abs(timer_x2-timer_x1));
title("Abs diffrence")
hold off
%%

function [m_Ra, m_Rb] = matrixgenerator(N)
    m_Ra = randi([-10,10], N, N);
    m_Rb = randi([-10,10], N, 1);
end