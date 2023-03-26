function y=Crossover(x1,x2)

    METHOD=randi([1,2]);
    
    switch METHOD
        
        case 1
            
            y=SinglePointCrossover(x1,x2);
            
        case 2
            
            y=DoublePointCrossover(x1,x2);
    end 
end