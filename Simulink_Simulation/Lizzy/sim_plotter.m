function plot_response(data, L1, L2, start, color)
    %plot response
    [xData, yData] = get_Data_from(data, L1, L2,"thetas");
    % Initial point
    % plot(xData_1(1), yData_1(1), 'o', 'MarkerSize', 5,'MarkerFaceColor', [0, 0.4470, 0.7410]); 
    plot(xData(start:end), yData(start:end),string(color),'LineWidth', 1.5);
end

function plot_reference(data, L1, L2, start, color)
    %plot references
    [xData, yData] = get_Data_from(data, L1, L2,"response");
    plot(xData(start:end), yData(start:end),string(color),'LineWidth', 1.5);
    xlim([min(xData)-15, max(xData)+15]);
    ylim([min(yData)-15, max(yData)+15]);
end

% Create figure
clear figure;
figure('Renderer', 'painters', 'Position', [10 10 550 500]);
hold on;

% % Plot image -------------------------------
% img = imread('square1.jpg');
% grayImg = rgb2gray(img);
% threshold = 50;  % Adjust if needed
% blackPixels = grayImg < threshold;  % Logical mask of black pixels
% [row, col] = find(blackPixels);
% 
% %transformations
% row = (row*0.14) +0; col = (col*0.14) +0; %scale down, move L/R
% scatter(col, row, 0.5, 'MarkerFaceColor', '#D3D3D3', ...  % Grey color
%         'MarkerEdgeColor', '#D3D3D3', 'MarkerFaceAlpha', 0);  % Set opacity

start = 1000; 
plot_reference(PID_uniform, L1, L2, start, 'k');
plot_response(PID_triangle_no_backlash, L1, L2, start, 'c');
plot_response(PID_triangle_backlash, L1, L2, start, 'r');

%Graph settings ----------------------------
legend('Target shape','No backlash','Backlash modelled'); %'Linear model','Nonlinear model','State feedback control','backlash','Target shape');
xlabel('X (mm)');
ylabel('Y (mm)');
grid on; axis equal;
set(gca,'fontsize', 14) 


