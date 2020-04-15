clearvars; close all; clc;
ws = [1, -1, pi];
c = ["k","--k","-.k"];
% SVLVV
figure(1);
for i = 1:size(ws, 2)
    subplot(1,2,1);
    w = ws(i);
    out = sim('svlvvpr1_schema_SVLVV');
    plot(out.y,  c(i), 'DisplayName', sprintf("w=%d", ws(i)), "LineWidth", 2);  hold on; grid on; grid minor;
    title("Výstup systému"); xlabel("");  ylabel("");  legend;
    subplot(1,2,2);
    plot(out.u, c(i), 'DisplayName', sprintf("w=%d", ws(i)), "LineWidth", 2);  hold on; grid on; grid minor;
    title("Akčný zásah"); xlabel("");  ylabel("");  legend;
end
sgtitle("SVLVV");

% PID
figure(2);
for i = 1:size(ws, 2)
    subplot(1,2,1);
    w = ws(i);
    out = sim('svlvvpr1_schema_PID');
    plot(out.y,  c(i), 'DisplayName', sprintf("w=%d", ws(i)), "LineWidth", 2);  hold on; grid on; grid minor;
    title("Výstup systému"); xlabel("");  ylabel("");  legend;
    subplot(1,2,2);
    plot(out.u,  c(i), 'DisplayName', sprintf("w=%d", ws(i)), "LineWidth", 2);  hold on; grid on; grid minor;
    title("Akčný zásah"); xlabel("");  ylabel("");  legend;
end
sgtitle("PID");