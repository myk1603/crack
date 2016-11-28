clc;
clear all;
close all;
input_parameters
%% PCA code for Train crack images here already patch size is 256*384
PCA_trainpath1 = uigetdir(strcat(training_path_JPG),'select path for crack train image');
ctrain= dir(PCA_trainpath1);
[avg_CrkImg_mean,eigen_vect_orig,num_of_trnCrkImg,Projections] = crkED1(PCA_trainpath1);

%% projected crack image and Set for crack images for select threshold here already patch size is 256*384
PCA_trainpath2= uigetdir(strcat(training_path_JPG),'select the path for project train image');
ctrain1 = dir(PCA_trainpath2);
[Train_projtn,num_of_Crk_tstImg] = crkED11(PCA_trainpath2,avg_CrkImg_mean,eigen_vect_orig);

%% Calculate Euclidean distance ED1 for threshold value  
[Euclidean_dist_mean] = calculateED1( Train_projtn,num_of_Crk_tstImg,num_of_trnCrkImg,Projections);

%% Test set both crack and non-crack images here image size is (2304*3456)*3 and  convert this image into grayscale(256*384)
PCA_testpath1= uigetdir(strcat(training_path_JPG),'select the path for test image to select crack patch image');
validate = dir(PCA_testpath1);
[J] = TstcrkED2(PCA_testpath1);
% Convert test Image into (81(256x384))small blocks use function make blocks 
[BB] = fun_Mk_blk1(J);
% PCA Steps project these block on PCA training crack images
 num_of_Crk_tst1= size(BB,1);
 for j=1:num_of_Crk_tst1
    tst_diff1(j,:) = double(BB(j,:))- avg_CrkImg_mean;
 end
     Test_projection2 = tst_diff1*eigen_vect_orig;
%% Calculate ED2
[Euclidean_dist2_min,Euclidean_dist2] = calculateED2(Test_projection2,Projections,num_of_Crk_tst1,num_of_trnCrkImg);
%% Compare ED1 and ED2 for get pca based crack patch prediction
[Prediction] = crkpredictionpca( Euclidean_dist2_min,Euclidean_dist_mean);

%% CLear variable
clear avg_CrkImg_mean eigen_vect_orig num_of_trnCrkImg Projections I Train_projtn num_of_Crk_tstImg tst_diff1
clear  Euclidean_dist_mean Test_projection2 Euclidean_dist2_min Euclidean_dist2
