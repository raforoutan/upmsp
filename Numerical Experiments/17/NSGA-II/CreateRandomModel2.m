function Input=CreateRandomModel2()

I=8;
J=40;

 B1=round(J/(randi([3,5],1)));   %Number of jobs belonging to batches
% if J<=20
%     weights=[1 2];
% elseif J<=50
%     weights=[1 2 3];
% else
%     weights=[1 2 3 4];
% end
% accumulation=cumsum(weights); %Roulette wheel selection algorithm
% p=rand()*accumulation(end);
% chosen_index=-1;
% for index=1:length(accumulation)
%     if (accumulation(index)>p)
%         chosen_index=index;
%         break;
%     end
% end
B=3;   %Number of batches
if B==1
    b1=cell(1,1);
    b1{1}=zeros(1,B1);
else
    least=B*2;
    b1=cell(B,1);
    for i=1:B
        b1{i}=zeros(1,2);
    end
    B2=B1-least;
    for i=1:B2
        rr=randi(B);
        b1{rr}(end+1)=0;
    end
end
rem=(1:J);
for i=1:B
    for j=1:numel(b1{i})
        b3=randi(numel(rem));
        b1{i}(j)=rem(b3);
        rem(b3)=[];
    end
    b1{i}=sort(b1{i});
end
lambda1=zeros(J,B);
for b=1:B
    for j=1:numel(b1{b})
        lambda1(b1{b}(j),b)=1;   %Membership of a batch
    end
end



 F1=round((J-B1)/(randi([2,3],1)));   %Number of jobs belonging to job families
% if J<=20
%     weights=[1 2];
% elseif J<=50
%     weights=[1 2 3];
% else
%     weights=[1 2 3 4];
% end
% accumulation=cumsum(weights); %Roulette wheel selection algorithm
% p=rand()*accumulation(end);
% chosen_index=-1;
% for index=1:length(accumulation)
%     if (accumulation(index)>p)
%         chosen_index=index;
%         break;
%     end
% end
F=2;   %Number of batches
if F==1
    f1=cell(1,1);
    f1{1}=zeros(1,F1);
else
    least=F*2;
    f1=cell(F,1);
    for i=1:F
        f1{i}=zeros(1,2);
    end
    F2=F1-least;
    for i=1:F2
        rr=randi(F);
        f1{rr}(end+1)=0;
    end
end
for i=1:F
    for j=1:numel(f1{i})
        f3=randi(numel(rem));
        f1{i}(j)=rem(f3);
        rem(f3)=[];
    end
    f1{i}=sort(f1{i});
end
lambda2=zeros(J,F);
for f=1:F
    for j=1:numel(f1{f})
        lambda2(f1{f}(j),f)=1;   %Membership of a job family
    end
end



alpha=cell(J,1);   %Machine eligibility
for j=1:J
    for r1=1:randi(I)
    alpha{j}(r1)=0;
    end    
end
for j=1:J
   if  numel(alpha{j})==1
      r2=randi([0,1]);
      if r2
          alpha{j}=[0,0];
      end
   end
end
for b=1:B
    r3=randi(I);
    for j=1:numel(b1{b})
        alpha{b1{b}(j)}(1)=r3;
    end
end
for f=1:F
    r3=randi(I);
    for j=1:numel(f1{f})
        alpha{f1{f}(j)}(1)=r3;
    end
end
for j=1:J
    for i=1:numel(alpha{j})
        if alpha{j}(1)==0
            alpha{j}(1)=randi(I);
        end
    end
end
for j=1:J
    if numel(alpha{j})>1
        for i=2:numel(alpha{j})
            r4=alpha{j}((alpha{j})>0);
            r5=setdiff(1:I,r4);
            r6=r5(randi(numel(r5)));
            alpha{j}(i)=r6;   %Machine eligibility matrix     
        end
        alpha{j}=sort(alpha{j});
    end  
end



beta=zeros(I,J);
for i=1:I
    for j=1:J
        r7=randi(3);
        if r7==1
            beta(i,j)=1;
        elseif r7==2
            beta(i,j)=1.5;
        else
            beta(i,j)=2;   %Speed of machines for each job         
        end
    end
end



