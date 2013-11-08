% script_fusionOthers.m
% -------------------------------------------------------------------
% 
% Date:    10/04/2013
% Last modified: 1/11/2013
% -------------------------------------------------------------------

function script_fusion()

%     clear
    clc

    % ------------- The Gray ----------------
    path1 = '.\image\clock_A.bmp';
    path2 = '.\image\clock_B.bmp';
%     path1 = '.\image\book_A.bmp';
%     path2 = '.\image\book_B.bmp';
%     path1 = '.\image\flower_A.png';
%     path2 = '.\image\flower_B.png';
%     path1 = '.\image\disk_A.tif';   
%     path2 = '.\image\disk_B.tif';
%     path1 = '.\image\lab_A.tif';
%     path2 = '.\image\lab_B.tif';
%     path1 = '.\image\pepsi_A.tif';
%     path2 = '.\image\pepsi_B.tif';
    % -------------- The color -----------------  
%     path1 = '.\image\temple_A.bmp';
%     path2 = '.\image\temple_B.bmp';
% 
%     path1 = '.\image\seascape_A.bmp';
%     path2 = '.\image\seascape_B.bmp';
% % % 
    [img1, img2, para.name] = PickName(path1, path2, 0);
    % -----------------------------------------
% 
    para.method = 'mswg';

    imgRec = FusionOthers(img1, img2, para);

    % Show the result
%     cccc = clock;
%     paraShow.fig = [num2str(cccc(5)) ' Recover ' upper(para.method) '(' para.name ')'];
    paraShow.title = [upper(para.method)];
    ShowImageGrad(imgRec, paraShow);
%     ShowImageGrad(imgRec);
    paraShow.title = 'Org1';
    ShowImageGrad(img1, paraShow)
    paraShow.title = 'Org2';
    ShowImageGrad(img2, paraShow)
    
    
%     dir = '.\temp\';
%     fileName = [para.name '-' para.method '.eps'];
%     fileName = strcat(dir, fileName);
%     if size(img1, 3) == 1,
%         print(gcf, '-deps', fileName);
%     else
%         print(gcf, '-depsc', fileName);
%     end
   
end
