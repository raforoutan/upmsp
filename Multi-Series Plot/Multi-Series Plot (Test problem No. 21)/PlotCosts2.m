function PlotCosts2()

        Input.nsga2=load('nsga2.mat');
        Input.hybrid=load('hybrid.mat');
        Input.moead=load('moead.mat');
        Input.pesa2=load('pesa2.mat');
        Input.spea2=load('spea2.mat');

        empty_individual.bandb=[];
        empty_individual.moead=[];
        empty_individual.nsga2=[];
        empty_individual.pesa2=[];
        empty_individual.spea2=[];
        empty_individual.hybrid=[];
        
        pop=repmat(empty_individual,80,1);
        
        temp1=[Input.nsga2.Output.Paretolist2];
        for i=1:numel(temp1)
            pop(i).nsga2=temp1{i};
        end
        q=[pop.nsga2];
        x=q(1,:);
%         y=q(2,:);
        z=q(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '*' ,'markerfacecolor','green' , 'markeredgecolor','green');
        plot(x,z,'or','Markersize',5, 'marker' , 'o' , 'markeredgecolor','red' , 'markerfacecolor','yellow');
%       plot3(EPC(1,:),EPC(2,:),EPC(3,:),'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_3(x)');
%         ylabel('f_2(x)'); 
        grid on
        hold on

%         temp2=[Input.hybrid.Output.Paretolist2];
%         for i=1:numel(temp2)
%             pop(i).hybrid=temp2{i};
%         end
%         qq=[pop.hybrid];
%         x=qq(1,:);
%         y=qq(2,:);
%         z=qq(3,:);
%         %plot3(x,y,z,'or','Markersize',6,'markerfacecolor','blue');
%         %plot3(x,y,z,'or','Markersize',12, 'marker' , 'o' ,'markerfacecolor','green' , 'markeredgecolor','red');
%         plot3(x,y,z,'or','Markersize',15, 'marker' , 'o' , 'markeredgecolor','cyan');
%         title(['Iteration =' 100]);
%         xlabel('f_1(x)');
%         ylabel('f_2(x)'); 
%         zlabel('f_3(x)');
%         grid on
%         hold on

%         temp3=[Input.moead.Output.Paretolist2];
%         for i=1:numel(temp3)
%             pop(i).moead=temp3{i};
%         end
%         qqq=[pop.moead];
%         x=qqq(1,:);
%         y=qqq(2,:);
%         z=qqq(3,:);
%         %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
%         plot3(x,y,z,'or','Markersize',15, 'marker' , '^' , 'markeredgecolor','blue');
%         title(['Iteration =' 100]);
%         xlabel('f_1(x)');
%         ylabel('f_2(x)'); 
%         zlabel('f_3(x)');
%         grid on
%         hold on
        
        temp4=[Input.pesa2.Output.Paretolist2];
        for i=1:numel(temp4)
            pop(i).pesa2=temp4{i};
        end
        qqq1=[pop.pesa2];
        x=qqq1(1,:);
%         y=qqq1(2,:);
        z=qqq1(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        plot(x,z,'or','Markersize',5, 'marker' , 'o' , 'markeredgecolor','#7E2F8E' , 'markerfacecolor','magenta');
%       plot3(EPC(1,:),EPC(2,:),EPC(3,:),'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_3(x)');
%         ylabel('f_2(x)'); 
        grid on
        hold on


        temp5=[Input.spea2.Output.Paretolist2];
        for i=1:numel(temp5)
            pop(i).spea2=temp5{i};
        end
        qqq2=[pop.spea2];
        x=qqq2(1,:);
%         y=qqq2(2,:);
        z=qqq2(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        plot(x,z,'or','Markersize',5, 'marker' , 'o' , 'markeredgecolor','blue' , 'markerfacecolor','cyan');
%       plot3(EPC(1,:),EPC(2,:),EPC(3,:),'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_3(x)');
%         ylabel('f_2(x)'); 
        grid on
        hold off


        
end