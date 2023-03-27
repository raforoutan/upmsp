function QM=Dom()

Input.one=load('01.mat');
Input.two=load('02.mat');
Input.three=load('03.mat');
Input.four=load('04.mat');
Input.five=load('05.mat');
Input.six=load('06.mat');
Input.seven=load('07.mat');
Input.eight=load('08.mat');
Input.nine=load('09.mat');
Input.ten=load('10.mat');
Input.eleven=load('11.mat');
Input.twelve=load('12.mat');
Input.thirteen=load('13.mat');
Input.fourteen=load('14.mat');
Input.fifteen=load('15.mat');
Input.sixteen=load('16.mat');

paretofront.one=[];
paretofront.two=[];
paretofront.three=[];
paretofront.four=[];
paretofront.five=[];
paretofront.six=[];
paretofront.seven=[];
paretofront.eight=[];
paretofront.nine=[];
paretofront.ten=[];
paretofront.eleven=[];
paretofront.twelve=[];
paretofront.thirteen=[];
paretofront.fourteen=[];
paretofront.fifteen=[];
paretofront.sixteen=[];

numrows=[];
numrows=[numrows , numel(Input.one.Output.Paretolist2)
                   numel(Input.two.Output.Paretolist2)
                   numel(Input.three.Output.Paretolist2)
                   numel(Input.four.Output.Paretolist2)
                   numel(Input.five.Output.Paretolist2)
                   numel(Input.six.Output.Paretolist2)
                   numel(Input.seven.Output.Paretolist2)
                   numel(Input.eight.Output.Paretolist2)
                   numel(Input.nine.Output.Paretolist2)
                   numel(Input.ten.Output.Paretolist2)
                   numel(Input.eleven.Output.Paretolist2)
                   numel(Input.twelve.Output.Paretolist2)
                   numel(Input.thirteen.Output.Paretolist2)
                   numel(Input.fourteen.Output.Paretolist2)
                   numel(Input.fifteen.Output.Paretolist2)
                   numel(Input.sixteen.Output.Paretolist2)];

cnumrows=cumsum(numrows);
mnumrows=max(numrows);

paretolist=repmat(paretofront,mnumrows,1);
for i=1:numel(Input.one.Output.Paretolist2)
    paretolist(i).one=Input.one.Output.Paretolist2{i};
end
for i=1:numel(Input.two.Output.Paretolist2)
    paretolist(i).two=Input.two.Output.Paretolist2{i};
end
for i=1:numel(Input.three.Output.Paretolist2)
    paretolist(i).three=Input.three.Output.Paretolist2{i};
end
for i=1:numel(Input.four.Output.Paretolist2)
    paretolist(i).four=Input.four.Output.Paretolist2{i};
end
for i=1:numel(Input.five.Output.Paretolist2)
    paretolist(i).five=Input.five.Output.Paretolist2{i};
end
for i=1:numel(Input.six.Output.Paretolist2)
    paretolist(i).six=Input.six.Output.Paretolist2{i};
end
for i=1:numel(Input.seven.Output.Paretolist2)
    paretolist(i).seven=Input.seven.Output.Paretolist2{i};
end
for i=1:numel(Input.eight.Output.Paretolist2)
    paretolist(i).eight=Input.eight.Output.Paretolist2{i};
end
for i=1:numel(Input.nine.Output.Paretolist2)
    paretolist(i).nine=Input.nine.Output.Paretolist2{i};
end
for i=1:numel(Input.ten.Output.Paretolist2)
    paretolist(i).ten=Input.ten.Output.Paretolist2{i};
end
for i=1:numel(Input.eleven.Output.Paretolist2)
    paretolist(i).eleven=Input.eleven.Output.Paretolist2{i};
end
for i=1:numel(Input.twelve.Output.Paretolist2)
    paretolist(i).twelve=Input.twelve.Output.Paretolist2{i};
end
for i=1:numel(Input.thirteen.Output.Paretolist2)
    paretolist(i).thirteen=Input.thirteen.Output.Paretolist2{i};
end
for i=1:numel(Input.fourteen.Output.Paretolist2)
    paretolist(i).fourteen=Input.fourteen.Output.Paretolist2{i};
end
for i=1:numel(Input.fifteen.Output.Paretolist2)
    paretolist(i).fifteen=Input.fifteen.Output.Paretolist2{i};
end
for i=1:numel(Input.sixteen.Output.Paretolist2)
    paretolist(i).sixteen=Input.sixteen.Output.Paretolist2{i};
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
    pop(i).Cost=paretolist(i).one;
end

for i=cnumrows(1)+1:cnumrows(2)
    pop(i).Algorithm=2;
    pop(i).Cost=paretolist(i-cnumrows(1)).two;
end
for i=cnumrows(2)+1:cnumrows(3)
    pop(i).Algorithm=3;
    pop(i).Cost=paretolist(i-cnumrows(2)).three;
