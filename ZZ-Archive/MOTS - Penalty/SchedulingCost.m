function [Z] = SchedulingCost(y,NewPrecedency,Input)

T=Input.T;
I=Input.I;
J=Input.J;
beta=Input.beta;
FF=Input.FF;
tau=Input.tau;
M=Input.M;

%Creating an empty matrix for scheduling (Matrix Schedule)
Schedule=zeros(3,J);
T2=zeros(I,J);
for i=1:I
    for j=1:J
        T2(i,j)=T(j)/beta(i,j);
    end
end

%Adding duration to matrix Schedule
for j=1:J
    Schedule(2,j)=T2(y(2,j),y(1,j));
end

Smat=[0 0 ; 0 Inf ; 0 0];   %Scheduling matrix
Smat=repmat(Smat,1,I+1);
Smat(:,numel(Smat(1,:)))=[];

div_c=zeros(1,I+1);   %Divider counter
for i=1:numel(div_c)
    div_c(i)=(i*2)-1;
end

for j=1:J   %Assign Process for the Job (j) without precedency
    if isempty(NewPrecedency{y(1,j)})
        for w=div_c(y(2,j))+1:div_c(y(2,j)+1)-1   %Find its place according to its machine
            if Smat(3,w)==0 && Smat(2,w)-Smat(1,w)>=Schedule(2,j)   %The first empty spot it fitts
                Smat(2,w)=Smat(1,w)+Schedule(2,j); %Assign finish time in Smat
                Smat(3,w)=1;   %Change empty status to ocupied
                Schedule(1,j)=Smat(1,w);
                Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
                if Smat(1,w+1)>0   % There is/are job(s) after that
                    if Smat(1,w+1)~=Smat(2,w)   % Not immidiately after job (j)
                    Smat=[Smat(:,1:w) [Smat(2,w);Smat(1,w+1);0] Smat(:,w+1:end)];
                    for m=1:numel(div_c)
                        if div_c(m)>w
                            div_c(m)=div_c(m)+1;
                        end
                    end
                    end     
                else
                    Smat=[Smat(:,1:w) [Smat(2,w);Inf;0] Smat(:,w+1:end)];   %Add an emopty column to Smat
                    for m=1:numel(div_c)
                        if div_c(m)>w
                            div_c(m)=div_c(m)+1;
                        end
                    end
                end
                break
            end
        end
    else
        %Assign Process for the Job (j) with precedency
        temp6=zeros(1,numel(NewPrecedency{y(1,j)}));
        for z=1:numel(NewPrecedency{y(1,j)})
            for zz=1:J
                if y(1,zz)==NewPrecedency{y(1,j)}(z)
                    temp6(z)=Schedule(3,zz);
                    %The earliest possible time to start job (j) considering precedency restrictions
                end
            end
        end
        temp6=max(temp6); 
        for n=div_c(y(2,j))+1:div_c(y(2,j)+1)-1   %Find its place according to its machine
            if Smat(3,n)==0 && Smat(2,n)-Smat(1,n)>=Schedule(2,j) && Smat(2,n)>temp6   %The first empty spot it fitts that ends after temp6 
                if Smat(1,n)<temp6 && Smat(2,n)-temp6>=Schedule(2,j)   %Starts before temp6 and fitts
                    Smat=[Smat(:,1:n) [temp6;temp6+Schedule(2,j);1] Smat(:,n+1:end)]; %Assignment process starts from temp6 + %Assign finish time in Smat + %Change empty status to ocupied
                    for m=1:numel(div_c)
                        if div_c(m)>n
                            div_c(m)=div_c(m)+1;
                        end
                    end                    
                    Smat(2,n)=temp6; %Correction of empty spot before assignment
                    Schedule(1,j)=Smat(1,n+1);
                    Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
                    if Smat(1,n+2)>0   % There is/are job(s) after that
                        if Smat(1,n+2)~=Smat(2,n+1)   % Not immidiately after job (j)
                        Smat=[Smat(:,1:n+1) [Smat(2,n+1);Smat(1,n+2);0] Smat(:,n+2:end)];
                        for m=1:numel(div_c)
                            if div_c(m)>n
                                div_c(m)=div_c(m)+1;
                            end
                        end
                        end     
                    else
                        Smat=[Smat(:,1:n+1) [Smat(2,n+1);Inf;0] Smat(:,n+2:end)];   %Add an emopty column to Smat
                        for m=1:numel(div_c)
                            if div_c(m)>n
                                div_c(m)=div_c(m)+1;
                            end
                        end
                    end        
                else
                    Smat(2,n)=Smat(1,n)+Schedule(2,j); %Assign finish time in Smat
                    Smat(3,n)=1;   %Change empty status to ocupied
                    Schedule(1,j)=Smat(1,n);
                    Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
                    if Smat(1,n+1)>0   % There is/are job(s) after that
                        if Smat(1,n+1)~=Smat(2,n)   % Not immidiately after job (j)
                        Smat=[Smat(:,1:n) [Smat(2,n);Smat(1,n+1);0] Smat(:,n+1:end)];
                        for m=1:numel(div_c)
                            if div_c(m)>n
                                div_c(m)=div_c(m)+1;
                            end
                        end
                        end     
                    else
                        Smat=[Smat(:,1:n) [Smat(2,n);Inf;0] Smat(:,n+1:end)];   %Add an emopty column to Smat
                        for m=1:numel(div_c)
                            if div_c(m)>n
                                div_c(m)=div_c(m)+1;
                            end
                        end
                    end
                end
                break
            end
        end      
    end
end

Z0=0;
for j=1:J
    if ~isempty(NewPrecedency{y(1,j)})
        for z=1:numel(NewPrecedency{y(1,j)})
            for zz=1:J
                if y(1,zz)==NewPrecedency{y(1,j)}(z)
                    if zz>j
                        Z0=Z0+M;
                    end
                end
            end
        
        end
    
    end  
end

Z1=max(Schedule(3,:))+Z0;   %First objective
Z2=sum(Schedule(3,:));   %Second objective

dom=zeros(1,I);   %Duration of machines
for i=1:I
    for j=1:J
        if y(2,j)==i
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

