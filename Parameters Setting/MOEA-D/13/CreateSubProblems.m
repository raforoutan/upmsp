function sp=CreateSubProblems(nObj,nPop,T)

    empty_sp.lambda=[];
    empty_sp.Neighbors=[];

    sp=repmat(empty_sp,nPop,1);
    
    %theta=linspace(0,pi/2,nPop);
    
    for i=1:nPop
        lambda=rand(nObj,1);
        lambda=lambda/norm(lambda);
        sp(i).lambda=lambda;
        
        %sp(i).lambda=[cos(theta(i))
        %              sin(theta(i))];
    end

    LAMBDA=[sp.lambda]';

    D=pdist2(LAMBDA,LAMBDA);

    for i=1:nPop
        [~, SO]=sort(D(i,:));
        sp(i).Neighbors=SO(1:T);
    end

end