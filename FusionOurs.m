% FusionOurs.m
% script_fusionColor.m
% -------------------------------------------------------------------
% 
% Date:    27/04/2013
% Last modified: 29/10/2013
% -------------------------------------------------------------------
function imgRec = FusionOurs(img1, img2, imgName)
    
    %% ----------------- Load the parameter -------------------
    para = ParaLoad(imgName);
    %% ----------------- Compute the weights ------------------
    if size(img1, 3) == 1,
        img1Gray = img1;
        img2Gray = img2;
    else 
        img1Gray = RGBTOGRAY(img1);
        img2Gray = RGBTOGRAY(img2);
    end
    
    
    [dx1, dy1] = GradientMethod(img1Gray, 'zhou'); 
    [dx2, dy2] = GradientMethod(img2Gray, 'zhou');
    dxdy1 = dx1+1i*dy1;
    dxdy2 = dx2+1i*dy2;
    
    % ---- judge the front image ------------
    para.Prune.oppo = 0;
    [~, ~, wt1, wt2] = WeightGradient(imresize(dxdy1, 0.25), imresize(dxdy2, 0.25), para);
    aa = wt1>wt2+eps;
    if sum(aa(:))/numel(wt1) > 0.5,
        para.Prune.oppo = 1;
    end
        
    % ---------------------------------------
  
    
    if isfield(para, 'LScale'),
        fileName = [imgName num2str(para.LScale.sigma*10) '.mat'];
        [wtL1, wtL2] = LoadWeightGradient(dxdy1, dxdy2, para.LScale, fileName);
    end
    
    if isfield(para, 'SScale'),
        fileName = [imgName num2str(para.SScale.sigma*10) '.mat'];
        [wtS1, wtS2] = LoadWeightGradient(dxdy1, dxdy2, para.SScale, fileName);
    else
        error('The scale must have the small scale');
    end
    
    % 
    if exist('wtL1', 'var'),
        % ------ Prune the parameter ------------
        wt1 = PruneWeights(wtL1, wtL2, wtS1, wtS2, para.Prune);
        ww1 = ordfilt2(wt1, 5, ones(3, 3));
        ww2 = 1 - ww1;
    else
        ww1 = wtS1 ./ (wtS1 + wtS2 +eps);
        ww2 = 1-ww1;
    end
    
    % Show
    if isfield(para.Prune, 'show') && para.Prune.show,
        ShowImageGrad(ww1);
    end
    
    %% ----------------- Recover the Image --------------------
    imgRec = zeros(size(img1));
    for ii = 1:size(img1, 3),
        [dx1, dy1] = GradientMethod(img1(:, :, ii), 'zhou'); 
        [dx2, dy2] = GradientMethod(img2(:, :, ii), 'zhou');
        
        dxdy1 = dx1+1i*dy1;
        dxdy2 = dx2+1i*dy2;
        dxdy = GradientMixWeightModify(dxdy1, dxdy2, ww1, ww2, para.Rec.modify);
        
        imgRec(:, :, ii) = RecoverByGraInitial(img1(:, :, ii), img2(:, :, ii), ww1, ww2, dxdy, para.Rec.iter, para.Rec.res, 0.1, para.Rec.iniMode);
    end
    
    %% 
    
    imgRec = min(imgRec, 255);
    imgRec = max(imgRec, 0);
    imgRec = round(imgRec);
end

