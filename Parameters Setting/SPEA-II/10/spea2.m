clc;
clear;
close all;
tic;

%% Problem Definition

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);


%% SPEA2 Settings

MaxIt=150;        % Maximum Number of Iterations

nPop=50;            % Population Size

nArchive=250;        % Archive Size

K=round(sqrt(nPop+nArchive));  % KNN Parameter

pCrossover=0.8;
nCrossover=round(pCrossover*nPop/2)*2;

pMutation=0.2;
nMutation=nPop-nCrossover;

crossover_params.gamma=0.1;
% crossover_params.VarMin=VarMin;
% crossover_params.VarMax=VarMax;

mutation_params.h=0.2;
% mutation_params.VarMin=VarMin;
% mutation_params.VarMax=VarMax;

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.S=[];
empty_individual.R=[];
empty_individual.sigma=[];
empty_individual.sigmaK=[];
empty_individual.D=[];
empty_individual.F=[];

pop=repmat(empty_individual,nPop,1);
for i=1:nPop

    [Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
    CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
    pop(i).Position=Ynew;
    pop(i).Cost=CostFunction(pop(i).Position);

end

archive=[];

%% Main Loop

for it=1:MaxIt
    
    Q=[pop
       archive];
    
    nQ=numel(Q);
    
    dom=false(nQ,nQ);
    
    for i=1:nQ
        Q(i).S=0;
    end
    
    for i=1:nQ
        for j=i+1:nQ
            
            if Dominates(Q(i),Q(j))
                Q(i).S=Q(i).S+1;
                dom(i,j)=true;
                
            elseif Dominates(Q(j),Q(i))
                Q(j).S=Q(j).S+1;
                dom(j,i)=true;
                
            end
            
        end
    end
    
    S=[Q.S];
    for i=1:nQ
        Q(i).R=sum(S(dom(:,i)));
    end
    
    Z=[Q.Cost]';
    SIGMA=pdist2(Z,Z,'seuclidean');
    SIGMA=sort(SIGMA);
    for i=1:nQ
        Q(i).sigma=SIGMA(:,i);
        Q(i).sigmaK=Q(i).sigma(K);
        Q(i).D=1/(Q(i).sigmaK+2);
        Q(i).F=Q(i).R+Q(i).D;
    end
    
    nND=sum([Q.R]==0);
    if nND<=nArchive
        F=[Q.F];
        [F, SO]=sort(F);
        Q=Q(SO);
        archive=Q(1:min(nArchive,nQ));
        
    else
        SIGMA=SIGMA(:,[Q.R]==0);
        archive=Q([Q.R]==0);
        
        k=2;
        while numel(archive)>nArchive
            while min(SIGMA(k,:))==max(SIGMA(k,:)) && k<size(SIGMA,1)
                k=k+1;
            end
            
            [~, j]=min(SIGMA(k,:));
            
            archive(j)=[];
            SIGMA(:,j)=[];
        end
        
    end
    
    PF=archive([archive.R]==0); % Approximate Pareto Front
    PFC=[PF.Cost];
    
    % Plot Pareto Front
    figure(1);
    plot3(PFC(1,:),PFC(2,:),PFC(3,:),'x');
    xlabel('f_1(x)');
    ylabel('f_2(x)'); 
    zlabel('f_3(x)');
    title(['Iteration =' num2str(it)]);
    grid on
    
    % Display Iteration Information
%     disp(['Iteration ' num2str(it) ': Number of PF members = ' num2str(numel(PF))]);
    
    if it>=MaxIt
        break;
    end
    
    % Crossover
    popc=repmat(empty_individual,nCrossover/2,2);
    for c=1:nCrossover/2
        
        p1=BinaryTournamentSelection(archive,[archive.F]);
        p2=BinaryTournamentSelection(archive,[archive.F]);
        
        [popc(c,1).Position, popc(c,2).Position]=Crossover(p1.Position,p2.Position);%,crossover_params);

        popc(c,1).Cost=SchedulingCost(popc(c,1).Position,NewPrecedency,Input);
        popc(c,2).Cost=SchedulingCost(popc(c,2).Position,NewPrecedency,Input);
        
    end
    popc=popc(:);
    
    % Mutation
    popm=repmat(empty_individual,nMutation,1);
    for m=1:nMutation
        
        p=BinaryTournamentSelection(archive,[archive.F]);
        
        popm(m).Position=Mutate(p.Position);%,mutation_params);
        
        popm(m).Cost=SchedulingCost(popm(m).Position,NewPrecedency,Input);
        
    end
    
    % Create New Population
    pop=[popc
         popm];
    
end
time=toc;

%% Results

Output=CreateOutput(PF);
Output.Time=time;
save('spea2' , 'Output');

disp(['Time = ' ...
    num2str(Output.Time)]);
disp(['NPS = ' ...
    num2str(Output.NPS)]);
disp(['MID = ' ...
    num2str(Output.MID)]);
disp(['DM = ' ...
    num2str(Output.DM)]);
disp(['SNS = ' ...
    num2str(Output.SNS)]);
disp(['RAS = ' ...
    num2str(Output.RAS)]);
disp(['RAS2 = ' ...
    num2str(Output.RAS2)]);
