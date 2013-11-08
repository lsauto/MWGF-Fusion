% RecoverByGra.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    17/03/2013
% Last modified: 31/03/2013
% -------------------------------------------------------------------

function [imgRec, rms, gObj] = RecoverByGra(imgOri, Obj, iter, res, alpha)

    lp = [0 1 0;1 -4 1;0 1 0];
    if isreal(Obj),
%         disp('The original is the Laplace');
        gObj = Obj;
    else
%         disp('The original is the Gradient');
        gObj = LaplaceZ(Obj);
    end
    

%     f0 = Boundary(imgOri, dxObj, dyObj);
    f0 = imgOri;
    for ii = 1:iter,
%         f0 = Boundary(f0, dxObj, dyObj);
        deltaF = imfilter(f0, lp, 'replicate', 'corr');
        delta = alpha * (deltaF-gObj);

        f1 = f0 + delta;

        f1 = max(f1, 0);
        f1 = min(f1, 255);

        rms=fRMS(f1, f0);
%         disp(['The ' num2str(ii) 'iteration rms = ' num2str(rms)]);
        
%         if rms < res,
%             break;
%         end

        f0 = f1;  
    end
    
%     imgRec = Boundary(f1, dxObj, dyObj);
    imgRec = f1;
end