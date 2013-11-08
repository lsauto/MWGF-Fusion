% EigDecBlock.m
% -------------------------------------------------------------------
% 
% Date:    12/03/2013
% Last modified: 30/04/2013
% -------------------------------------------------------------------

function [postMap, ss] = EigDecBlock(img, sigma)

    winSize = ceil(sigma*6);
    if ~mod(winSize, 2),
        winSize = winSize + 1;
    end
    
    h = fspecial('gauss', [winSize winSize], sigma);
    
    win = floor(winSize/2);
    [hh, ww] = size(img); 
    imgPad = padarray(img, [win win], 'symmetric', 'both');
    
    postMap = zeros(hh, ww);
    ss = zeros(2, hh, ww);
%     disp('The Eig Decompose:');
    for ii = 1:hh,
        for jj = 1:ww,
            patch = imgPad(ii:ii+winSize-1, jj:jj+winSize-1);
            dx = real(patch(:));
            dy = imag(patch(:));
            
            C = [sum(dx.*dx.*h(:)), sum(dx.*dy.*h(:));...
                 sum(dy.*dx.*h(:)), sum(dy.*dy.*h(:))];

            [V, D] = eig(C);
            
            postMap(ii, jj) = sqrt(D(2, 2)) * (V(1,2) + 1i*V(2, 2));   
            ss(:, ii, jj) = [abs(D(2, 2)) abs(D(1, 1))];
        end
%         fprintf('.');
%         if ~mod(ii, 30),
%             fprintf('\n');
%         end
    end
%     fprintf('\n');

%    postMap(1:win, :) = 0;
%    postMap(end-win+1:end, :) = 0;
%    postMap(:, 1:win) = 0;
%    postMap(:, end-win+1:end) = 0;
   
end