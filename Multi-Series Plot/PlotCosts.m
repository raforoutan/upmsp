function PlotCosts()

        Input.nsga2=load('nsga2.mat');
        Input.hybrid=load('hybrid.mat');
        Input.moead=load('moead.mat');

        empty_individual.bandb=[];
        empty_individual.nsga2=[];
        empty_individual.hybrid=[];
        empty_individual.moead=[];

        pop=repmat(empty_individual,4,1);

        temp0=cell(4,1);
        temp0{1}=[23;1.001666666666667e+02;1.808333333333333e+02];
        temp0{2}=[20.833333333333336;1.130000000000000e+02;1.325000000000000e+02];
        temp0{3}=[20.500000000000000;106;1.615000000000000e+02];
        %temp0{4}=[24.3334;13.6667;132.5000];
        for i=1:4
            pop(i).bandb=temp0{i};
        end
        q1=[pop.bandb];
        x=q1(1,:);
        y=q1(2,:);
        z=q1(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '*' ,'markerfacecolor','green' , 'markeredgecolor','green');
        plot3(x,y,z,'or','Markersize',25, 'marker' , 's' , 'markeredgecolor','magenta');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold on
        
        temp1=[Input.nsga2.Output.Paretolist2];
        for i=1:numel(temp1)
            pop(i).nsga2=temp1{i};
        end
        q=[pop.nsga2];
        x=q(1,:);
        y=q(2,:);
        z=q(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '*' ,'markerfacecolor','green' , 'markeredgecolor','green');
        plot3(x,y,z,'or','Markersize',15, 'marker' , '*' , 'markeredgecolor','green');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold on

        temp2=[Input.hybrid.Output.Paretolist2];
        for i=1:numel(temp2)
            pop(i).hybrid=temp2{i};
        end
        qq=[pop.hybrid];
        x=qq(1,:);
        y=qq(2,:);
        z=qq(3,:);
        %plot3(x,y,z,'or','Markersize',6,'markerfacecolor','blue');
        %plot3(x,y,z,'or','Markersize',12, 'marker' , 'o' ,'markerfacecolor','green' , 'markeredgecolor','red');
        plot3(x,y,z,'or','Markersize',15, 'marker' , 'o' , 'markeredgecolor','cyan');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold on

        temp3=[Input.moead.Output.Paretolist2];
        for i=1:numel(temp3)
            pop(i).moead=temp3{i};
        end
        qqq=[pop.moead];
        x=qqq(1,:);
        y=qqq(2,:);
        z=qqq(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        plot3(x,y,z,'or','Markersize',15, 'marker' , '^' , 'markeredgecolor','blue');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold off
        
end