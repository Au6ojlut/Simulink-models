clear all;
Cx = [1 0 0 0; 0 0 1 0];
mu = 0.001;
eps = 1;
beta = 60;
gamma = 200;
iterator = 1;
for gamma= 30:10:148
    for beta = -170:40:170
        for eps=1:1
            for mu = 0:0.01:1

            A = [0 -1 0 0; 0 0 0 0; 0 0 0 -1; 0 0 0 0];
            B = (1/eps)*eye(4);
            C = (-eps*gamma^2*eye(4)+beta^2*Cx'*Cx-mu*eye(4));
                try  PPPP = are(A,B,C);
                catch
                    continue
                end 
%             P1 = PPPP(1,1);
%             P2 = det(PPPP(1:2,1:2));
%             P3 = det(PPPP(1:3,1:3));
%             P4 = det(PPPP);

            L = beta^2/2*PPPP^(-1)*Cx';
                 if (max(real(det(-A-L*Cx)))<0)
                    answers(1:4,iterator:iterator+2)=L;
                    realn(iterator)=max(real(det(-A-L*Cx)))
                    iterator = iterator+1;
                    disp(iterator)
                end
            end
        end
    end
end