% Sample time and temperature data (replace with your own)
T_data = ROI2_Temp_FC_34(3150:4350);
Time = Time_FC_34(3150:4350);
T_env = 20;
% Initial guess for [B0, B1]
params0 = [1, -0.5];
% Objective function to minimize: difference between model and data
model_fun = @(params, Time_truss) simulate_temp(params, Time_truss, T_data(1), T_env);
% Use lsqcurvefit (requires Optimization Toolbox)
options = optimoptions('lsqcurvefit','Display','iter');
[params_fit, resnorm] = lsqcurvefit(model_fun, params0, Time, T_data, [], [], options);
B0_est = params_fit(1);
B1_est = params_fit(2);
fprintf('Estimated B0 = %.4f, B1 = %.4f\n', B0_est, B1_est);
% Plot the fit
figure
T_fit = model_fun(params_fit, Time);
plot(Time, T_data, 'o', Time, T_fit, '-')
xlabel('Time'), ylabel('Temperature')
legend('Observed Data', 'Fitted Model')
title('FC 34, ROI 2, Layer 2')
grid on
%% --- Subfunction to solve ODE ---
function T_sim = simulate_temp(params, t_data, T0, T_env)
   B0 = params(1);
   B1 = params(2);
   % Define the ODE
   ode_truss = @(t, T) B0 + B1 * (T - T_env);
   % Solve ODE
   [t_sol, T_sol] = ode45(ode_truss, t_data, T0);
   % Interpolate to match t_data points
   T_sim = interp1(t_sol, T_sol, t_data);
end

