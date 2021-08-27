CTD_N2_binned = zeros(48, 1);
for j = 6 : 53
    divisor = 0;
    for i = 1 : 49
        if ((j - 0.5) < temp_press(i)) && (temp_press(i) <= (j + 0.5))
            CTD_N2_binned(j - 5) = CTD_N2_binned(j - 5) + ((N2_S(i) + N2_T(i))/2);
            divisor = divisor + 1;
        end
    end
    CTD_N2_binned(j - 5) = CTD_N2_binned(j - 5)/divisor;
end

figure(1)
hold on
scatter(CTD_N2_binned, ((N2_003 + N2_004)/2))
x = [-2e-4 1.8e-3]';
y = x;
plot(x, y)
xlim([-2e-4 12e-4])
ylim([0 1.8e-3])
xlabel('CTD descent BVF [s^-^2]')
ylabel('Mean MSS BVF [s^-^2]')
legend('', 'y = x')