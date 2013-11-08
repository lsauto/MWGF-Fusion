% FusionOthers.m
% -------------------------------------------------------------------
% 
% Date:    10/04/2013
% Last modified: 26/04/2013
% -------------------------------------------------------------------

function imgRec = FusionOthers(img1, img2, para)
    
    %-----------------------------------------------
    if ~isfield(para, 'method'),
        para.method = 'mswg';
    end
    if ~isfield(para, 'name'),
        para.name = 'unkown';
    end
    %-----------------------------------------------
    tempDir = 'temp';
    if ~exist(tempDir, 'dir'),
        mkdir(tempDir);
    end
    
    fileName = [lower(para.name) '-' lower(para.method) '-' num2str(size(img1, 3)) '.mat'];
    fileName = [tempDir '\' fileName];
%     if exist(fileName, 'file'),
%         load(fileName);
%         return;
%     end
    %----------------------------------------------
    switch lower(para.method)
        case 'mswg',
            imgRec = FusionOurs(img1, img2, para.name);
        otherwise
            error('There is no such method');
    end
    
%     Save ----
    save(fileName, 'imgRec');
end