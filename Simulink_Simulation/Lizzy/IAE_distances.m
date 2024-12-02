% get errors and times from timeseries data
function [err, time] = calculateErrors(plant, ref_plant, L1, L2, start, bspline)
    %Get response thetas
    [xData_th1, yData_th2] = get_Data_from(plant, L1, L2, "thetas");
    disp(size(xData_th1))
    %Get reference thetas
    if string(bspline) == "bspline"
        [xData_ref1, yData_ref2] = get_Data_from(ref_plant, L1, L2, "references");
        disp(size(xData_ref1))
    else
        [xData_ref1, yData_ref2] = get_Data_from(plant, L1, L2, "references");
    end

    %Return time
    time = plant.get('ref_th1').Values.Time; %verified both time series are the same
    time = time(start:end);

    %Calculate error distances
    response = [xData_th1(start:end), yData_th2(start:end)];
    ref = [xData_ref1(start:end), yData_ref2(start:end)];
    err = sqrt(sum((response - ref).^2, 2));
end

%plot IAE graph
function [time, IAE] = plot_this(plant, ref_plant, L1, L2, start, bspline,color, linwidth)
    [err, time] = calculateErrors(plant, ref_plant, L1, L2, start,bspline);

    %delete first items in err and time
    err = err(start:end);
    time = time(start:end);

    if time(2)-time(1) == time(3)-time(2) %time steps are the same between each point
        dt = time(2) - time(1); % Time difference between consecutive points
        IAE = cumsum(err) * dt;
    else %non-linear time: time steps vary between each point
        dt = diff(time);
        IAE_contribution = [0; err(2:end) .* dt];
        IAE = cumsum(IAE_contribution);
    end
    semilogy(time, IAE,string(color), 'LineWidth', linwidth);
end

% Plot IAE against time
clear figure;

figure('Renderer', 'painters', 'Position', [10 10 550 500]);
hold on; grid on;

start = 1;
[time, IAE] = plot_this(no_filter, PID_uniform, L1, L2, start, 'no','b',1.5);
[time, IAE] = plot_this(filter_and_anti_wind, filter_and_anti_wind,  L1, L2, start, 'no','r',1.5);
[time, IAE] = plot_this(filter, filter, L1, L2, start, 'no','k',1.5);

%[time, IAE] = plot_this(PID_square_backlash, PID_square_backlash, L1, L2, start, 'no');

set(gca, 'YScale', 'log');
ylim([11 18]); %ymin, ymax
xlim([2 4])


xlabel('Time (s)');
ylabel('IAE (deg)');
legend('PID model','PID model + filter','PID model + filter + anti-windup','Location','northwest');
