% GradientMixWeightModify.m
% -------------------------------------------------------------------
% Date:    2/04/2013
% Last modified: 02/04/2013
% -------------------------------------------------------------------

function dxdy = GradientMixWeightModify(dxdy1, dxdy2, ww1, ww2, modify)

    % --------------- Parameter check ------------------
%     narginchk(4, 5);
%     if isreal(dxdy1) || isreal(dxdy2)
%         error('The gradient should be complex');
%     end
    % --------------------------------------------------
    
    
    dxdy = GradientMixWeight(dxdy1, dxdy2, ww1, ww2);
    
    if isempty(modify),
        disp('The mix Gradient have not the reference orientation');
        return;
    end
    
    % --------- Modify the Gradient -----
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
%%
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

%%
% ModifyOri.m
% -------------------------------------------------------------------
% POSTCOM = MODIFYORI(preCom, refCom);
% POSTCOM = MODIFYORI(preCom, refCom1, ww1, refCom2, ww2);
% POSICOM = MODIFYORI(preCom, refCom1, ww1, refCom2, ww2, refCom3, ww3);
% Authors: Sun Li
% Date:    17/03/2013
% Last modified: 23/03/2013
% -------------------------------------------------------------------

function postCom = ModifyOri(preCom, refCom1, varargin)

    if ~(nargin == 2 || mod(length(varargin), 2))
        error('The number of input is wrong');
    end

    refCom = refCom1;
    if ~isempty(varargin), 
        ww = varargin{1};
    end
    
    for ii = 3:2:length(varargin)
        wwtemp = varargin{ii};
        temp = ww >= wwtemp;
        
        refCom = temp.*refCom + (1-temp).*varargin{ii-1};
        ww = temp.*ww + (1-temp).*wwtemp; % Update the weights
    end
    
%     % The above test
%     aa = [1 2;3 4];
%     aa1 = [1 1;1 1]; ww1 = [1 2;3 4];
%     aa2 = [2 2;2 2]; ww2 = [1 3;2 4];
%     aa3 = [3 3;3 3]; ww3 = [1 2;4 3];
%     % dxdy = ModifyOri(aa, aa1);
%     dxdy = ModifyOri(aa, aa1, ww1, aa2, ww2, aa3, ww3);
%     The Output should be ww = [1 3;4 4] refCom = [1 2;3 1]
    % -------------------------------------
    if isreal(preCom) || isreal(refCom),
        error('The two varable should be complex');
    end

    ss = sign(real(preCom).*real(refCom) + imag(preCom).*imag(refCom) + eps);
    postCom = ss.*preCom;     
end