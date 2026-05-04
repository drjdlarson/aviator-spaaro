t = t - t(1);
data = [t, thrust, deg2rad(ang_cmd), vx_cmd, tar_x];
initial_position = cur_x(1)/100;

%%
figure;
plot(t, thrust);

figure;
plot(t,ang, 'DisplayName', 'Flight');
hold on;
plot(out.tout, rad2deg(out.sim_ang.data), 'DisplayName', 'Sim')
plot(t, ang_cmd, 'DisplayName', 'Input');
grid on
title("Angle")
legend("Location","northwest")
ylabel("Angle (deg)")
xlabel("Time (s)")

figure;
plot(t, cur_x, 'DisplayName', 'Flight')
hold on;
plot(out.tout, out.sim_x.Data(:,2)*100, 'DisplayName', 'Sim');
plot(t, tar_x, 'DisplayName', 'Input');
grid on
title("Position")
legend("Location","northwest")
ylabel("Position (cm)")
xlabel("Time (s)")