function F = computeLBP(image, n)
    % Convert the image to grayscale if it is in RGB
    if size(image, 3) == 3
        image = rgb2gray(image);
    end

    % Define the number of neighbors for LBP
    numNeighbors = n;

    % Compute LBP features
    F = extractLBPFeatures(image, 'NumNeighbors', numNeighbors);
end