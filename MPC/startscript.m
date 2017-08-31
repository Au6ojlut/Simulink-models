clear all;
t = 1.5; delta = 0.01;
Tp = 1;
xk(:,1)=[0;0;0;0];
xd = [pi/2;0;0;0];
mymax = 50;
global  iter xr xrr Tc
Tc = 0.05;
iter = double(int32(Tp/Tc));
xr = repmat(xd(1:2:end),iter,1);
xrr = repmat(xd,iter,1); % asdasd
first = (xd(1) - xk(1,1))*180/pi;
second = xd(3) - xk(3,1) + 0.3 *( xd(1) - xk(1,1))*180/pi;
u0 = [sign(first) * max(abs(first),mymax), sign(second) * max(abs(second),mymax)];
uk = u0;
for i= 2:iter
    uk = [uk; u0*(1-Tc*0.1)^double(i)];
end

for i = 1 : t/delta
    uopt= RobotOptControl(xk(:,i),Tp,Tc,uk);
    un(:,i) = uopt(1,:)';
    [tp, yp] = ode45(@(t,x) RobotSystem(t,x,un(:,i)),[0 delta],xk(:,i));   
    xk(:,i+1) = yp(end,:);
    uk = [uopt(2:end,:);uopt(end,:)*(1-Tc*0.1)];    
    fprintf('Step %d\n', i);
    fprintf('%d\n', xk(1:2:end,i+1)*180/pi);
    fprintf('%d\n', un(:,i));
end