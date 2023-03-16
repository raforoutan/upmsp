
Ynew=zeros(2,J);
z=1;
while ~isempty(y)
    for i=1:J
        if isempty(NewPrecedency{y(1,i)})
            Ynew(:,z)=y(:,i);
            z=z+1;
            y=[y(:,1:i-1) y(:,i+1:end)];
            break;
        else
            p=NewPrecedency{y(1,i)};   
            a=intersect(Ynew(1,:),p);    
            if numel(p)==numel(a)   
                Ynew(:,z)=y(:,i);
                z=z+1;
                y=[y(:,1:i-1) y(:,i+1:end)];
                break;
            else
                continue;
            end
        end
    end
end