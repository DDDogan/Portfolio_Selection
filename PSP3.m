G=[0.00015, 0.00005, -0.00007 ; 
   0.00005, 0.00025, -0.00003; 
   -0.00007, -0.00003, 0.00010]; %Covariance matrix
mu=[0.11; 0.15; 0.08]; %matrix of expected returns

load('port5.mat','Correlation','stdDev_return','mean_return')
portprob = optimproblem;

nAssets = 3; r = 0.11; %no. assets and desired return

x = optimvar('x',nAssets,'LowerBound',0,'UpperBound',1); %variables


objective = 1/2*x'*G*x; %objective function
portprob.Objective = objective;

sumcons = sum(x) == 1; %sum of fractions =1 constraint
portprob.Constraints.sumcons = sumcons; 


averagereturn = x.'*mu == r; %returns = 0.11 constraint
portprob.Constraints.averagereturn = averagereturn;

options = optimoptions('quadprog','Display','iter','TolFun',1e-10);
tic
[nx,fval1] = solve(portprob,'Options',options);
toc

Risk=nx.x.'*G*nx.x; %Calculating Var[R]
fprintf('invest a fraction of %s into asset 1',nx.x(1,1));
fprintf(', invest a fraction of %s into asset 2',nx.x(2,1));
fprintf(', invest a fraction of %s into asset 3',nx.x(3,1));
fprintf(' with an associated variance %s',Risk);
bar(nx.x); %plot solutions
title('Fraction of investments into assets');
xlabel('Asset i where i=1,2,3');
ylabel('Fraction of investment into asset i where i=1,2,3');

