function Y=CreateNeighbor(x,Tabulist,Neighborsize,Input)


        Y=[];
        n=0;
        while numel(Y)<Neighborsize
            
           [Ynew , NewPrecedency]=RepairSolution(Mutate(x.position),Input); 
           Xnew.position=Ynew; 
           %Xnew.position=Mutate(x.position);            % Create new solution
           Xnew.cost=SchedulingCost(Xnew.position,NewPrecedency,Input);
           
           Q=Nondominate(Xnew.cost,x.cost);
           if Q
            for j=1:numel(Tabulist)
                   q=Xnew.position;
                   f=Tabulist(j).position;
                  k=find(q==f);
                  if numel(k)==numel(x.position)
                      n=n+1;
                      break;
                  end 
            end
            if n==0
%                 pop=[pop
                     Y=Xnew;
            end
%            end
            n=0;
           end
        end
end