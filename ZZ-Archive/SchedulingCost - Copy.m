function [Z] = SchedulingCost(x,NewPrecedency,Input)

T=Input.T;
I=Input.I;
J=Input.J;
beta=Input.beta;
FF=Input.FF;
tau=Input.tau;

%Creating an empty matrix for scheduling (Matrix Schedule)
x=RepairSolution(x,Input);
Schedule=zeros(3,J);
T2=zeros(I,J);
for i=1:I
    for j=1:J
        T2(i,j)=T(j)/beta(i,j);
    end
end

%Adding duration to matrix Schedule
for j=1:J
    Schedule(2,j)=T2(x(2,j),x(1,j));
end

% %Earliest available start time on machines
% east=zeros(1,I);
% 
% %Scheuling
% for j=1:J
%     if isempty(NewPrecedency{x(1,j)})
%         Schedule(1,j)=east(x(2,j));
%     else
%         temp6=zeros(1,numel(NewPrecedency{x(1,j)}));
%         for z=1:J
%             if ismember(x(1,z),NewPrecedency{x(1,j)})
%                 temp6(x(1,z))=Schedule(3,z);
%             end
%         end
%         
%         Schedule(1,j)=max(max(temp6),east(x(2,j)));
%     end
%     Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
%     east(x(2,j))=east(x(2,j))+Schedule(2,j);
% end       

%Calculating objective values
Z1=max(Schedule(3,:));   %First objective
Z2=sum(Schedule(3,:));   %Second objective

dom=zeros(1,I);   %Duration of machines
for i=1:I
    for j=1:J
        if x(2,j)==i
            dom(i)=dom(i)+Schedule(2,j);
        end
    end
end
Z31=0;
Z32=0;
for i=1:I
    if dom(i)>0
        Z31=Z31+FF(i);
    end
end
for i=1:I
    Z32=Z32+(tau(i)*dom(i));
end
Z3=Z31+Z32;   %Third objective

Z=[Z1 Z2 Z3]';
% Z=Z1+Z2+Z3;   %Sum of objectives

end

