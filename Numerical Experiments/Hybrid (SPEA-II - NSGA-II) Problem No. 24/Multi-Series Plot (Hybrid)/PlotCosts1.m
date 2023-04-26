function PlotCosts1()


        Input.spea2=load('spea2.mat');
        Input.nsga2=load('nsga2.mat');
        Input.hybrid=load('hybrid.mat');

        empty_individual.spea2=[];
        empty_individual.nsga2=[];
        empty_individual.hybrid=[];

        pop=repmat(empty_individual,80,1);
       

        temp5=[Input.spea2.Output.Paretolist2];
        for i=1:numel(temp5)
            pop(i).spea2=temp5{i};
        end
        qqq2=[pop.spea2];
        x=qqq2(1,:);
        y=qqq2(2,:);
%         z=qqq2(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        plot(x,y,'or','Markersize',5, 'marker' , 'o' , 'markeredgecolor','blue' , 'markerfacecolor','cyan');
%       plot3(EPC(1,:),EPC(2,:),EPC(3,:),'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
%         zlabel('f_3(x)');
        grid on
        hold on


        temp1=[Input.nsga2.Output.Paretolist2];
        for i=1:numel(temp1)
            pop(i).nsga2=temp1{i};
        end
        q=[pop.nsga2];
        x=q(1,:);
        y=q(2,:);
%         z=q(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '*' ,'markerfacecolor','green' , 'markeredgecolor','green');
        plot(x,y,'or','Markersize',5, 'marker' , 'o' , 'markeredgecolor','red' , 'markerfacecolor','yellow');
%       plot3(EPC(1,:),EPC(2,:),EPC(3,:),'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
%         zlabel('f_3(x)');
        grid on
        hold on

        temp2=[Input.hybrid.Output.Paretolist2];
        for i=1:numel(temp2)
            pop(i).hybrid=temp2{i};
        end
        qq=[pop.hybrid];
        x=qq(1,:);
        y=qq(2,:);
%         z=qq(3,:);
        %plot3(x,y,z,'or','Markersize',6,'markerfacecolor','blue');
        %plot3(x,y,z,'or','Markersize',12, 'marker' , 'o' ,'markerfacecolor','green' , 'markeredgecolor','red');
        plot(x,y,'or','Markersize',5, 'marker' , 'o' , 'markeredgecolor','#7E2F8E' , 'markerfacecolor','magenta');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
%         zlabel('f_3(x)');
        grid on
        hold off

        
end