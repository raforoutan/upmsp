function pop=CreateNeighbor(x,Input,Tabulist,Neighborsize)


        pop=[];
        n=0;
        while numel(pop)<Neighborsize
            
%            rs=randsample(2,1);
%         switch rs
%              case 1
                    [Ynew , NewPrecedency]=RepairSolution(Mutate(x.position),Input);
%              case 2
%                     [Ynew , NewPrecedency]=RepairSolution(Crossover(x.position,x.position),Input);
%         end 

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
                pop=[pop
                     Xnew];
            end
           end
            n=0;
        end
end