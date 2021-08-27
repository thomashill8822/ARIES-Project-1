% Calculate dS/dz.
h = 1;                        % step size
% depth_10_6_10_binned         % domain (1 m to 49 m with 1 m step)
% abs_sal_10_6_10_binned       % function
dSdz = diff(abs_sal_10_6_10_binned)/h;   % first derivative

% Calculate dT/dz.
h = 1;                        % step size
% depth_10_6_10_binned         % domain (1 m to 49 m with 1 m step)
% cons_temp_10_6_10_binned       % function
dTdz = diff(cons_temp_10_6_10_binned)/h;   % first derivative

% Interpolate midpoints of binned pressure, temperature, and salinity values to match dS/dz indexing.
tempo_press = zeros(48, 1);
tempo_temp = zeros(48, 1);
tempo_sal = zeros(48, 1);
for i = 1 : 48
    tempo_press(i) = (press_10_6_10_binned(i) + press_10_6_10_binned(i + 1))/2;
    tempo_temp(i) = (cons_temp_10_6_10_binned(i) + cons_temp_10_6_10_binned(i + 1))/2;
    tempo_sal(i) = (abs_sal_10_6_10_binned(i) + abs_sal_10_6_10_binned(i + 1))/2;
end

% Calculate N^2_S.
N2_S_10_6_10 = (-dSdz).*(gsw_grav(50.27, tempo_press)).*(gsw_beta(tempo_sal, tempo_temp, tempo_press));

% Calculate N^2_T.
N2_T_10_6_10 = (-dTdz).*(gsw_grav(50.27, tempo_press)).*(gsw_alpha(tempo_sal, tempo_temp, tempo_press));

% % Plot.
% figure(1)
% hold on
% plot(N2_S, 1.5 : 48.5, '-.', 'LineWidth', 1)
% plot(N2_T, 1.5 : 48.5, '-.', 'LineWidth', 1)
% plot(N2_S + N2_T, 1.5 : 48.5, 'LineWidth', 1.5)
% set(gca, 'YDir','reverse')
% xlabel('Brunt Vaisala frequency squared (N^2) [s^-^2]')
% ylabel('Depth [m]')
% legend('Salinity component', 'Temperature component', 'Total')