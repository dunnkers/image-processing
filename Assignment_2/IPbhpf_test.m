clc;                                  % clear the command window
close all;                            % close open figure windows      

D0 = 60;
n = 2;
M = 500;
N = 500;
H = IPbhpf(D0, n, M, N);
D = IPfreqrectdists(M, N);

% Make plot
figure;
% Plot 3d graph
subplot(131);
l = 20; % sample every nth element.
h = surf(H(l:l:end, l:l:end));
set(gca,'XTick',[], 'YTick', []);
xlabel('u');
ylabel('v');
zlabel('H(u, v)');
title('Transfer function in 3D u/v space')

% Plot 
subplot(132);
colormap(gray(256));
imagesc(H);
xlabel('u');
ylabel('v');
title('Transfer function in u/v space');

% Plot 
subplot(133);
u = M : M * 2;
v = 500;
plot(D(u, v), H(u, v))
xlabel('D(u, 500)');
ylabel('H(u, 500)');
title({'Cross section of H(u, v)', ['at u=[', ...
    num2str(M), ':', num2str(M*2), '] and v=', num2str(v)]});

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Write current figure to file
all_file = ['output_plots/bhpf', '_500x500', '.svg'];
set(gcf, 'PaperUnits', 'normalized')
set(gcf, 'PaperPosition', [0 0 1.75 0.40])
saveas(gcf, all_file);
fprintf('\nComplete image has been saved in file %s\n', all_file);
