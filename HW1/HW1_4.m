syms y(x)
dydx = y - 3*x^2 + 1;

y_analytical = dsolve(diff(y, x) == dydx, y(0) == 0.5);
y_analytical_func = matlabFunction(y_analytical);

h = 0.005;
x_end = 0.1;
N = x_end / h;

x = 0:h:x_end;
y_Euler = zeros(size(x));
y_RungeKutta = zeros(size(x));

y_Euler(1) = 0.5;
y_RungeKutta(1) = 0.5;

for i = 1:N
    dydx_Euler = y_Euler(i) - 3*x(i)^2 + 1;
    y_Euler(i+1) = y_Euler(i) + h * dydx_Euler;
end


for i = 1:N
    xi = x(i);
    yi = y_RungeKutta(i);
    
    f = @(x, y) y - 3*x^2 + 1;
    
    k1 = h * f(xi, yi);
    k2 = h * f(xi + h/2, yi + k1/2);
    k3 = h * f(xi + h/2, yi + k2/2);
    k4 = h * f(xi + h, yi + k3);
    
    y_RungeKutta(i+1) = yi + (k1 + 2*k2 + 2*k3 + k4) / 6;
end

y_analytical_values = y_analytical_func(x);


figure;
plot(x, y_Euler, '-b', 'DisplayName', 'Euler method');
hold on;
plot(x, y_RungeKutta, '-r', 'DisplayName', 'Runge-Kutta method');
hold on;
plot(x, y_analytical_values, '-g', 'DisplayName', 'Analytical');
xlabel('x');
ylabel('y');
legend('Location', 'northwest');
title('HW1 (4a)');
legend('Location', 'northwest');
grid on;

figure;
plot(x, (y_Euler - y_analytical_values).^2, '-b', ...
    'DisplayName', 'Euler method error');
hold on;
plot(x, (y_RungeKutta - y_analytical_values).^2, '-r', ...
    'DisplayName', 'Runge-Kutta method error');
xlabel('x');
ylabel('Square Error');
legend('Location', 'northwest');
title('HW1 (4b)');
grid on;
