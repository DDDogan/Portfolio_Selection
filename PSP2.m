x1 = optimvar('x1','LowerBound',0,'UpperBound',1); %set variables which also bounds variables, so includes non-zero constraint
x2 = optimvar('x2','LowerBound',0,'UpperBound',1);
x3 = optimvar('x3','LowerBound',0,'UpperBound',1);
linprob = optimproblem('Objective',x1+2*x2+3*x3); %objective function
linprob.Constraints.cons1 = x1+x2+x3==1; %constraint 1
linsol = solve(linprob); %solving using inbuilt MATLAB functions
x1=linsol.x1; %set solutions to print them
x2=linsol.x2;
x3=linsol.x3;
minr=x1+2*x2+3*x3;
fprintf('investing a fraction of %d into asset 1',x1);
fprintf(', a fraction of %d into asset 2',x2);
fprintf(' and a fraction of %d into asset 3',x3);
fprintf(' gives minimum return %d',minr);