end
for i=cnumrows(3)+1:cnumrows(4)
    pop(i).Algorithm=4;
    pop(i).Cost=paretolist(i-cnumrows(3)).four;
end
for i=cnumrows(4)+1:cnumrows(5)
    pop(i).Algorithm=5;
    pop(i).Cost=paretolist(i-cnumrows(4)).five;
end
for i=cnumrows(5)+1:cnumrows(6)
    pop(i).Algorithm=6;
    pop(i).Cost=paretolist(i-cnumrows(5)).six;
end
for i=cnumrows(6)+1:cnumrows(7)
    pop(i).Algorithm=7;
    pop(i).Cost=paretolist(i-cnumrows(6)).seven;
end
for i=cnumrows(7)+1:cnumrows(8)
    pop(i).Algorithm=8;
    pop(i).Cost=paretolist(i-cnumrows(7)).eight;
end
for i=cnumrows(8)+1:cnumrows(9)
    pop(i).Algorithm=9;
    pop(i).Cost=paretolist(i-cnumrows(8)).nine;
end
for i=cnumrows(9)+1:cnumrows(10)
    pop(i).Algorithm=10;
    pop(i).Cost=paretolist(i-cnumrows(9)).ten;
end
for i=cnumrows(10)+1:cnumrows(11)
    pop(i).Algorithm=11;
    pop(i).Cost=paretolist(i-cnumrows(10)).eleven;
end
for i=cnumrows(11)+1:cnumrows(12)
    pop(i).Algorithm=12;
    pop(i).Cost=paretolist(i-cnumrows(11)).twelve;
end
for i=cnumrows(12)+1:cnumrows(13)
    pop(i).Algorithm=13;
    pop(i).Cost=paretolist(i-cnumrows(12)).thirteen;
end
for i=cnumrows(13)+1:cnumrows(14)
    pop(i).Algorithm=14;
    pop(i).Cost=paretolist(i-cnumrows(13)).fourteen;
end
for i=cnumrows(14)+1:cnumrows(15)
    pop(i).Algorithm=15;
    pop(i).Cost=paretolist(i-cnumrows(14)).fifteen;
end
for i=cnumrows(15)+1:cnumrows(16)
    pop(i).Algorithm=16;
    pop(i).Cost=paretolist(i-cnumrows(15)).sixteen;
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

qone=0;
qtwo=0;
qthree=0;
qfour=0;
qfive=0;
qsix=0;
qseven=0;
qeight=0;
qnine=0;
qten=0;
qeleven=0;
qtwelve=0;
qthirteen=0;
qfourteen=0;
qfifteen=0;
qsixteen=0;

for i=1:numel(qualitymat)
    if qualitymat(i)==1
        qone=qone+1;
    elseif qualitymat(i)==2
        qtwo=qtwo+1;
    elseif qualitymat(i)==3
        qthree=qthree+1;
    elseif qualitymat(i)==4
        qfour=qfour+1;
    elseif qualitymat(i)==5
        qfive=qfive+1;
    elseif qualitymat(i)==6
    qsix=qsix+1;
    elseif qualitymat(i)==7
    qseven=qseven+1;
    elseif qualitymat(i)==8
    qeight=qeight+1;
    elseif qualitymat(i)==9
    qnine=qnine+1;
    elseif qualitymat(i)==10
    qten=qten+1;
    elseif qualitymat(i)==11
    qeleven=qeleven+1;
    elseif qualitymat(i)==12
    qtwelve=qtwelve+1;
    elseif qualitymat(i)==13
    qthirteen=qthirteen+1;
    elseif qualitymat(i)==14
    qfourteen=qfourteen+1;
    elseif qualitymat(i)==15
    qfifteen=qfifteen+1;
    else
    qsixteen=qsixteen+1;
    end
end

qmone=qone/cnumrows(1);
qmtwo=qtwo/(cnumrows(2)-cnumrows(1));
qmthree=qthree/(cnumrows(3)-cnumrows(2));
qmfour=qfour/(cnumrows(4)-cnumrows(3));
qmfive=qfive/(cnumrows(5)-cnumrows(4));
qmsix=qsix/(cnumrows(6)-cnumrows(5));
qmseven=qseven/(cnumrows(7)-cnumrows(6));
qmeight=qeight/(cnumrows(8)-cnumrows(7));
qmnine=qnine/(cnumrows(9)-cnumrows(8));
qmten=qten/(cnumrows(10)-cnumrows(9));
qmeleven=qeleven/(cnumrows(11)-cnumrows(10));
qmtwelve=qtwelve/(cnumrows(12)-cnumrows(11));
qmthirteen=qthirteen/(cnumrows(13)-cnumrows(12));
qmfourteen=qfourteen/(cnumrows(14)-cnumrows(13));
qmfifteen=qfifteen/(cnumrows(15)-cnumrows(14));
qmsixteen=qsixteen/(cnumrows(16)-cnumrows(15));



QM.qmnsga2=qmnsga2;
QM.qmhybrid=qmhybrid;
QM.qmmoead=qmmoead;

end