function [Ynew , NewPrecedency]=RepairSolution(y,Input)

J=Input.J;
B=Input.B;
lambda1=Input.lambda1;
Precedency=Input.Precedency;

%Converting batch members into a cell
Batches=cell(1,B);
 for b=1:B
     for j=1:J
         if lambda1(j,b)==1
             Batches{b}=[Batches{b} j];
         end
     end
 end

%Defining NewPrecedency (including batch precedency)
NewPrecedency=Precedency;
for j=1:J
     if numel(Precedency{j})~=0   %Has a predecessor? -> YES
         for i=1:numel(Precedency{j})
             for e=1:B
                 for f=1:numel(Batches{e})
                     if Precedency{j}(i)==Batches{e}(f)   %From a batch? -> YES
                         if ismember(j,Batches{e})==0  %From different batches? -> YES 
                             NewPrecedency{j}=[NewPrecedency{j} Batches{e}];
                             NewPrecedency{j}=unique(NewPrecedency{j});
                         end
                     end
                 end
             end
         end
     end
end

%Repairing chromosome using NewPrecedency 
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
% Ynew=zeros(2,J);
% z=1;
% while ~isempty(y)
%     for i=1:J
%         if isempty(NewPrecedency{y(1,i)})
%             Ynew(:,z)=y(:,i);
%             z=z+1;
%             y=[y(:,1:i-1) y(:,i+1:end)];
%             break;
%         else
%             p=NewPrecedency{y(1,i)};   %Pishniyazi kar ra entekhab mikonad
%             a=intersect(Ynew(1,:),p);   %Eshteraake Pishniyazi ba takhsise jadid ra hesab mikonad 
%             if numel(p)==numel(a)   %Zamani mosavi mishavad ke hameye azaaye Pishniyazi dar takhsis bashand
%                 Ynew(:,z)=y(:,i);
%                 z=z+1;
%                 y=[y(:,1:i-1) y(:,i+1:end)];
%                 break;
%             else
%                 continue;
%             end
%         end
%     end
% end
end