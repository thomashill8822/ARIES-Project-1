figure(2)
hold on
plot(N2_S + N2_T, temp_press)
plot(((N2_003 + N2_004)/2), press_003)
set(gca, 'YDir','reverse')
xlabel('Brunt Vaisala frequency squared (N^2) [s^-^2]')
ylabel('Pressure [dbar]')
legend('CTD', 'MSS')