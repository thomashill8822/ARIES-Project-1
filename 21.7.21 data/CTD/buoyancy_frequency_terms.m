% Bin depths, pressures, conservative temperatures, and absolute salinities.
CTD_depth_descent_binned = (1 : 50)';
CTD_SA_descent_binned = zeros(50, 1);
CTD_CT_descent_binned = zeros(50, 1);
CTD_press_descent_binned = zeros(50, 1);
for j = 1 : 50
    divisor = 0;
    for i = 1 : 322
        if ((j - 0.5) < CTD_depth_descent_trimmed(i)) && (CTD_depth_descent_trimmed(i) <= (j + 0.5))
            CTD_SA_descent_binned(j) = CTD_SA_descent_binned(j) + SA(i);
            CTD_CT_descent_binned(j) = CTD_CT_descent_binned(j) + CT(i);
            CTD_press_descent_binned(j) = CTD_press_descent_binned(j) + CTD_press_descent_trimmed(i);
            divisor = divisor + 1;
        end
    end
    CTD_SA_descent_binned(j) = CTD_SA_descent_binned(j)/divisor;
    CTD_CT_descent_binned(j) = CTD_CT_descent_binned(j)/divisor;
    CTD_press_descent_binned(j) = CTD_press_descent_binned(j)/divisor;
end

% Calculate dS/dz.
h = 1;                        % step size
% CTD_depth_descent_binned    % domain (1 m to 50 m with 1 m step)
% CTD_SA_descent_binned       % function
dSdz = diff(CTD_SA_descent_binned)/h;   % first derivative

% Calculate dT/dz.
h = 1;                        % step size
% CTD_depth_descent_binned    % domain (1 m to 50 m with 1 m step)
% CTD_CT_descent_binned       % function
dTdz = diff(CTD_CT_descent_binned)/h;   % first derivative

% Interpolate midpoints of binned pressure, temperature, and salinity values to match dS/dz indexing.
temp_press = zeros(49, 1);
temp_temp = zeros(49, 1);
temp_sal = zeros(49, 1);
for i = 1 : 49
    temp_press(i) = (CTD_press_descent_binned(i) + CTD_press_descent_binned(i + 1))/2;
    temp_temp(i) = (CTD_CT_descent_binned(i) + CTD_CT_descent_binned(i + 1))/2;
    temp_sal(i) = (CTD_SA_descent_binned(i) + CTD_SA_descent_binned(i + 1))/2;
end

% Calculate N^2_S.
N2_S = (-dSdz).*(gsw_grav(50.25, temp_press)).*(gsw_beta(temp_sal, temp_temp, temp_press));

% Calculate N^2_T.
N2_T = (-dTdz).*(gsw_grav(50.25, temp_press)).*(gsw_alpha(temp_sal, temp_temp, temp_press));

% Plot.
figure(1)
hold on
plot(N2_S, 1.5 : 49.5, '-.', 'LineWidth', 1)
plot(N2_T, 1.5 : 49.5, '-.', 'LineWidth', 1)
plot(N2_S + N2_T, 1.5 : 49.5, 'LineWidth', 1.5)
set(gca, 'YDir','reverse')
xlabel('Brunt Vaisala frequency squared (N^2) [s^-^2]')
ylabel('Depth [m]')
legend('Salinity component', 'Temperature component', 'Total')