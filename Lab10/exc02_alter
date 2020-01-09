x(:,1) = [0;0;0];
[a,b] = ode45(@rlc, [0:dt:24], x(:,1));
figure(1);
hold on
plot(a, b(:,1), 'r');
plot(a, b(:,2), 'g');
legend('i1', 'i2')
title('wykres natężeń')
figure(2);
hold on
plot(a, b(:,3));
legend('uc')
title('wykres napięcia')
