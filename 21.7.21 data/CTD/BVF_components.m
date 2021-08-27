% Bin depths, pressures, conservative temperatures, and absolute salinities.
depth_21_7_binned = (1 : 50)';
abs_sal_21_7_binned = zeros(50, 1);
cons_temp_21_7_binned = zeros(50, 1);
press_21_7_binned = zeros(50, 1);
for j = 1 : 50
    divisor = 0;
    for i = 1 : size(abs_sal_21_7, 1)
        if ((j - 0.5) < depth_21_7(i)) && (depth_21_7(i) <= (j + 0.5))
            abs_sal_21_7_binned(j) = abs_sal_21_7_binned(j) + abs_sal_21_7(i);
            cons_temp_21_7_binned(j) = cons_temp_21_7_binned(j) + cons_temp_21_7(i);
            press_21_7_binned(j) = press_21_7_binned(j) + press_21_7(i);
            divisor = divisor + 1;
        end
    end
    abs_sal_21_7_binned(j) = abs_sal_21_7_binned(j)/divisor;
    cons_temp_21_7_binned(j) = cons_temp_21_7_binned(j)/divisor;
    press_21_7_binned(j) = press_21_7_binned(j)/divisor;
end

% Calculate dS/dz.
h = 1;                        % step size
% depth_21_7_binned           % domain (1 m to 50 m with 1 m step)
% abs_sal_21_7_binned         % function
dSdz = diff(abs_sal_21_7_binned)/h;   % first derivative

% Calculate dT/dz.
h = 1;                        % step size
% depth_21_7_binned           % domain (1 m to 50 m with 1 m step)
% cons_temp_21_7_binned       % function
dTdz = diff(cons_temp_21_7_binned)/h;   % first derivative

% Interpolate midpoints of binned pressure, temperature, and salinity values to match dS/dz indexing.
tempo_press = zeros(49, 1);
tempo_temp = zeros(49, 1);
tempo_sal = zeros(49, 1);
for i = 1 : 49
    tempo_press(i) = (press_21_7_binned(i) + press_21_7_binned(i + 1))/2;
    tempo_temp(i) = (cons_temp_21_7_binned(i) + cons_temp_21_7_binned(i + 1))/2;
    tempo_sal(i) = (abs_sal_21_7_binned(i) + abs_sal_21_7_binned(i + 1))/2;
end

% Calculate N^2_S.
N2_S_21_7 = (-dSdz).*(gsw_grav(50.25, tempo_press)).*(gsw_beta(tempo_sal, tempo_temp, tempo_press));

% Calculate N^2_T.
N2_T_21_7 = (-dTdz).*(gsw_grav(50.25, tempo_press)).*(gsw_alpha(tempo_sal, tempo_temp, tempo_press));

% Plot.
figure(1)
hold on
plot(N2_S_21_7, 1.5 : 49.5, '-.', 'LineWidth', 1)
plot(N2_T_21_7, 1.5 : 49.5, '-.', 'LineWidth', 1)
plot(N2_S_21_7 + N2_T_21_7, 1.5 : 49.5, 'LineWidth', 1.5)
set(gca, 'YDir','reverse')
xlabel('Brunt Vaisala frequency squared (N^2) [s^-^2]')
ylabel('Depth [m]')
legend('Salinity component', 'Temperature component', 'Total')