

Ynew=[];
np=NewPrecedency;
while ~isempty(y)
    for j=1:numel(y(1,:))
        if ~isempty(np{y(1,j)})
            continue;
        else
            Ynew=[Ynew y(:,j)];
            for z=1:J
               for i=1:numel(np{z}) 
                  if np{z}(i)==y(1,j)
                      np{z}(i)=[];
                      break;                     
                  end    
               end
            end
            y(:,j)=[];
            break;
        end
    end
end