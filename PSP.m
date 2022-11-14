G=[0.00015, 0.00005, -0.00007 ; 
   0.00005, 0.00025, -0.00003; 
   -0.00007, -0.00003, 0.00010]; %Covariance matrix
mu=[0.11; 0.15; 0.08]; %matrix of expected returns
syms x1 x2 x3 lam1 lam2 %variables
x=[x1;x2;x3];
xT=x.';
Risk=1/2*xT*G*x; %Objective function
xT*mu==0.11; %constraint 1
x1+x2+x3==1;   %constraint 2
L=Risk+lam1*(0.11-(0.11*x1+0.15*x2+0.08*x3))+lam2*(1-(x1+x2+x3)); %L Function
Lx1=diff(L,x1); %partial derivative of L in terms of x1
Lx2=diff(L,x2); %partial derivative of L in terms of x2
Lx3=diff(L,x3); %partial derivative of L in terms of x3
Llam1=diff(L,lam1); %partial derivative of L in terms of lam1
Llam2=diff(L,lam2); %partial derivative of L in terms of lam2
eqn1=Lx1==0; %set all partial derivatives to 0, these are the first order conditions
eqn2=Lx2==0;
eqn3=Lx3==0;
eqn4=Llam1==0;
eqn5=Llam2==0;
sol=solve(eqn1,eqn2,eqn3,eqn4,eqn5,x1,x2,x3,lam1,lam2); %solve the system of first order conditions
x1=sol.x1;
x2=sol.x2;
x3=sol.x3;
lam1=sol.lam1;
lam2=sol.lam2;
Riska=eval(2*subs(Risk));

while 1
if x1+x2+x3==1 && 0.11*x1+0.15*x2+0.08*x3==0.11 %check that constraints are satisfied
    fprintf('invest a fraction of %s into asset 1',x1);
    fprintf(', invest a fraction of %s into asset 2',x2);
    fprintf(', invest a fraction of %s into asset 3',x3);
    fprintf(' the associated variance of this portfolio is given by %s',Riska);
    break
else
    disp('The constraints are not satified hence there are no solutions')
    break
end
end
bar([x1,x2,x3]); %plot solutions
title('Fraction of investments into assets');
xlabel('Asset i where i=1,2,3');
ylabel('Fraction of investment into asset i where i=1,2,3');
