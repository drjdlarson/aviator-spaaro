


t = t - t(1);
data = [t, thrust];
initial_position = -1*cur_z(1)

figure;
plot(t, thrust);

figure;
plot(t, -1*cur_z)
hold on;
plot(out.tout, out.sim_x.Data(:,3)*-100);

figure;
plot(t, vz)
hold on;
plot(t, vz_cmd);
