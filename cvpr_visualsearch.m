%% EEE3032 - Computer Vision and Pattern Recognition (ee3.cvpr)
%%
%% cvpr_visualsearch.m
%% Skeleton code provided as part of the coursework assessment
%%
%% This code will load in all descriptors pre-computed (by the
%% function cvpr_computedescriptors) from the images in the MSRCv2 dataset.
%%
%% It will pick a descriptor at random and compare all other descriptors to
%% it - by calling cvpr_compare.  In doing so it will rank the images by
%% similarity to the randomly picked descriptor.  Note that initially the
%% function cvpr_compare returns a random number - you need to code it
%% so that it returns the Euclidean distance or some other distance metric
%% between the two descriptors it is passed.
%%
%% (c) John Collomosse 2010  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

windows='C:\Users\cat97\Documents\UniofSurrey\sem1\EEE3032-CVPR\coursework\';
linux='~/cvprlab/';

%% Edit the following line to the folder you unzipped the MSRCv2 dataset to
DATASET_FOLDER = strcat(linux, 'msrc_objcategimagedatabase_v2/MSRC_ObjCategImageDatabase_v2');

%% Folder that holds the results...
DESCRIPTOR_FOLDER = strcat(linux, 'descriptors');
%% and within that folder, another folder to hold the descriptors
%% we are interested in working with
DESCRIPTOR_SUBFOLDER='globalRGBhisto';


%% 1) Load all the descriptors into "ALLFEAT"
%% each row of ALLFEAT is a descriptor (is an image)

ALLFEAT=[];
ALLFILES=cell(1,0);
ctr=1;
allfiles=dir (fullfile([DATASET_FOLDER,'/Images/*.bmp']));
allfiles_rownum=[length(allfiles)];
for filenum=1:length(allfiles)
    fname=allfiles(filenum).name;
    row_num=split(fname,"_");
    row_num=str2num(row_num{1});
    allfiles_rownum(filenum)=row_num;

    imgfname_full=([DATASET_FOLDER,'/Images/',fname]);
    img=double(imread(imgfname_full))./255;
    thesefeat=[];
    featfile=[DESCRIPTOR_FOLDER,'/',DESCRIPTOR_SUBFOLDER,'/',fname(1:end-4),'.mat'];%replace .bmp with .mat
    load(featfile,'F');
    ALLFILES{ctr}=imgfname_full;
    ALLFEAT=[ALLFEAT ; F];
    ctr=ctr+1;
end

%% 2) Pick an image at random to be the query
NIMG=size(ALLFEAT,1);           % number of images in collection
queryimg=floor(rand()*NIMG);    % index of a random image
fname=allfiles(queryimg).name;
qurey_row_num = split(fname,"_"); % row num for GT, read ClickMe.html
qurey_row_num = str2num(qurey_row_num{1});

%% 3) Compute the distance of image to the query
dst=[];
for i=1:NIMG
    candidate=ALLFEAT(i,:);
    query=ALLFEAT(queryimg,:);
    
    % change visual search distance method here
    thedst=cvpr_compare(query,candidate);
    dst=[dst ; [thedst i]];
end
dst=sortrows(dst,1);  % sort the results


%% 4) Visualise the results
%% These may be a little hard to see using imgshow
%% If you have access, try using imshow(outdisplay) or imagesc(outdisplay)

SHOW=10; % Show top 15 results
dst=dst(1:SHOW,:);
outdisplay=[];
for i=1:size(dst,1)
   img=imread(ALLFILES{dst(i,2)});
   img=img(1:2:end,1:2:end,:); % make image a quarter size
   img=img(1:81,:,:); % crop image to uniform size vertically (some MSVC images are different heights)
   outdisplay=[outdisplay img];
end

imgshow(outdisplay);
% imagesc(outdisplay);
axis off;

%% calculate PR
pr=[10];
recall=[10];
pr_count=0;
recall_count=0;
total_relavant = sum(allfiles_rownum==qurey_row_num);
for i=1:length(dst)
    inum=dst(i,2);
    fname=allfiles(inum).name;
    irow_num=split(fname,"_");
    irow_num = str2num(irow_num{1});
    if irow_num == qurey_row_num
        pr_count=pr_count+1;
        recall_count=recall_count+1;
    end
    pr(i) = 0;
    pr(i) = pr_count / length(pr);
    recall(i) = recall_count / total_relavant;
end 

% plot pr recall curve
figure;
plot(recall, pr);
xlabel('Recall');
ylabel('Precision');
title('Precision-Recall RGBHistogram')

