% ParaLoad.m
% -------------------------------------------------------------------
% Date:    27/04/2013
% Last modified: 29/10/2013
% ------------------------------------------------------------------- 

function para = ParaLoad(imgName)

    % ------------- the Large Scale ---------
    para.LScale.sigma = 4;
    para.LScale.alpha = 0.5;
    % ----------- the Small Scale -----------
    para.SScale.sigma = 0.5;
    para.SScale.alpha = 0.5;
    % -------------- the prune parameter -------------
    para.Prune.per = 0.1;
    para.Prune.show = 1;
    % ------------- the recover parameter -----------
    para.Rec.iter = 1000;
    para.Rec.res = 1e-6;
    para.Rec.modify = 5;
    para.Rec.iniMode = 'weight';   
end