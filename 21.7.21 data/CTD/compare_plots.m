figure(1)
hold on
plot(abs_sal_10_6_9_binned, depth_10_6_9_binned)
plot(abs_sal_21_7_binned, depth_21_7_binned)
set(gca, 'YDir','reverse')
xlabel('Absolute salinity [PSU]')
ylabel('Depth [m]')
legend('June 10', 'July 21')

figure(2)
hold on
plot(cons_temp_10_6_9_binned, depth_10_6_9_binned)
plot(cons_temp_21_7_binned, depth_21_7_binned)
set(gca, 'YDir','reverse')
xlabel('Conservative temperature [deg C]')
ylabel('Depth [m]')
legend('June 10', 'July 21')

figure(3)
hold on
plot((N2_S_10_6_9 + N2_T_10_6_9), 1.5 : 50.5)
plot((N2_S_21_7 + N2_T_21_7), 1.5 : 49.5)
set(gca, 'YDir','reverse')
xlabel('Brunt Vaisala frequency squared [s^-^2]')
ylabel('Depth [m]')
legend('June 10', 'July 21')