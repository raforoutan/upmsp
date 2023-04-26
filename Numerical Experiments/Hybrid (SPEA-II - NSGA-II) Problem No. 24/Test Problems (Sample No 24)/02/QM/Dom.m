function QM=Dom()

Input.spea2=load('spea2.mat');
Input.nsga2=load('nsga2.mat');
Input.hybrid=load('hybrid.mat');

paretofront.spea2=[];
paretofront.nsga2=[];
paretofront.hybrid=[];

numrows=[];
numrows=[numrows , numel(Input.spea2.Output.Paretolist2), numel(Input.nsga2.Output.Paretolist2), numel(Input.hybrid.Output.Paretolist2)];
cnumrows=cumsum(numrows);
mnumrows=max(numrows);

paretolist=repmat(paretofront,mnumrows,1);
for i=1:numel(Input.spea2.Output.Paretolist2)
    paretolist(i).spea2=Input.spea2.Output.Paretolist2{i};
end
for i=1:numel(Input.nsga2.Output.Paretolist2)
    paretolist(i).nsga2=Input.nsga2.Output.Paretolist2{i};
end
for i=1:numel(Input.hybrid.Output.Paretolist2)
    paretolist(i).hybrid=Input.hybrid.Output.Paretolist2{i};
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
    pop(i).Cost=paretolist(i).spea2;
end
for i=cnumrows(1)+1:cnumrows(2)
    pop(i).Algorithm=2;
    pop(i).Cost=paretolist(i-cnumrows(1)).nsga2;
end
for i=cnumrows(2)+1:cnumrows(3)
    pop(i).Algorithm=3;
    pop(i).Cost=paretolist(i-cnumrows(2)).hybrid;
end

[pop , F]=NonDominatedSorting(pop);
pop=CalcCrowdingDistance(pop,F);
[pop, ~]=SortPopulation(pop);

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

qspea2=0;
qnsga2=0;
qhybrid=0;

for i=1:numel(qualitymat)
    if qualitymat(i)==1
        qspea2=qspea2+1;
    elseif qualitymat(i)==2
        qnsga2=qnsga2+1;
    else
        qhybrid=qhybrid+1;
    end
end

qmspea2=qspea2/cnumrows(1);
qmnsga2=qnsga2/(cnumrows(2)-cnumrows(1));
qmhybrid=qhybrid/(cnumrows(3)-cnumrows(2));

QM.qmspea2=qmspea2;
QM.qmnsga2=qmnsga2;
QM.qmhybrid=qmhybrid;

end