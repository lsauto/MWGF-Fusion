% LoadWeightGradient.m
% -------------------------------------------------------------------
% Date:    17/04/2013
% Last modified: 18/04/2013
% -------------------------------------------------------------------

function [wt1, wt2] = LoadWeightGradient(dxdy1, dxdy2, para, fileName)

    dir = '.\temp\';
    fileName = strcat(dir, fileName);
    if exist(fileName, 'file'),
        S = load(fileName);
        wt1 = S.wt1;
        wt2 = S.wt2;
    else
        [~, ~, wt1, wt2] = WeightGradient(dxdy1, dxdy2, para);
%         save(fileName, 'wt1', 'wt2');
    end
end