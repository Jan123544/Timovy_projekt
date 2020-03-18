
state = [0, 0];
Tsim = inf;
t = 0;
tPlot = 0;
dt = 1e-2;
dtPlot = 1/30;
fh = figure(1);
output = state(1);
m = 1;
L = 10;
g = 10;
B = 1;
sz1 = 0.2;
sz2 = 1;
sz3 = 0.2;
k1 = 1;
k2 = 1;
r = pi/3;

while t < Tsim 
    [state,output] = pendulum_step(state, linearization_law(control_law(r, state, k1, k2), state, m, L, g, B), dt, m, L, g, B);
    t = t + dt;
    tPlot = tPlot + dt;
    if (tPlot > dtPlot)
        plot_pendulum(fh, output, L, sz1, sz2, sz3);
        tPlot = 0;
    end
end

function [u] = linearization_law(v, state, m, L, g, B)
    u = m*L^2*(v + sin(state(1))*g/L + B/m/L^2*state(2));
end

function [v] = control_law(r, state, k1, k2)
    v = -k1*state(2) + k2*(r - state(1));
end

function [new_state, output] = pendulum_step(old_state, input, delta_time, m, L, g, B)
  new_state = zeros(2,1);
  new_state(1) = old_state(1) + delta_time*old_state(2);
  new_state(2) = old_state(2) + delta_time*(input/m/L^2 - g/L*sin(new_state(1)) - B/m/L^2*old_state(2));
  output = new_state(1)-pi/2;
end

function [] = plot_pendulum(fh, output, L, sz1, sz2, sz3)
  weightxy = [ L*cos(output), L*sin(output)];
  figure(fh);
  plot(gca, [0 weightxy(1)], [0 weightxy(2)], 'k');
  circle(gca, 0,0, sz1);
  circle(gca, weightxy(1), weightxy(2), sz2);
  circle(gca, weightxy(1), weightxy(2), sz3);
  axis([(-L-sz2) (L+sz2) (-L-sz2) (L+sz2)]);
end
  
function h = circle(ax,x,y,r)
  hold on
  th = 0:pi/50:2*pi;
  xunit = r * cos(th) + x;
  yunit = r * sin(th) + y;
  h = plot(ax, xunit, yunit, 'k');
  hold off
end
