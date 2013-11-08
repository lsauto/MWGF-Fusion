% script_fusionOthers.m
% -------------------------------------------------------------------
% 
% Date:    10/04/2013
% Last modified: 1/11/2013
% -------------------------------------------------------------------

function main_test()

%     clear
    close all
    clc

    %% ------ Input the images ----------------
    % ------------- The Gray ----------------
    path1 = '.\image\lab_A.tif';
    path2 = '.\image\lab_B.tif';
%     path1 = '.\image\clock_A.bmp';
%     path2 = '.\image\clock_B.bmp';
%     path1 = '.\image\flower_A.png';
%     path2 = '.\image\flower_B.png';
%     path1 = '.\image\desk_A.tif';   
%     path2 = '.\image\desk_B.tif';
%     path1 = '.\image\pepsi_A.tif';
%     path2 = '.\image\pepsi_B.tif';
%     path1 = '.\image\book_A.bmp';
%     path2 = '.\image\book_B.bmp';
    % -------------- The color -----------------  
%     path1 = '.\image\temple_A.bmp';
%     path2 = '.\image\temple_B.bmp';
% 
%     path1 = '.\image\seascape_A.bmp';
%     path2 = '.\image\seascape_B.bmp';
% % %
    % -----------------------------------------
    [img1, img2] = PickName(path1, path2, 0);
    paraShow.fig = 'Input 1';
    paraShow.title = 'Org1';
    ShowImageGrad(img1, paraShow)
    paraShow.fig = 'Input 2';
    paraShow.title = 'Org2';
    ShowImageGrad(img2, paraShow)
    %% ---- The parameter -----
    % ----------- the multi scale -----
    para.Scale.lsigma = 4;
    para.Scale.ssigma = 0.5;
    para.Scale.alpha = 0.5;
    % -------------- the Merge parameter -------------
    para.Merge.per = 0.1;
    para.Merge.show = 1;
    para.Merge.margin = 4*para.Scale.lsigma;
    % ------------- the Reconstruct parameter -----------
    para.Rec.iter = 500;
    para.Rec.res = 1e-6;
    para.Rec.modify = 5;
    para.Rec.iniMode = 'weight';   
    
    %% ---- MWGF implementation ------
    imgRec = MWGFusion(img1, img2, para);

    % --- Show the result ------
    paraShow.fig = 'fusion result';
    paraShow.title = 'MWGF';
    ShowImageGrad(imgRec, paraShow);
    imwrite(uint8(imgRec), 'result.jpg', 'jpeg');
    
   
end
