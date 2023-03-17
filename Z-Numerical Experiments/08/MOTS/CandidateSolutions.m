function [Popnew,Updatelist]=CandidateSolutions(pop,Paretolist,Candidatelist)

        J=numel(pop);
        P=numel(Paretolist);
        Archive=[pop
                 Paretolist
                 Candidatelist];
        t=numel(Archive);

        Popnew=[];
        N=zeros(1,t);        % dominate Counter

         for i=1:J
            for j=i+1:t              
               if all(Archive(i).cost<=Archive(j).cost)&& any(Archive(i).cost<Archive(j).cost) % if i dominated j
                  N(j)=N(j)+1;
               elseif all(Archive(j).cost<=Archive(i).cost)&& any(Archive(j).cost<Archive(i).cost)  % if j dominated i
                  N(i)=N(i)+1;
               end
            end
           if N(i)==0
              Popnew=[Popnew
                      Archive(i)];  %#ok
           end
         end
           
         Updatelist.P=[];       % Update of Pareto List
         Updatelist.C=[];       % Update of Candidate List
       for q=J+1:t
        if q<=J+P        % If the list is Pareto
          if N(q)==0
             Updatelist.P=[Updatelist.P
                           Archive(q)]; 
          end
        else

          if N(q)==0
             Updatelist.C=[Updatelist.C
                           Archive(q)]; 
          end
        end            
           
       end
end