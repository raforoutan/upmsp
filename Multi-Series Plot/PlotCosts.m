function PlotCosts()

        Input.nsga2=load('nsga2.mat');
        Input.hybrid=load('hybrid.mat');
        Input.moead=load('moead.mat');

        empty_individual.nsga2=[];
        empty_individual.hybrid=[];
        empty_individual.moead=[];

        pop=repmat(empty_individual,3,1);

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
        plot3(x,y,z,'or','Markersize',15, 'marker' , 'o' , 'markeredgecolor','red');
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