function u = RobotOptControl(x,Tp,Tc,u0)
umax = [50 50];
umin = [-50 -50];
global iter xrr xr
ust = u0;
options = optimoptions('fmincon', 'Algorithm','sqp', 'MaxIter', 2000,'MaxFunEvals',15000, 'UseParallel', 'always');
[y,fval] = fmincon(@(u) J(x,xrr,u,Tp,Tc,iter),ust,[],[],[],[],repmat(umin,iter,1), repmat(umax,iter,1), @(u) noncon(u,Tc,iter,x,xr),options);
u = y;
end