clc;
clear;
close all;
tic;
%% Definition problem

Input=load('matlab');
Input=Input.model;
nvar=Input.J;

%% SA parameters

Maxit=200;        %maximume number of iteration
Maxsubit=25;       %maximume number of iteration
T0=100;            % number of temp
alpha=0.93;

Archive=[];
%% Initialization

sol.position=Randomsolution(Input);
sol.Z=Schedulingcost(sol.position,Input);

sol.N=[];       % number of individuals that dominance 'sol'       

Archive=[Archive sol];
% store temp
T=T0;


%% SA Main loop

for it=1:Maxit
    
   for subit1=1:Maxsubit
       
       %  create new solution 
       newsol.position=mutate(sol.position);
       newsol.Z=Schedulingcost(newsol.position,Input);
       Gsol=sum(log(sol.Z));
       Gnewsol=sum(log(newsol.Z));
       P=exp((-1/T) * (Gnewsol - Gsol));
       
       if rand<=P
          sol=newsol;
       end
       Archive=SaveStrategy(sol,Archive);
               
        t=numel(Archive);
        k=randsample(t,1);
        sol=Archive(k);
%             figure(1);
%             Plotsolution(Archive,it);
   end
      
   % update temp
    T=alpha*T;
    
    % show Non-dominated Solutions
    figure(1);
    Plotsolution(Archive,it);
end
toc;

% result
disp(['Number of Non-dominated Solutions = ' num2str(numel(Archive))]);






