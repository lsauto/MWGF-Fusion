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