
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

Smat=[0 0 ; 0 Inf ; 0 0];   %Scheduling matrix
Smat=repmat(Smat,1,I+1);
Smat(:,numel(Smat(1,:)))=[];

div_c=zeros(1,I+1);   %Divider counter
for i=1:numel(div_c)
    div_c(i)=(i*2)-1;
end

for j=1:J
    if ~isempty(NewPrecedency{x(1,j)})
        %Assign Process for the Predessesors (zz) without precedency
        for z=1:numel(NewPrecedency{x(1,j)})
            for zz=1:J
                if x(1,zz)==NewPrecedency{x(1,j)}(z)
                    if Schedule(3,zz)==0
                        for k=div_c(x(2,zz))+1:div_c(x(2,zz)+1)-1
                            if Smat(3,k)==0 && Smat(2,k)-Smat(1,k)>=Schedule(2,zz)
                                Smat(2,k)=Smat(1,k)+Schedule(2,zz);
                                Smat(3,k)=1;
                                Smat=[Smat(:,1:k) [Smat(2,k);Inf;0] Smat(:,k+1:end)];
                                for m=1:numel(div_c)
                                    if div_c(m)>k
                                        div_c(m)=div_c(m)+1;
                                    end
                                end
                                Schedule(1,zz)=Smat(1,k);
                                Schedule(3,zz)=Schedule(1,zz)+Schedule(2,zz);
                                break
                            end
                        end
                    end
                end
            end
        end
        %Assign Process for the Job (j) with precedency
        for n=div_c(x(2,j))+1:div_c(x(2,j)+1)-1
            if Smat(3,n)==0 && Smat(2,n)-Smat(1,n)>=Schedule(2,j)
                temp6=Smat(1,n);   %The first available slot in which job (j) fits
                break
            end
        end
        temp7=zeros(1,numel(NewPrecedency{x(1,j)}));
        for z=1:numel(NewPrecedency{x(1,j)})
            for zz=1:J
                if x(1,zz)==NewPrecedency{x(1,j)}(z)
                    temp7(z)=Schedule(3,zz);
                    %The earliest possible time to start job (j) considering precedency restrictions
                end
            end
        end
        temp7=max(temp7);
        temp8=max(temp6,temp7);   %Earliest possible start time of job (j)
        for n=div_c(x(2,j))+1:div_c(x(2,j)+1)-1
            if Smat(3,n)==0 && Smat(2,n)-Smat(1,n)>=Schedule(2,j)
                if Smat(2,n-1)>=temp8   %job can be started right after that
                    Smat(2,n)=Smat(1,n)+Schedule(2,j);
                    Smat(3,n)=1;
                    Smat=[Smat(:,1:n) [Smat(2,n);Inf;0] Smat(:,n+1:end)];
                    for m=1:numel(div_c)
                        if div_c(m)>n
                            div_c(m)=div_c(m)+1;
                        end
                    end
                    Schedule(1,j)=Smat(1,n);
                    Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
                else   %job needs to be transfered to temp8
                    Smat(2,n)=temp8;
                    Smat=[Smat(:,1:n) [Smat(2,n);Inf;0] Smat(:,n+1:end)];
                    Smat(2,n+1)=Smat(1,n+1)+Schedule(2,j);
                    Smat(3,n+1)=1;
                    Smat=[Smat(:,1:n+1) [Smat(2,n+1);Inf;0] Smat(:,n+2:end)];
                    for m=1:numel(div_c)
                        if div_c(m)>n
                            div_c(m)=div_c(m)+2;
                        end
                    end
                    Schedule(1,j)=Smat(1,n+1);
                    Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
                end
                break
            end
        end 
    else
        for w=div_c(x(2,j))+1:div_c(x(2,j)+1)-1
            if Smat(3,w)==0 && Smat(2,w)-Smat(1,w)>=Schedule(2,j)
                Smat(2,w)=Smat(1,w)+Schedule(2,j);
                Smat(3,w)=1;
                Smat=[Smat(:,1:w) [Smat(2,w);Inf;0] Smat(:,w+1:end)];
                if Smat(2,w+1)==Inf && Smat(2,w+2)>0
                    Smat(2,w+1)=Smat(1,w+2);
                end
                for m=1:numel(div_c)
                    if div_c(m)>w
                        div_c(m)=div_c(m)+1;
                    end
                end
                Schedule(1,j)=Smat(1,w);
                Schedule(3,j)=Schedule(1,j)+Schedule(2,j);
                break
            end
        end
        
    end
end
