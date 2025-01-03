%Izzy's values

plnt1_2_kp_th1 = 50;       
plnt1_2_kp_th2 = plnt1_2_kp_th1;

plnt1_2_ki_th1 = 0.9;      
plnt1_2_ki_th2 = plnt1_2_ki_th1;

plnt1_2_kd_th1 = 2.5;
plnt1_2_kd_th2 = plnt1_2_kd_th1;

plnt1_2_N_th1 = 1000;
plnt1_2_N_th2 = 1000;

% %Alternative better tuning
% plnt1_2_kp_th1 = 100;       
% plnt1_2_kp_th2 = plnt1_2_kp_th1;
% 
% plnt1_2_ki_th1 = 0.45;      
% plnt1_2_ki_th2 = plnt1_2_ki_th1;
% 
% plnt1_2_kd_th1 = 3;
% plnt1_2_kd_th2 = plnt1_2_kd_th1;


%To calculate cutoff frequency for low pass filter
% nyquists frequency = 1/2 sampling frequency
% sampling frequency = 230400
% this could be 0-50% of 115200

% T = 1/115200;
% w_a = (2/T)*tan(0.25 * 115200* (T/2))