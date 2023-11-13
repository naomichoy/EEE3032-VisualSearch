%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_computedescriptors.m
%% Skeleton code provided as part of the coursework assessment
%% This code will iterate through every image in the MSRCv2 dataset
%% and call a function 'extractRandom' to extract a descriptor from the
%% image.  Currently that function returns just a random vector so should
%% be changed as part of the coursework exercise.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

windows='C:\Users\cat97\Documents\UniofSurrey\sem1\EEE3032-CVPR\coursework\';
linux='~/cvprlab/';

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = strcat(windows,'msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2');

%% Create a folder to hold the results...
OUT_FOLDER = strcat(windows, 'descriptors');
%% and within that folder, create another folder to hold these descriptors
%% the idea is all your descriptors are in individual folders - within
%% the folder specified as 'OUT_FOLDER'.
choices=["globalRGBhisto", "spatialGridColour", "EOH", "gridPlusEoh", "LBP"];
choice_num = 5;
OUT_SUBFOLDER=choices{choice_num};

allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    fprintf('Processing file %d/%d - %s\n',filenum,length(allfiles),fname);
    tic;
    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    fout=[OUT_FOLDER,'/',OUT_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    
    %% random extract
    % img=double(imread(imgfname_full))./255;
    % F=extractRandom(img);

    switch choice_num
        case 1
            %% RGBHisto
            img = imread(imgfname_full);
            Q=4;
            F=ComputeRGBHistogram(img,Q);

        case 2
            %% colour grid
            img=double(imread(imgfname_full))./255;
            cell_size = 4;
            F = spatialGrid(img, cell_size);

        case 3
            %% EOH
            img=double(imread(imgfname_full))./255;
            cell_size = 4;
            Q = 8;
            F = eoh(img, cell_size, Q);

        case 4
            %% colour grid and eoh
            img=double(imread(imgfname_full))./255;
            cell_size = 4;
            Q = 8;
            F = spatialGridPlusEoh(img, cell_size, Q);
        case 5 
            %% Local Binary Patterns
            img=double(imread(imgfname_full))./255;
            n = 8; % 3x3, 8 neighbours of centre
            F = computeLBP(img, n);
    end
    
    save(fout,'F');
    toc
end

if choice_num == 1 || choice_num == 3
    binCenters = 1:length(F);
    bar(binCenters, F);
    xlabel('Value');
    ylabel('Frequency');
    title_txt = strcat('Histogram example of ', choices{choice_num});
    title(title_txt);
    grid on;
end
