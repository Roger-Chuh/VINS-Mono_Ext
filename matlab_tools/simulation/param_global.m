%%
% Feb. 10 2018, tune parameters

global g_param;
%% noise 
g_param.odo_t_std = 0.07; %0.07; % 0.05; % 0.15;
g_param.odo_R_std = 0.02; % 0.02;
g_param.pt_std = 0.01; % 0.02 % 0.05;
g_param.pix_std = 1.; %1. 2.;

g_param.H = 0.7; % 0.7
g_param.feature_step = 0.4;
g_param.pose_step = 0.3; % 0.3;
g_param.swing_times = 5; % 7;
g_param.num_pts = 70; %70;

g_param.swing_angle = 15; % 30; % degree
g_param.x_range = 1.0;

g_param.iterate_num = 10;

g_param.diverge_lambda = 100000; % if diverge, lambda = diverge_lambda
g_param.diverge_error = 200000; % if diverge, err > diverge_error


