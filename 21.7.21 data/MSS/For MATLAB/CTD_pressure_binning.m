CTD_descent_sal_binned = zeros(48, 1);
for j = 6 : 53
    divisor = 0;
    for i = 1 : 884
        if ((j - 0.5) < CTD_press(i)) && (CTD_press(i) <= (j + 0.5))
            CTD_descent_sal_binned(j - 5) = CTD_descent_sal_binned(j - 5) + CTD_sal(i);
            divisor = divisor + 1;
        end
    end
    CTD_descent_sal_binned(j - 5) = CTD_descent_sal_binned(j - 5)/divisor;
end

figure(1)
hold on
scatter(CTD_descent_sal_binned, ((sal_003 + sal_004)/2))
x = [0 40]';
y = x;
plot(x, y)
xlim([34.6 35.05])
ylim([34.6 35.05])
% xlim([34.6 35.05])
% ylim([34.87 34.97])
xlabel('CTD descent salinity [PSU]')
ylabel('Mean MSS salinity [PSU]')
legend('', 'y = x')