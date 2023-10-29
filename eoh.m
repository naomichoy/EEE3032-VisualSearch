function G = eoh(img, wsz, Q)
% input: normalised img

% Define the grid parameters
numRows = wsz; % Number of rows in the grid
numCols = wsz; % Number of columns in the grid
[height, width, channel] = size(img);
cellHeight = floor(height / numRows);
cellWidth = floor(width / numCols);

num_hist_bins = Q;
G = [];

for i = 1:numRows
    for j = 1:numCols
        % Define the coordinates for the current cell
        rowStart = (i - 1) * cellHeight + 1;
        rowEnd = i * cellHeight;
        colStart = (j - 1) * cellWidth + 1;
        colEnd = j * cellWidth;
           
        % get edges
        cellEdges = edge(img(rowStart:rowEnd, colStart:colEnd), 'Sobel');
        H = histcounts(cellEdges(:), num_hist_bins, 'BinLimits', [-pi/2, pi/2]);
        H = H ./sum(H);

        G = [G, H];
    end
end

return

