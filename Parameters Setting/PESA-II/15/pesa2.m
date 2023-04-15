clc;
clear;
close all;
tic;
%% Problem Definition

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);

%% PESA-II Settings

MaxIt=180;      % Maximum Number of Iterations

nPop=80;        % Population Size

nArchive=150;   % Archive Size

nGrid=20;       % Number of Grids per Dimension

InflationFactor=0.1;    % Grid Inflation

beta_deletion=1;
beta_selection=2;

pCrossover=0.5;
nCrossover=round(pCrossover*nPop/2)*2;

pMutation=0.3;
nMutation=nPop-nCrossover;

%  crossover_params.gamma=0.15;
% crossover_params.VarMin=VarMin;
% crossover_params.VarMax=VarMax;
% 
%  mutation_params.h=0.3;
% mutation_params.VarMin=VarMin;
% mutation_params.VarMax=VarMax;


%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.IsDominated=[];
empty_individual.GridIndex=[];

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
   
    pop=DetermineDomination(pop);
    
    ndpop=pop(~[pop.IsDominated]);
    
    archive=[archive
             ndpop];
    
    archive=DetermineDomination(archive);
    
    archive=archive(~[archive.IsDominated]);

    [archive, grid2]=CreateGrid(archive,nGrid,InflationFactor);
    
    if numel(archive)>nArchive
        E=numel(archive)-nArchive;
        archive=TruncatePopulation(archive,grid2,E,beta_deletion);
        [archive, grid2]=CreateGrid(archive,nGrid,InflationFactor);
    end
    
    PF=archive;
    PFC=[PF.Cost];
    
    figure(1);
    plot3(PFC(1,:),PFC(2,:),PFC(3,:),'x');
    xlabel('f_1(x)');
    ylabel('f_2(x)'); 
    zlabel('f_3(x)');
    title(['Iteration =' num2str(it)]);
    grid on
    
%     disp(['Iteration ' num2str(it) ': Number of PF Members = ' num2str(numel(PF))]);
    
    if it>=MaxIt
        break;
    end
    
    % Crossover
    popc=repmat(empty_individual,nCrossover/2,2);
    for c=1:nCrossover/2
        
        p1=SelectFromPopulation(archive,grid2,beta_selection);
        p2=SelectFromPopulation(archive,grid2,beta_selection);
        
        [popc(c,1).Position, popc(c,2).Position]=Crossover(p1.Position,...
                                                           p2.Position);%,...
                                                      %     crossover_params); 
        
        popc(c,1).Cost=SchedulingCost(popc(c,1).Position,NewPrecedency,Input);
        popc(c,2).Cost=SchedulingCost(popc(c,2).Position,NewPrecedency,Input);
        
    end
    popc=popc(:);
    
    % Mutation
    popm=repmat(empty_individual,nMutation,1);
    for m=1:nMutation
        
        p=SelectFromPopulation(archive,grid2,beta_selection);
        
        popm(m).Position=Mutate(p.Position);%,mutation_params);
        
        popm(m).Cost=SchedulingCost(popm(m).Position,NewPrecedency,Input);
        
    end
    
    pop=[popc
         popm];
         
end
time=toc;

%% Results

Output=CreateOutput(PF);
Output.Time=time;
save('pesa2' , 'Output');

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
