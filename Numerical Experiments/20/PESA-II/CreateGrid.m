function [pop, grid2]=CreateGrid(pop,nGrid,InflationFactor)

    z=[pop.Cost]';
    
    zmin=min(z);
    zmax=max(z);
    
    dz=zmax-zmin;
    alpha=InflationFactor/2;
    zmin=zmin-alpha*dz;
    zmax=zmax+alpha*dz;
    
    nObj=numel(zmin);
    
    C=zeros(nObj,nGrid+3);
    for j=1:nObj
        C(j,:)=[-inf linspace(zmin(j),zmax(j),nGrid+1) inf];
    end
    
    empty_grid2.LB=[];
    empty_grid2.UB=[];
    empty_grid2.Index=[];
    empty_grid2.SubIndex=[];
    empty_grid2.N=0;
    empty_grid2.Members=[];
    
    nG=(nGrid+2)^nObj;
    
    GridSize=(nGrid+2)*ones(1,nObj);
    
    grid2=repmat(empty_grid2,nG,1);
    for k=1:nG
        SubIndex=cell(1,nObj);
        [SubIndex{:}]=ind2sub(GridSize,k);
        SubIndex=cell2mat(SubIndex);

        grid2(k).Index=k;
        grid2(k).SubIndex=SubIndex;
        
        grid2(k).LB=zeros(nObj,1);
        grid2(k).UB=zeros(nObj,1);
        for j=1:nObj
            grid2(k).LB(j)=C(j,SubIndex(j));
            grid2(k).UB(j)=C(j,SubIndex(j)+1);
        end
        
    end

    [pop, grid2]=FindPositionInGrid(pop,grid2);
    
end