T=zeros(1,J);
weights=[1 2 3 4 5 4 3 2 1];
for j=1:J
    accumulation=cumsum(weights); %Roulette wheel selection algorithm
    p=rand()*accumulation(end);
    chosen_index=-1;
    for index=1:length(accumulation)
        if (accumulation(index)>p)
            chosen_index=index;
            break;
        end
    end
    r8=chosen_index;
    T(j)=r8;   %Processing time of jobs
end



beta1=cumsum(beta,2);
FF=zeros(1,I);
speed=zeros(1,I);
for i=1:I
    speed(i)=beta1(i,end);
end
r9=max(speed);
for i=1:I
    speed(i)=speed(i)/r9;   %Speed index
end
weights=[3 2 1];   %Quality index
for i=1:I
    accumulation=cumsum(weights); %Roulette wheel selection algorithm
    p=rand()*accumulation(end);
    chosen_index=-1;
    for index=1:length(accumulation)
        if (accumulation(index)>p)
            chosen_index=index;
            break;
        end
    end
    r10=chosen_index;
    FF(i)=round(5*r10+5*speed(i));   %Fixed cost of machines (a combination of Speed and Quality indices)
end



tau=zeros(1,I);
for i=1:I
    tau(i)=round(FF(i)/5);   %Variable cost of machines   
end



Precedency=cell(J,1);   %Generating precedence constraints
P1=(randi([4,6],1))/10;   %Percentage of jobs with precedency
P2=round(J*P1);   %Number of jobs with precedency
weights=flip(1:1:J-1);
for j=1:numel(weights)
   weights(j)=weights(j)^4; 
end
rem2=1:J;
r11=zeros(1,P2);
for i=1:P2
    r11(i)=rem2(randi(numel(rem2)));
    rem2=rem2(rem2~=r11(i));
end
r11=sort(r11);   %Jobs with precedency
r12=zeros(1,P2);
for i=1:P2
    accumulation=cumsum(weights); %Roulette wheel selection algorithm
    p=rand()*accumulation(end);
    chosen_index=-1;
    for index=1:length(accumulation)
        if (accumulation(index)>p)
            chosen_index=index;
            break;
        end
    end
    r13=chosen_index;
    r12(i)=r13;   %Number of predecessors for elements of r11
end
for j=1:J
    for i=1:P2
        if r11(i)==j
            rem3=1:J;
            rem3=rem3(rem3~=j);
            for z=1:r12(i)
                Precedency{j}(z)=rem3(randi(numel(rem3)));
                rem3=rem3(rem3~=Precedency{j}(z));
            end
            break
        end
    end
end

for j=1:J  %Prevente loops in precedence constraints
    Precedency2=[];
    for i=1:numel(Precedency{j})
        if Precedency{j}(i)<j
            Precedency2=[Precedency2 Precedency{j}(i)];
        end
    end
    Precedency{j}=Precedency2;
end

% for j=1:J   %Prevente loops in precedence constraints (LOOPS WITH MORE THAN 2 JOB CANNOT BE FIND)
%    if numel(Precedency{j})>0
%        for i=1:numel(Precedency{j})
%            for z=1:numel(Precedency{Precedency{j}(i)})
%                if Precedency{Precedency{j}(i)}(z)==j
%                    Precedency{Precedency{j}(i)}(z)=[];
%                    break
%                end
%            end
%        end
%    end   
% end


% for j=1:J
%     if numel(Precedency{j})>round(J/3)
%         Precedency{j}=Precedency{j}(1,1:round(J/3));   %Shortening elements of Precedency
%     end
% end



M=1000000;   %An arbitrary large number (not used in the meta algorithms; just in Lingo)
K=J;  %Number of positions (not used in the meta algorithms; just in Lingo)



Input.alpha=alpha;
Input.lambda1=lambda1;
Input.lambda2=lambda2;
Input.beta=beta;
Input.I=I;
Input.J=J;
Input.B=B;
Input.F=F;
Input.K=K;
Input.T=T;
Input.FF=FF;
Input.tau=tau;
Input.M=M;
Input.Precedency=Precedency;

save('matlab' , 'alpha','lambda1' , 'lambda2' , 'beta' , 'I' , 'J' , 'B' , 'F' , 'K' , 'T' , 'FF' , 'tau' , 'M', 'Precedency');

end

