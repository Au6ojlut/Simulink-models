function [c, ceq] = noncon(u,Tc, iter,xk,xr)
n=length(xk);
%eps = 0.0001;
x0 = xk;
for i = 1 : iter
    uk = u(i,:);
    [tp, yp] = ode23(@(t,x) RobotSystem(t,x,uk),[0 Tc],xk);
    xk = yp(end,:);
    x_pred(:,i) = xk;
end
x_pred = reshape(x_pred(1:2:end,:),iter * n/2,1);
err_d = abs(xr - x_pred);
err_k = abs(xr - repmat(x0(1:2:end),iter,1));
c = err_d - err_k;
ceq = [];