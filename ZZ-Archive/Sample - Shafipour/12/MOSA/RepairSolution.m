function Ynew=RepairSolution(y,input)

        Precedence=input.Precedence;
        J=input.J;
        
        Ynew=zeros(3,J);
        z=1;
        while ~isempty(y)
   
        for i=1:J
            if isempty(Precedence{y(1,i)})
            Ynew(:,z)=y(:,i);
            z=z+1;
            y=[y(:,1:i-1) y(:,i+1:end)];
            break;
            else
                k=Precedence{y(1,i)};
                a=intersect(Ynew(1,:),k);
                if numel(k)==numel(a)
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
end