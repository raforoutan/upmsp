function y=Randomsolution(input)

        J=input.J;
        Eligible=input.Eligible;
        K=input.K;
        
        y=zeros(3,J);
        
        y(1,:)=randperm(J);
        y(3,:)=randi(K,1,J);
        n=zeros(1,J);
        for i=1:J
           
           n(i)=numel(Eligible{y(1,i)});
           c=randsample(n(i),1);
           y(2,i)=Eligible{y(1,i)}(c);
        end
end