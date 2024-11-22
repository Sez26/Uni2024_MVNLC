% Get the signal objects for theta1 and theta2
theta1Signal = base.get('theta1'); % Get 'theta1' signal
theta2Signal = base.get('theta2'); % Get 'theta2' signal

% Access the timeseries data within the signal
theta1Timeseries = theta1Signal.Values;
theta2Timeseries = theta2Signal.Values;

% Extract numerical data from the timeseries
th1Data = theta1Timeseries.Data;
th2Data = theta2Timeseries.Data;

% (Optional) Extract time values
time1 = theta1Timeseries.Time;
time2 = theta2Timeseries.Time;

xData = (L1*cos(deg2rad(th1Data)) + L2*cos(deg2rad(th2Data)))*1000;
yData = (L1*sin(deg2rad(th1Data)) + L2*sin(deg2rad(th2Data)))*1000;

% Create figure
clear figure;
figure;
hold on;

plot(xData, yData, 'k', 'LineWidth', 0.5);
h = plot(xData(1), yData(1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Initial point

xlabel('X (mm)');
ylabel('Y (mm)');
title('Simulated Response of Different Control Methods');
grid on;
axis equal;
xlim([min(xData)-50, max(xData)+50]);
ylim([min(yData)-50, max(yData)+50]);


%Plot square
squareSide = 86; % Side length in mm
cornerPoint = [77, -43]; % Bottom-left corner of the square (adjust as needed)
xSquare = cornerPoint(1) + [0, squareSide, squareSide, 0, 0];
ySquare = cornerPoint(2) + [0, 0, squareSide, squareSide, 0];
plot(xSquare, ySquare, 'r-', 'LineWidth', 0.5); % Red solid line for the square
legend('PID control', 'Start point', 'Target square')