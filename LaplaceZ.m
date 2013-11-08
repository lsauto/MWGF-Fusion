% LaplaceZ.m
% -------------------------------------------------------------------
% 
% Authors: Sun Li
% Date:    28/03/2013
% Last modified: 31/03/2013
% -------------------------------------------------------------------
function lap = LaplaceZ(IMGORGRA)

    if isreal(IMGORGRA),
%         disp('The input should be IMAGE')
        lh=[0,  1, 0;...
            1, -4, 1;...
            0,  1, 0];
        lap = imfilter(IMGORGRA, lh, 'replicate', 'corr');
    else
%         disp('The input should be GRADIENT');
        fx=[0, 0, 0; 0, -1, 1; 0, 0, 0];
        fy=[0, 0, 0;  0, -1, 0; 0, 1, 0];

        dx = real(IMGORGRA);
        dy = imag(IMGORGRA);

        ddx = imfilter(dx, fx, 0, 'corr');
        ddy = imfilter(dy, fy, 0, 'corr');

        lap=ddx + ddy;
    end
end