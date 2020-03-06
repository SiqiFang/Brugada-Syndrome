data = readtable('INa_WT.csv');
times = 1000*table2array(data(1:176, 1));
current = table2array(data(1:176, 2))./1000;
voltages = table2array(data(1:176, 3));

times = 1000*table2array(data(:, 1));
current = table2array(data(:, 2))./1000;
voltages = table2array(data(:, 3));

figure(1)
subplot(2,1,1)
plot(times(1:end), current, 'linewidth',2);
xlim([0 2000])
legend('current');
xlabel('Time / ms');
ylabel('Current');
%i.LineWidth = 1.5;
subplot(2,1,2)
plot(times(1:end), voltages, 'linewidth',1.5);
xlim([0 2000])
legend('voltage');
xlabel('Time / ms');
ylabel('Voltage');
