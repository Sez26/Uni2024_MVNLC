function [xData_th1, yData_th2] = get_Data_from(data, L1, L2, nonlinear)
    if nonlinear
        th1Data = data.get('th1').Values.Data(:,1);
        th2Data = data.get('th1').Values.Data(:,2);
    else
        th1Data = data.get('th1').Values.Data;
        th2Data = data.get('th2').Values.Data;
    end
    
    xData_th1 = (L1*cos(deg2rad(th1Data)) + L2*cos(deg2rad(th2Data)))*1000;
    yData_th2= (L1*sin(deg2rad(th1Data)) + L2*sin(deg2rad(th2Data)))*1000;
    
    %translation 90 degrees
    % xData_th1 = -yData_th2_before;
    % yData_th2 = -xData_th1_before;
end

function plot_shape(data, L1, L2, start)
    [xData, yData] = get_Data_from(data, L1, L2, false);
    plot(xData(start:end), yData(start:end),'LineWidth', 1.5);
end

% Create figure
clear figure;
figure('Renderer', 'painters', 'Position', [10 10 550 500]);
hold on;

% %Plot start point
% plot(xData_1(1), yData_1(1), 'o', 'MarkerSize', 5,'MarkerFaceColor', [0, 0.4470, 0.7410]); % Initial point

% Plot image -------------------------------
img = imread('triangle.jpg');
grayImg = rgb2gray(img);
threshold = 50;  % Adjust if needed
blackPixels = grayImg < threshold;  % Logical mask of black pixels
[row, col] = find(blackPixels);
row = (row*0.1355) +0; col = (col*0.1355) +0; %scale down, move L/R
scatter(col, row, 0.5, 'MarkerFaceColor', '#D3D3D3', ...  % Grey color
        'MarkerEdgeColor', '#D3D3D3', 'MarkerFaceAlpha', 0);  % Set opacity

%rotation constants
x_ref = xData(1); y_ref = yData(1);
theta = -deg2rad(27);
R = [cos(theta), -sin(theta); 
     sin(theta),  cos(theta)];

% Plot reference signal ------------------
[refTh1, refTh2] = import_refs('triangle');
xData_ref = (L1*cos(deg2rad(refTh1)) + L2*cos(deg2rad(refTh2)))*1000;
yData_ref = (L1*sin(deg2rad(refTh1)) + L2*sin(deg2rad(refTh2)))*1000;
xData_ref = xData_ref-50+23; yData_ref = yData_ref+80 -42;
translatedPoints = R*[xData_ref - x_ref; yData_ref - y_ref];
xData_ref = translatedPoints(1, :) + x_ref; yData_ref = translatedPoints(2, :) + y_ref;

%for control triangle overlay:
%xData_ref = xData_ref-42; yData_ref = yData_ref -82;

plot(xData_ref, yData_ref, 'k', 'LineWidth', 1.5);

xlim([min(xData_ref)-15, max(xData_ref)+25]);
ylim([min(yData_ref)-15, max(yData_ref)+25]);

%Plot model response
[xData, yData] = get_Data_from(PID_tri_backlash_two_motors, L1, L2, false);
xData = (xData-8+23)'; yData = (yData +160 -42)';
translatedPoints = R*[xData - x_ref; yData - y_ref];
xData = translatedPoints(1, :) + x_ref; yData = translatedPoints(2, :) + y_ref;

start = 300;
plot(xData(start:end), yData(start:end),'r','LineWidth', 1.5);



%Graph settings ----------------------------
legend('Real Response','Target shape','PID Model Response');
xlabel('X (mm)');
ylabel('Y (mm)');
grid on;
axis equal;
set(gca,'fontsize', 14) 

