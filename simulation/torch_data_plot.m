close all;

t = sys_time_s;
x = tfmini_range/100;
smooth = smoothdata(x, 'gaussian',500);
v = gradient(smooth, sys_time_s);

threshold = 0.1;
N = length(v);
ipt = findchangepts(v, 'Statistic', 'linear', 'MinThreshold', threshold);
bp = [1; ipt(:); N];
vfit = zeros(N, 1);
for k = 1:length(bp)-1
    i = bp(k); j = bp(k+1);
    ti = t(i:j);
    p = polyfit(ti - ti(1), v(i:j), 1);
    vfit(i:j) = polyval(p, ti - ti(1));
end

a = gradient(v, sys_time_s);
asmooth = gradient(vfit, sys_time_s);


figure;
plot(smooth);
hold on;
plot(x);

figure;
plot(v);
hold on; 
plot(vfit)

figure;
plot(a);
hold on;
plot(asmooth);

figure;
plot(vms_aux0(1:end)); %throttle

figure;
plot(vms_aux1(1     :end)); %commanded v
hold on;
plot(vms_aux2(1:end)); %actual v ins





findcoef(vms_aux0, vms_aux2, tfmini_range, 1, 32509, 40648, Aircraft.Mass.mass_kg, aircraft.Control.thrust_coeff)

function CD = findcoef(thrust, velocity, height, start, range1, range2, mass, hover)   
    avgthrust = mean(thrust((start+range1):(start+range2))) * hover;
    avgvel = mean(velocity((start+range1):(start+range2)));
    avgheight = mean(height((start+range1):(start+range2)))/100;
    gravity = 9.81 * mass + avgheight*.07383;
    CD = (avgthrust - gravity)/avgvel; 
end
