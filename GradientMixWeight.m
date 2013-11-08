% GradientMixWeight.m
% -------------------------------------------------------------------
% Date:    2/04/2013
% Last modified: 04/11/2013
% -------------------------------------------------------------------
function dxdy = GradientMixWeight(dxdy1, dxdy2, ww1, ww2)
    
    % Check the parameter ----------------
    if isreal(dxdy1) || isreal(dxdy2),
        error('The input should be complexed');
    end
    if ~exist('ww1', 'var'),
        ww1 = ones(size(dxdy1));
        ww2 = ones(size(dxdy2));
    end
    % -------------------------------------
    dx1 = real(dxdy1); dy1 = imag(dxdy1);
    dx2 = real(dxdy2); dy2 = imag(dxdy2);
    
    dxdy = zeros(size(dxdy1));
%     disp('Start Mix Gradient:');
    for ii = 1+1:size(dxdy1, 1)-1,
        for jj = 1+1:size(dxdy1, 2)-1,
            g = [dx1(ii, jj) dy1(ii, jj);dx2(ii, jj), dy2(ii, jj)] ...
                .* repmat([ww1(ii, jj); ww2(ii, jj)], [1 2]);
            
            [V, D] = eig(g'*g); % find a bug in max_eig
            
            dxdy(ii, jj) = sqrt(D(2, 2)) * (V(1,2) + 1i*V(2, 2));
        end
%         fprintf('.');
%         if ~mod(ii, 30),
%             fprintf('\n');
%         end
    end
%     fprintf('\n');
    
end