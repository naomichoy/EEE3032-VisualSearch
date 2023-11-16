# EEE3032-VisualSearch

1. Create a folder for descriptors, change the file paths 
2. run cvpr_computedescriptors on the chosen descriptor type and parameters
3. choose the descriptor in cvpr_visualsearch, adjust the desired image range for single class only query image selection
4. comment out / uncomment the distance measurement method at section 3) Compute the distance
5. If using PCA, choose the number of eigenvectors to keep at the function call Eigen_PCA(), third parameter 
6. run cvpr_visualsearch 

available descriptor choices:
["globalRGBhisto", "spatialGridColour", "EOH", "gridPlusEoh", "LBP"]

The code can be extended to add more types of descriptors
