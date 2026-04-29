clc; clear; close all;

file_name = "zdof_pos"; % <-- change file number

vars = {"sys_time_s", ...   time
        "vms_aux0", ...     t_cmd
        "vms_aux1", ...     vz_cmd
        "vms_aux2", ...     vz
        "telem_param4", ...     tar_z
        "tfmini_range"; ...     cur_z
        };

load("../" + file_name + ".mat", vars{:});
range = 26602:44337;

t       = sys_time_s(range);
thrust  = vms_aux0(range);
vz_cmd  = vms_aux1(range);
vz      = vms_aux2(range);
tar_z   = -telem_param4(range);
cur_z   = -tfmini_range(range);

save('zdof_pos_trimmed', 't', 'thrust', 'vz_cmd', 'vz', 'tar_z', 'cur_z')

% Z-Position
figure()
plot(t, -cur_z, 'DisplayName', 'Actual');
hold on;
plot(t, -tar_z, 'DisplayName', 'Target');
xlabel('Time (s)');
ylabel('Z-Position (cm)');
title('Z-Position vs. Time');
legend();
grid on;

% Z-Velocity
figure()
plot(t, vz, 'DisplayName', 'Actual');
hold on;
plot(t, vz_cmd, 'DisplayName', 'Target');
xlabel('Time (s)');
ylabel('Z-Velocity (m/s)');
title('Z-Velocity vs. Time');
legend();
grid on;