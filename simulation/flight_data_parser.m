% clc; clear; close all;

file_name = "aviator_7"; % <-- change file number

vars = {"sys_time_s", ...   time
        "vms_aux0", ...     t_cmd
        "ercf_angle", ...   angle_truth
        "vms_aux2", ...     angle_cmd
        "vms_aux6", ...     tar_v
        "vms_aux7", ...     cur_v
        "telem_param4", ...     tar_x
        "tfmini_range"; ...     cur_x
        };

load("../" + file_name + ".mat", vars{:});

range =     210000:231465;
% range =     17000:23000;
t       = sys_time_s(range);
thrust  = vms_aux0(range);
ang_cmd = rad2deg(vms_aux2(range));
ang     = ercf_angle(range);
vx_cmd  = vms_aux6(range);
vx      = vms_aux7(range);
tar_x   = telem_param4(range);
cur_x   = tfmini_range(range);

for i=1:numel(ang)
    if ang(i) > 100
        ang(i) = ang(i) - 360;
    end
end

save('05_04_pos', 't', 'thrust', 'ang_cmd', 'ang', 'vx_cmd', 'vx', 'tar_x', 'cur_x')

% X-Angle
figure()
plot(t, ang, 'DisplayName', 'Actual');
hold on;
plot(t, ang_cmd, 'DisplayName', 'Target');
xlabel('Time (s)');
ylabel('Angle (deg)');
title('Angle vs. Time');
legend();
grid on;

% X-Position
figure()
plot(t, cur_x, 'DisplayName', 'Actual');
hold on;
plot(t, tar_x, 'DisplayName', 'Target');
xlabel('Time (s)');
ylabel('X-Position (cm)');
title('X-Position vs. Time');
legend();
grid on;

% X-Velocity
figure()
plot(t, vx, 'DisplayName', 'Actual');
hold on;
plot(t, vx_cmd, 'DisplayName', 'Target');
xlabel('Time (s)');
ylabel('X-Velocity (m/s)');
title('X-Velocity vs. Time');
legend();
grid on;