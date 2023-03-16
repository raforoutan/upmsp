function Input=CreateRandomModel(J,M,K)

      P=randi([5 15],J,M);
      D=randi([20 40],1,J);
      pi=unifrnd(0.5,1.5,1,K);
      w=randi([1 10],1,J);
      S1=randi([1 7],J,J,M);
      S=zeros(J,J,M,K);
      for m=1:M
          for k=1:K
            S(:,:,m,k)=pi(k).*S1(:,:,k);
          end
      end
      Cemployee=500;
      Eligible=cell(J,1);
      q=ceil(J/5);
      r=randsample(J,q);
      for j=1:J
          for i=r
              if j==i
                  Eligible{j}=randsample(M,M-1);
              else
                  Eligible{j}=1:M;
              end
          end
      end
        Precedence={[]
                    []
                    1
                    2
                    2
                    [1,3]
                    [1,3]
                    []};
      
      
      Input.P=P;
      Input.M=M;
      Input.J=J;
      Input.Eligible=Eligible;
      Input.D=D;
      Input.pi=pi;
      Input.S=S;
      Input.K=K;
      Input.C=Cemployee;
      Input.Precedence=Precedence;
      Input.w=w;
end