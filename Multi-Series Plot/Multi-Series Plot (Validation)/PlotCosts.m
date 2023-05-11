function PlotCosts()

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
        
        pop=repmat(empty_individual,4,1);

        temp0=cell(4,1);
        temp0{1}=[23;1.001666666666667e+02;1.808333333333333e+02];
        temp0{2}=[20.833333333333336;1.130000000000000e+02;1.325000000000000e+02];
        temp0{3}=[20.500000000000000;106;1.615000000000000e+02];
        temp0{4}=[24.3334;13.6667;132.5000];

       
     
        for i=1:4
            pop(i).bandb=temp0{i};
        end
        q1=[pop.bandb];
        x=q1(1,:);
        y=q1(2,:);
        z=q1(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '*' ,'markerfacecolor','green' , 'markeredgecolor','green');
        plot3(x,y,z,'or','Markersize',20, 'marker' , 's' , 'markeredgecolor','r');
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

        temp4=[Input.pesa2.Output.Paretolist2];
        for i=1:numel(temp4)
            pop(i).pesa2=temp4{i};
        end
        qqq1=[pop.pesa2];
        x=qqq1(1,:);
        y=qqq1(2,:);
        z=qqq1(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        plot3(x,y,z,'or','Markersize',15, 'marker' , 'diamond' , 'markeredgecolor','#FF00FF');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold on


        temp5=[Input.spea2.Output.Paretolist2];
        for i=1:numel(temp5)
            pop(i).spea2=temp5{i};
        end
        qqq2=[pop.spea2];
        x=qqq2(1,:);
        y=qqq2(2,:);
        z=qqq2(3,:);
        %plot3(x,y,z,'or','Markersize',15, 'marker' , '^' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        plot3(x,y,z,'or','Markersize',15, 'marker' , '+' , 'markeredgecolor','black');
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
        hold off


        
end