function A = J(xk,xrr,u,Tp,Tc,iter)
n = length(xk);
for i = 1 : iter
    uk = u(i,:);
    [tp, yp] = ode23(@(t,x) RobotSystem(t,x,uk),[0 Tc],gather(xk));
    xk = yp(end,:);
    x_pred(:,i) = xk;
end
x_pred = reshape(x_pred,double(iter) * n,1);
u = reshape(u',iter*n/2,1);
x_err = (x_pred - xrr)*180/pi;
x_err(2:2:end) = x_err(2:2:end) * 0.005;
A =(x_err' * x_err)+u' * u;
end