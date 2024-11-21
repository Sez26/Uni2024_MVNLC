%% import reference signals
% converting array into timesseries type

filename = 'ref_test_sfb.mat';
data = load(filename);
time_arr = data.reference(:,1)';
% ts3 = timeseries((1:5)',[0 10 20 30 40]);
% ref_time = timeseries(data.thetas, time_arr);
th1 = [time_arr; data.reference(:,2)'];
th2 = [time_arr; data.reference(:,3)'];

dth1 = [time_arr; data.reference(:,4)'];
dth2 = [time_arr; data.reference(:,5)'];

save("ref_th1.mat", "th1");
save("ref_th2.mat", "th2");
save("ref_dth1.mat", "dth1");
save("ref_dth2.mat", "dth2");