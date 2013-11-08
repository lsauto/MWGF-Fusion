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
%     path1 = '.\image\clock_A.bmp';
%     path2 = '.\image\clock_B.bmp';
%     path1 = '.\image\book1.bmp';
%     path2 = '.\image\book2.bmp';
%     path2 = '.\image\color_flowerAA.png';
%     path1 = '.\image\color_flowerBB.png';
%     path2 = '.\image\disk1.tif';   
%     path1 = '.\image\disk2.tif';
%     path2 = '.\image\lab1.tif';
%     path1 = '.\image\lab2.tif';
%     path1 = '.\image\mulfocus1.tif';
%     path2 = '.\image\mulfocus2.tif';
    % -------------- The color -----------------  
%     path2 = '.\image\lionAZ2.bmp';
%     path1 = '.\image\lionBZ2.bmp';
% 
    path2 = '.\image\seascpape_6A.bmp';
    path1 = '.\image\seascpape_6B.bmp';
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
    
    disp([para.method ' :']);
    Result=EvaluationFusion(img1,img2,imgRec,256);
%     dir = '.\temp\';
%     fileName = [para.name '-' para.method '.eps'];
%     fileName = strcat(dir, fileName);
%     if size(img1, 3) == 1,
%         print(gcf, '-deps', fileName);
%     else
%         print(gcf, '-depsc', fileName);
%     end
   
end
