function Ynew=RepairSolution(y,input)

        Precedence=Input.Precedence;
        J=Input.J;
        
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
                    k=Precedence{y(1,i)};   %Pishniyazi kar ra entekhab mikonad
                    a=intersect(Ynew(1,:),k);   %Eshteraake Pishniyazi ba takhsise jadid ra hesab mikonad  
                    if numel(k)==numel(a)   %Zamani mosavi mishavad ke hameye azaaye Pishniyazi dar takhsis bashand
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