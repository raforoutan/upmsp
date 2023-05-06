clc;
clear;
close all;
tic;

%% Problem Definition

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);

%% SPEA2 Settings

MaxIt=100;        % Maximum Number of Iterations

nPop=50;            % Population Size

nArchive=150;        % Archive Size

K=round(sqrt(nPop+nArchive));  % KNN Parameter

pCrossover=0.9;
nCrossover=round(pCrossover*nPop/2)*2;

pMutation=0.5;
nMutation=nPop-nCrossover;

Maxit=5;        %maximume number of iteration
Neighborsize=3;
Tabulistsize=2;

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.S=[];
empty_individual.R=[];
empty_individual.sigma=[];
empty_individual.sigmaK=[];
empty_individual.D=[];
empty_individual.F=[];

empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];
% 
% Tabulist=[];
% Candidatelist=[];
% Paretolist=[];

pop=repmat(empty_individual,nPop,1);
for i=1:nPop

    [Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
    CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
    pop(i).Position=Ynew;
    pop(i).Cost=CostFunction(pop(i).Position);

end

archive=[];
% [pop, F]=NonDominatedSorting(pop);
% 
% % Calculate Crowding Distance
% pop=CalcCrowdingDistance(pop,F);
% 
% % Sort Population
% [pop, F]=SortPopulation(pop);
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
    pop=[pop 
        popc
        popm];
     [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Truncate
    pop=pop(1:nPop);
    
    
    
    
    for i=1:numel(pop)
        
        Tabulist=[];
        Candidatelist=[];
        Paretolist=[];
        
        X.position=pop(i).Position;
        X.Z=pop(i).Cost;
        
        Tabulist=[Tabulist X];
        Paretolist=[Paretolist
                X];
        for it=1:Maxit
    
            % Neighbourhood Generation

            pop2=CreateNeighbor(X,Input,Tabulist,Neighborsize,NewPrecedency);


            % Identify Candidate Solutions

            [newCandidatelist,Updatelist]=CandidateSolutions(pop2,Paretolist,Candidatelist);
            Paretolist=Updatelist.P;
            Candidatelist=Updatelist.C;
            % Selection of new seed solution
            n=numel(newCandidatelist);
            if n==0
                  if numel(Candidatelist)==0
                      break;
                  end        
                Xnew=Candidatelist(1);

            % Update Pareto list
                Paretolist=[Paretolist
                                Xnew];  %#ok

             % Update taboo list   
                if numel(Tabulist)==Tabulistsize
                   Tabulist(end)=[]; 
                   Tabulist=[Xnew Tabulist];    %#ok
                else
                   Tabulist=[Xnew Tabulist];        %#ok
                end
             % Update candidate list
                Candidatelist=Candidatelist(2:end);

            else

                t=randi(n);
                Xnew=newCandidatelist(t);
             % Update Pareto list
                Paretolist=[Paretolist
                                Xnew]; %#ok
                % Update taboo
                if numel(Tabulist)==Tabulistsize
                   Tabulist(end)=[]; 
                   Tabulist=[Xnew Tabulist];        %#ok
                else
                   Tabulist=[Xnew Tabulist];        %#ok
                end
               % Update candidate list
               Candidatelist=[Candidatelist
                              newCandidatelist];    %#ok
                  if numel(Candidatelist)==0
                      break;
                  end
            end
            X=Xnew;
        end 
        cntr=randi(numel(Paretolist));
        X.position=Paretolist(cntr).position;
        X.Z=Paretolist(cntr).Z;
        
        
        tmp=Nondominate(X.Z,pop(i).Cost);
        
        if tmp
            pop(i).Position=X.position;
            pop(i).Cost=X.Z;
        end
    end
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Store F1
    F1=pop(F{1});
    
end
time=toc;

%% Results

Output=CreateOutput(PF);
Output.Time=time;
save('Hybrid' , 'Output');

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
