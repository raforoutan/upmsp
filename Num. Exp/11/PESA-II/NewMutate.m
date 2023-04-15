function q=NewMutate(x)

        Input=CreateInput;
        J=Input.J;
        I=Input.I;
        B=Input.B;
        F=Input.F;
        lambda1=Input.lambda1;
        lambda2=Input.lambda2;
        alpha=Input.alpha;
        
        n=numel(x(1,:));
        r=randsample(n,1);
        
        q=x;
        key=zeros(2,J);
        for j=1:J
            key(1,j)=q(1,j);
        end
        
        for j=1:J
            for b=1:B
                if lambda1(q(1,j),b)==1
                    key(2,j)=1;
                end
            end
        end
        
        for j=1:J
            for f=1:F
                if lambda2(q(1,j),f)==1
                    key(2,j)=2;
                end
            end
        end  

        if key(2,r)==1
            nBatch=0;
            for b=1:B
                if lambda1(key(1,r),b)==1 
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
                    nBatch=tempv3;
                    for i=1:numel(nBatch)
                        if nBatch(i)==q(2,r)
                            nBatch(i)=0;
                        end
                    end
                    nBatch(nBatch==0)=[];
                    if numel(nBatch)>0
                        tempv4=0;
                        tempv4=nBatch(randi(numel(nBatch)));
                        for j=1:J
                            for zz=1:J
                                if lambda1(j,b)==1 && q(1,zz)==j
                                q(2,zz)=tempv4;    
                                end
                            end
                        end
                    end
                end
            end
        elseif key(2,r)==2
            nFmaily=0;
            for f=1:F
                if lambda2(key(1,r),f)==1
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
                    nFamily=tempv3;
                    for i=1:numel(nFmaily)
                        if nFmaily(i)==q(2,r)
                            nFmaily(i)=0;
                        end
                    end
                    nFmaily(nFmaily==0)=[];
                    if numel(nFmaily)>0
                        tempv4=0;
                        tempv4=nFmaily(randi(numel(nFmaily)));
                        for j=1:J
                            for zz=1:J
                                if lambda2(j,f)==1 && q(1,zz)==j
                                q(2,zz)=tempv4;    
                                end
                            end
                        end
                    end
                end
            end
        else
            nNorm=alpha(key(1,r));
            nNormMat=cell2mat(nNorm); 
            if numel(nNormMat)>1
                for i=1:numel(nNormMat)
                    if nNormMat(i)==q(2,r)
                        nNormMat(i)=0;
                    end
                end
                nNormMat(nNormMat==0)=[];
                if numel(nNormMat)>0
                    tempv4=0;
                    tempv4=nNormMat(randi(numel(nNormMat)));
                    q(2,r)=tempv4;
                end      
            end    
        end

end