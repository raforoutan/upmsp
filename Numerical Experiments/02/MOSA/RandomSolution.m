function y=RandomSolution(Input)

I=Input.I;
J=Input.J;
B=Input.B;
F=Input.F;
alpha=Input.alpha;
lambda1=Input.lambda1;
lambda2=Input.lambda2;

%Creating a random permutation of jobs with no machine assignment
y=zeros(2,J);
perm=randperm(J);
for j=1:J
    y(1,j)=perm(1,j);
end

%Batch assignment

%Finding machines capable of processing each batch
nBatch=cell(1,B);
for b=1:B
    tempv1=[];
    nv=0;
    for j=1:J
        if lambda1(j,b)==1
            tempv1=[tempv1 alpha{j}];
            nv=nv+1;
        end
    end
    tempv2=zeros(1,I);
    for j=1:numel(tempv1)
        for i=1:I
            if tempv1(j)==i
                tempv2(i)=tempv2(i)+1;
            end
        end
    end
    tempv3=[];
    for i=1:I
        if tempv2(i)==nv
            tempv3(i)=i;
        else
            tempv3(i)=0;
        end
    end
    tempv3(tempv3<1)=[];
    nBatch{b}=tempv3;
end

%Selecting a machine for each batch
tempv4=zeros(1,B);
for b=1:B
    tempv4(b)=nBatch{b}(randi(numel(nBatch{b})));
end

%Assigning selected machines to batches
for b=1:B
    for j=1:J
        if lambda1(j,b)==1
            for i=1:numel(y(1,:))
                if y(1,i)==j
                    y(2,i)=tempv4(b);
                end
            end
        end
    end
end

%Job families assignment

%Finding machines capable of processing each job family
nFamily=cell(1,F);
for f=1:F
    tempv1=[];
    nv=0;
    for j=1:J
        if lambda2(j,f)==1
            tempv1=[tempv1 alpha{j}];
            nv=nv+1;
        end
    end
    tempv2=zeros(1,I);
    for j=1:numel(tempv1)
        for i=1:I
            if tempv1(j)==i
                tempv2(i)=tempv2(i)+1;
            end
        end
    end
    tempv3=[];
    for i=1:I
        if tempv2(i)==nv
            tempv3(i)=i;
        else
            tempv3(i)=0;
        end
    end
    tempv3(tempv3<1)=[];
    nFamily{f}=tempv3;
end

%Selecting a machine for each job family
tempv4=zeros(1,F);
for f=1:F
    tempv4(f)=nFamily{f}(randi(numel(nFamily{f})));
end

%Assigning selected machines to job families
for f=1:F
    for j=1:J
        if lambda2(j,f)==1
            for i=1:numel(y(1,:))
                if y(1,i)==j
                    y(2,i)=tempv4(f);
                end
            end
        end
    end
end

%Assigning machines to jobs that are not members of a batch or a job family
for j=1:J
    if y(2,j)==0
        tempv5=randi(numel(alpha{y(1,j)}));
        y(2,j)=alpha{y(1,j)}(tempv5);
    end
end

end
