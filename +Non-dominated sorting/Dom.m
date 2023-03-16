function QM=Dom()

Input.nsga2=load('nsga2.mat');
Input.mosa=load('mosa.mat');
Input.mots=load('mots.mat');

paretofront.nsga2=[];
paretofront.mosa=[];
paretofront.mots=[];

numrows=[];
numrows=[numrows , numel(Input.nsga2.Output.Paretolist2) numel(Input.mosa.Output.Paretolist2), numel(Input.mots.Output.Paretolist2)];
cnumrows=cumsum(numrows);
mnumrows=max(numrows);

paretolist=repmat(paretofront,mnumrows,1);
for i=1:numel(Input.nsga2.Output.Paretolist2)
    paretolist(i).nsga2=Input.nsga2.Output.Paretolist2{i};
end
for i=1:numel(Input.mosa.Output.Paretolist2)
    paretolist(i).mosa=Input.mosa.Output.Paretolist2{i};
end
for i=1:numel(Input.mots.Output.Paretolist2)
    paretolist(i).mots=Input.mots.Output.Paretolist2{i};
end

empty_individual.Algorithm=[];
empty_individual.Cost=[];
empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];

pop=repmat(empty_individual,cnumrows(end),1);

for i=1:cnumrows(1)
    pop(i).Algorithm=1;
    pop(i).Cost=paretolist(i).nsga2;
end
for i=cnumrows(1)+1:cnumrows(2)
    pop(i).Algorithm=2;
    pop(i).Cost=paretolist(i-cnumrows(1)).mosa;
end
for i=cnumrows(2)+1:cnumrows(3)
    pop(i).Algorithm=3;
    pop(i).Cost=paretolist(i-cnumrows(2)).mots;
end

cntr=0;
for i=1:numel(pop)
    if pop(i).Rank==1
        cntr=cntr+1;
    end
end
qualitymat=zeros(1,cntr);
cntr2=1;
for i=1:numel(pop)
    if pop(i).Rank==1
        qualitymat(cntr2)=pop(i).Algorithm;
        cntr2=cntr2+1;
    end
end

qnsga2=0;
qmosa=0;
qmots=0;
for i=1:numel(qualitymat)
    if qualitymat(i)==1
        qnsga2=qnsga2+1;
    elseif qualitymat(i)==2
        qmosa=qmosa+1;
    else
        qmots=qmots+1;
    end
end

qmnsga2=qnsga2/cnumrows(1);
qmmosa=qmosa/(cnumrows(2)-cnumrows(1));
qmmots=qmots/(cnumrows(3)-cnumrows(2));

QM.qmnsga2=qmnsga2;
QM.qmmosa=qmmosa;
QM.qmmots=qmmots;

end