function P=SelectFromPopulation(pop,grid,beta)

    sg=grid([grid.N]>0);

    p=1./[sg.N].^beta;
    p=p/sum(p);

    k=RouletteWheelSelection(p);

    Members=sg(k).Members;

    i=Members(randi([1 numel(Members)]));
    
    try
        P=pop(i);
    catch ex
        disp('*');
    end

end