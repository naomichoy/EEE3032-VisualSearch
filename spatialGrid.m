function G = spatialGrid(img,sz)
% input: normalised img

% Define the grid parameters
numRows = sz; % Number of rows in the grid
numCols = sz; % Number of columns in the grid
[height, width, channel] = size(img);
cellHeight = floor(height / numRows);
cellWidth = floor(width / numCols);

% % Calculate the padding required to ensure even division
% padHeight = numRows * cellHeight - height;
% padWidth = numCols * cellWidth - width;
% 
% % Pad the image if necessary
% if padHeight > 0 || padWidth > 0
%     img = padarray(img, [padHeight, padWidth], 'post');
%     [height, width, channel] = size(img);
% end

G = [];

for i = 1:numRows
    for j = 1:numCols
        % Define the coordinates for the current cell
        rowStart = (i - 1) * cellHeight + 1;
        rowEnd = i * cellHeight;
        colStart = (j - 1) * cellWidth + 1;
        colEnd = j * cellWidth;


        % extract
        cellWindow = img(rowStart:rowEnd, colStart:colEnd, :);
        cellFeatures = extractRandom(cellWindow);

        % concatenate
        G = [G, cellFeatures];
    end
end
assignin('base', "cellWindow", cellWindow);
assignin('base', "G", G);
return
