% Parses the euv-materials spreadsheet into lists of materials, and index
% of refraction
%
% materials: cell array
% deltas, betas: regular arrays
function [materials, deltas, betas] = parseIndexFromDataFile(path)

[num, txt, raw] = xlsread(path, 'Sheet1', 'A1:C7');

[Nr, Nc] = size(raw);
counter = 0;

materials = {};
deltas = [];
betas = [];
for indexR = 1:Nr
    for indexC = 1:Nc
        
        counter = counter + 1;
        fprintf('indexC=%d, indexR=%d, counter=%d\n', indexC, indexR, counter);
        
        if (counter > 3 && mod(counter, 3) == 1)
            % Then the value is a material but not the literal word
            % "material"
            
            % add this to materials list
            materials{end + 1} = raw{indexR, indexC};
        end
        
       if (counter > 3 && mod(counter, 3) == 2)
            %Then, this is a "delta" but not the label delta
        
            % add this to the deltas list
            deltas(end + 1) = raw{indexR, indexC};
       end
        
       if (counter > 3 && mod(counter, 3) == 0)
            %Then, this is a "beta" but not the label beta
        
            % add this to the betas list
            betas(end + 1) = raw{indexR, indexC};
       end
    end
end
end







