% WeightGradient.m
% -------------------------------------------------------------------
% Authors: Sun Li
% Date:    2/04/2013
% Last modified: 18/04/2013
% -------------------------------------------------------------------
function [ww1, ww2, wt1, wt2] = WeightGradient(dxdy1, dxdy2, para)
    
    weiType = 'eigdecxq';
    sigma = 6;
    alpha = 0.5;
    % -------- Check the parameter -------------
    if isfield(para, 'weight'),
        weiType = para.weight;
    end
    if isfield(para, 'sigma'),
        sigma = para.sigma;
    end
    if isfield(para, 'alpha'),
        alpha = para.alpha;
    end
    % -----------------------------------------
    if strcmp(weiType, 'eigdecxq'),
%         disp('The weight will be equal eig decompose and the sqrt(s^2)');
        [~, cc1] = EigDecBlock(dxdy1, sigma);
        [~, cc2] = EigDecBlock(dxdy2, sigma);
        
        wt1 = sqrt((sqrt(cc1(1,:,:)+eps)+sqrt(cc1(2,:,:)+eps)).^2 + alpha*(sqrt(cc1(1,:,:)+eps)-sqrt(cc1(2,:,:)+eps)).^2+eps);
        wt1 = squeeze(wt1);
        wt2 = sqrt((sqrt(cc2(1,:,:)+eps)+sqrt(cc2(2,:,:)+eps)).^2 + alpha*(sqrt(cc2(1,:,:)+eps)-sqrt(cc2(2,:,:)+eps)).^2+eps);
        wt2 = squeeze(wt2);
        
        % normlaization
        ww1 = sqrt(wt1 ./ (wt1 +wt2+eps));
        ww2 = sqrt(wt2 ./ (wt1 +wt2+eps));
    else 
        disp('The weight will be equal 1');
        wt1 = ones(size(dxdy1));
        wt2 = ones(size(dxdy2));
        ww1 = ones(size(dxdy1));
        ww2 = ones(size(dxdy2));
    end
end