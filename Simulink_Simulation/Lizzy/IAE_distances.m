% get e and t from timeseries data
function [err, time] = get_Data_from(workspace_name, L1, L2)
    theta1Signal = workspace_name.get('th1');
    theta2Signal = workspace_name.get('th2');
    theta1Timeseries = theta1Signal.Values;
    theta2Timeseries = theta2Signal.Values;
    th1Data = theta1Timeseries.Data;
    th2Data = theta2Timeseries.Data;
    xData_th1 = (L1*cos(deg2rad(th1Data)) + L2*cos(deg2rad(th2Data)))*1000;
    yData_th2 = (L1*sin(deg2rad(th1Data)) + L2*sin(deg2rad(th2Data)))*1000;

    %Import reference x y positions
    theta1Signal = workspace_name.get('ref_th1'); 
    theta2Signal = workspace_name.get('ref_th2');
    theta1Timeseries = theta1Signal.Values;
    theta2Timeseries = theta2Signal.Values;
    th1Data = theta1Timeseries.Data;
    th2Data = theta2Timeseries.Data;
    xData_ref1 = (L1*cos(deg2rad(th1Data)) + L2*cos(deg2rad(th2Data)))*1000;
    yData_ref2 = (L1*sin(deg2rad(th1Data)) + L2*sin(deg2rad(th2Data)))*1000;

    %Return time
    time = theta1Timeseries.Time; %verified both time series are the same

    %Calculate error distances
    response = [xData_th1, yData_th2];
    ref = [xData_ref1, yData_ref2];
    err = sqrt(sum((response - ref).^2, 2));    
end

function plot_this(plant, L1, L2)
    [err, time] = get_Data_from(plant, L1, L2); %get errors from timeseries data
    
    if time(2)-time(1) == time(3)-time(2) %time steps are the same between each point
        dt = time(2) - time(1); % Time difference between consecutive points
        IAE = cumsum(err) * dt;
    else %non-linear time: time steps vary between each point
        dt = diff(time);
        IAE_contribution = [0; err(2:end) .* dt];
        IAE = cumsum(IAE_contribution);
    end
    plot(time, IAE, 'LineWidth', 1)
end

% Plot IAE against time
clear figure;
figure; hold on;

%plot_this(PD_control, L1, L2);
plot_this(PID_control, L1, L2);
plot_this(Plant_0, L1, L2);
% plot_this(Plant_2_1_circle);
plot_this(Plant_3, L1, L2);

xlabel('Time (s)');
ylabel('IAE (rad.s)'); 
legend;
title('Non linear model: Integral of Absolute Error')