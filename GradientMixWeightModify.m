% GradientMixWeightModify.m
% -------------------------------------------------------------------
% Date:    2/04/2013
% Last modified: 02/04/2013
% -------------------------------------------------------------------

function dxdy = GradientMixWeightModify(dxdy1, dxdy2, ww1, ww2, modify)

    % --------------- Parameter check ------------------
    narginchk(4, 5);
    if isreal(dxdy1) || isreal(dxdy2)
        error('The gradient should be complex');
    end
    % --------------------------------------------------
    
    
    dxdy = GradientMixWeight(dxdy1, dxdy2, ww1, ww2);
    
    if isempty(modify),
        disp('The mix Gradient have not the reference orientation');
        return;
    end
    
    % --------- Modify the Gradient 
    switch(modify)
        case 1,
            disp('Using the Gradient 1 as the reference');
            dxdy = ModifyOri(dxdy, dxdy1);
        case 2,
            disp('Using the Gradient 2 as the reference');
            dxdy = ModifyOri(dxdy, dxdy2);
        case 3,
            disp('Using the Gradient 1 and 2 as the reference');
            dxdy = ModifyOri(dxdy, dxdy1, ww1, dxdy2, ww2);
        case 4,
            disp('Using the average Gradient 1 and 2 as the reference');
            dxdy = ModifyOri(dxdy, dxdy1+dxdy2);
        case 5,
%             disp('Using the areage Gradient 1 and 2 add the weights as the reference');
            dxdy = ModifyOri(dxdy, ww1.*dxdy1 + ww2.*dxdy2);
        otherwise
            disp('Not modify the OutputGradient');
    end
    
    
end