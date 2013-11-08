% RecoverByGraInitial.m 
% RecoverByGra.m
% -------------------------------------------------------------------
% This function is just the joint of RecoverByGra and initial f0
% Authors: Sun Li
% Date:    17/03/2013
% Last modified: 31/03/2013
% -------------------------------------------------------------------

function [imgRec, rms, gObj] = RecoverByGraInitial(img1, img2, ww1, ww2, dxdy, iter, res, alpha, iniMode)

    % ------------ Check parameter --------------
    narginchk(9, 9);
    if size(img1, 3) ~=1 || size(img2, 3) ~=1,
        error('The image should be gray');
    end
    % -------------------------------------------
    switch lower(iniMode),
        case 'avg',
            f0 = (img1+img2)/2;
        case 'weight',
            f0 = ww1.*img1+ww2.*img2;
        otherwise
            error('There only two mode');
    end
    
    [imgRec, rms, gObj] = RecoverByGra(f0, dxdy, iter, res, alpha);
    
end