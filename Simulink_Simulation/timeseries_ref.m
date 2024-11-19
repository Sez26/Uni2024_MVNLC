%% import reference signals
% converting array into timesseries type

filename = 'ref_test.mat';
data = load(filename);
time_arr = 0:0.02:20;
time_arr = time_arr(1:end-1);
% ts3 = timeseries((1:5)',[0 10 20 30 40]);
% ref_time = timeseries(data.thetas, time_arr);
th1 = [time_arr; data.thetas(:,1)'];
th2 = [time_arr; data.thetas(:,2)'];

save("ref_th1.mat", "th1");
save("ref_th2.mat", "th2");