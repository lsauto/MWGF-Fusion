% DeleteLine.m(delete the thin area)
% -------------------------------------------------------------------
% 
% Date:    30/10/2013
% Last modified: 30/10/2013
% -------------------------------------------------------------------
function mm = DeleteLine(nn)
    for ii = 1:size(nn,2),
%         t = nn(:, ii);
%         bt = [0;nn(1:end-1,ii)];
%         afind = find(t-bt, 2, 'first');
%         if numel(afind) == 2 && afind(2)-afind(1)<8,
%             nn(afind(1):afind(2), ii) = 0;
%         end
%         
%         bt = [nn(2:end, ii);0];
%         afind = find(t-bt, 2, 'last');
%         if numel(afind) == 2 && afind(2)-afind(1)<8,
%             nn(afind(1):afind(2), ii) = 0;
%         end
        
        befind = find(nn(:, ii), 1, 'first');
        afind = find(~nn(:, ii), 1, 'first');
        if and(befind == 1, afind < 13),
            nn(befind:afind, ii) = 0;
        end
        
        befind = find(nn(:, ii), 1, 'last');
        afind = find(~nn(:, ii), 1, 'last');
        if and(befind == size(nn,1), befind-afind< 13),
            nn(afind:befind, ii) = 0;
        end 

    end
    
    for ii = 1:size(nn,1),        
        befind = find(nn(ii, :), 1, 'first');
        afind = find(~nn(ii, :), 1, 'first');
        if and(befind == 1, afind < 13),
            nn(ii, befind:afind) = 0;
        end
        
        befind = find(nn(ii, :), 1, 'last');
        afind = find(~nn(ii, :), 1, 'last');
        if and(befind == size(nn,2), befind-afind < 13),
            nn(ii, afind:befind) = 0;
        end 
    end
    
    mm = nn;
end