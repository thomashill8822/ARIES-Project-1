% Trim profiles to descent only.
abs_sal_10_6_10 = abs_sal_10_6_10(682 : 1536);
cons_temp_10_6_10 = cons_temp_10_6_10(682 : 1536);
dens_10_6_10 = dens_10_6_10(682 : 1536);
depth_10_6_10 = depth_10_6_10(682 : 1536);
ox_mgl_10_6_10 = ox_mgl_10_6_10(682 : 1536);
ox_percent_10_6_10 = ox_percent_10_6_10(682 : 1536);
press_10_6_10 = press_10_6_10(682 : 1536);
sal_10_6_10 = sal_10_6_10(682 : 1536);
temp_10_6_10 = temp_10_6_10(682 : 1536);

% Bin depths, pressures, conservative temperatures, and absolute salinities.
depth_10_6_10_binned = (1 : 49)';
abs_sal_10_6_10_binned = zeros(49, 1);
cons_temp_10_6_10_binned = zeros(49, 1);
press_10_6_10_binned = zeros(49, 1);
for j = 1 : 49
    divisor = 0;
    for i = 1 : size(abs_sal_10_6_10, 1)
        if ((j - 0.5) < depth_10_6_10(i)) && (depth_10_6_10(i) <= (j + 0.5))
            abs_sal_10_6_10_binned(j) = abs_sal_10_6_10_binned(j) + abs_sal_10_6_10(i);
            cons_temp_10_6_10_binned(j) = cons_temp_10_6_10_binned(j) + cons_temp_10_6_10(i);
            press_10_6_10_binned(j) = press_10_6_10_binned(j) + press_10_6_10(i);
            divisor = divisor + 1;
        end
    end
    abs_sal_10_6_10_binned(j) = abs_sal_10_6_10_binned(j)/divisor;
    cons_temp_10_6_10_binned(j) = cons_temp_10_6_10_binned(j)/divisor;
    press_10_6_10_binned(j) = press_10_6_10_binned(j)/divisor;
end

% % Calculate dS/dz.
% h = 1;                        % step size
% % CTD_depth_descent_binned    % domain (1 m to 50 m with 1 m step)
% % CTD_SA_descent_binned       % function
% dSdz = diff(CTD_SA_descent_binned)/h;   % first derivative
% 
% % Calculate dT/dz.
% h = 1;                        % step size
% % CTD_depth_descent_binned    % domain (1 m to 50 m with 1 m step)
% % CTD_CT_descent_binned       % function
% dTdz = diff(CTD_CT_descent_binned)/h;   % first derivative
% 
% % Interpolate midpoints of binned pressure, temperature, and salinity values to match dS/dz indexing.
% temp_press = zeros(49, 1);
% temp_temp = zeros(49, 1);
% temp_sal = zeros(49, 1);
% for i = 1 : 49
%     temp_press(i) = (CTD_press_descent_binned(i) + CTD_press_descent_binned(i + 1))/2;
%     temp_temp(i) = (CTD_CT_descent_binned(i) + CTD_CT_descent_binned(i + 1))/2;
%     temp_sal(i) = (CTD_SA_descent_binned(i) + CTD_SA_descent_binned(i + 1))/2;
% end
% 
% % Calculate N^2_S.
% N2_S = (-dSdz).*(gsw_grav(50.25, temp_press)).*(gsw_beta(temp_sal, temp_temp, temp_press));
% 
% % Calculate N^2_T.
% N2_T = (-dTdz).*(gsw_grav(50.25, temp_press)).*(gsw_alpha(temp_sal, temp_temp, temp_press));
% 
% % Plot.
% figure(1)
% hold on
% plot(N2_S, 1.5 : 49.5, '-.', 'LineWidth', 1)
% plot(N2_T, 1.5 : 49.5, '-.', 'LineWidth', 1)
% plot(N2_S + N2_T, 1.5 : 49.5, 'LineWidth', 1.5)
% set(gca, 'YDir','reverse')
% xlabel('Brunt Vaisala frequency squared (N^2) [s^-^2]')
% ylabel('Depth [m]')
% legend('Salinity component', 'Temperature component', 'Total')