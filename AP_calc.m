% Open figure
% Open the figure
fig = openfig('eoh_w4q8_prRecall.fig');

% Get handles to line objects in the figure
lineHandles = findobj(fig, 'Type', 'line');

% Initialize arrays to store X and Y data
recall = [];
precision = [];

% Extract X and Y data from each line plot
for i = 1:numel(lineHandles)
    recall = [recall; get(lineHandles(i), 'XData')'];
    precision = [precision; get(lineHandles(i), 'YData')'];
end


% extract precision and recall values from the figure
% recall = [0.2, 0.4, 0.6, 0.8, 1.0]; % Replace with your extracted recall values
% precision = [0.9, 0.8, 0.7, 0.6, 0.5]; % Replace with your extracted precision values

% Sort data points by recall
[recall, sortIdx] = sort(recall);
precision = precision(sortIdx);

% Interpolate precision values
interp_precision = zeros(size(precision));
interp_precision(1) = precision(1);

for i = 2:length(interp_precision)
    interp_precision(i) = max(interp_precision(i - 1), precision(i));
end

% Calculate AP
ap = sum(interp_precision .* diff(recall));

disp(['Average Precision (AP): ' num2str(ap)]);